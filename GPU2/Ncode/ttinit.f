      SUBROUTINE TTINIT
*
*       Read, scale and initialize the tidal tensors
*       --------------------------------------------------------
*** FlorentR - new subroutine
      INCLUDE 'common6.h'
      COMMON/GALAXY/ GMG,RG(3),VG(3),FG(3),FGD(3),TG,
     &               OMEGA,DISK,A,B,V02,RL2
            
      
* Reset
      NBTT = 0
      TTUNIT = 0.0
      TTOFFSET = 0.0
      DO I=1,NBTTMAX
        TTTIME(I) = 0.0
        DO J=1,3
          TTENS(J,1,I) = 0.0
          TTENS(J,2,I) = 0.0
          TTENS(J,3,I) = 0.0
        END DO
      END DO
*** JeremyW - comment out to keep RTIDE in the input file
* Set the tidal radius to an arbitrary constant since it is not known
* in the general case
*      RTIDE = 10.0*RSCALE
*      RTIDE0 = RTIDE
*** JWebb

* Ensure there is no other component
!      GMG = 0.0
!      GMB = 0.0
!      OMEGA = 0.0
!      DISK = 0.0
!      A = 0.0
!      B = 0.0
!      V02 = 0.0
!      RL2 = 0.0
!      TIDAL(4) = 0.0D0
!      MP0 = MP
!      AP2 = 0.0
!      MPDOT=0.0
!      TDELAY=0.0
      GMG = 0.0
      OMEGA = 0.0
      DISK = 0.0
      TIDAL(4) = 0.0D0



* Set the TTMODE: true  = Mode A (table of tensors)
*                 false = Mode B (analytical galactic potential)
      INQUIRE(FILE='tt.dat', exist=TTMODE)

      IF(TTMODE) THEN
************************** TTMODE A

* Read the tt.dat file
        OPEN (UNIT=20,STATUS='UNKNOWN',FORM='FORMATTED',FILE='tt.dat')
        READ(20,*), NBTT, TTUNIT, TTOFFSET

        IF (NBTT.GT.NBTTMAX) THEN
          WRITE (6,*) '*** ERROR: increase NBTTMAX in param.h'
          STOP
        END IF
      
        DO I=1,NBTT
          READ(20,*), TTTIME(I),
     &          (TTENS(J,1,I),TTENS(J,2,I),TTENS(J,3,I),J=1,3)
        ENDDO
        CLOSE(20)

        WRITE (6,10) NBTT, TTOFFSET, TTUNIT
   10   FORMAT (/, 12X,'TIDAL TENSORS READ: ',I10,
     &        '   TIME OFFSET: ',F9.3,
     &       '   GALACTIC TIME: ',F9.3)
        CALL FLUSH(6)

* Scale the tidal tensor, using TTUNIT i.e. the time unit of the
** galactic run, in Myr  
        DO K=1,NBTT
* scale time
          TTTIME(K) = TTTIME(K)*(TTUNIT/TSTAR)+TTOFFSET/TSTAR
          DO I=1,3
            DO J=1,3
* scale tensor components
              TTENS(I,J,K)= TTENS(I,J,K)*(TSTAR/TTUNIT)**2
            END DO
          END DO
        END DO

* Check the tensors are defined for the entire run      
        IF(TIME+TOFF.LT.TTTIME(1)) THEN
          WRITE(6,*) '*** ERROR: the tidal tensor is not defined at t0'
          STOP
        END IF

        IF(TCRIT.GT.TTTIME(NBTT)) THEN
            WRITE (6,*) '*** WARNING: the tidal tensor is undefined ',
     &           'after t=', TTTIME(NBTT)
        END IF

* Initialisation of tidal tensor and derivatives
        DO I=1,3
          DO J=1,3
            TTEFF(I,J) = 0.0
            DTTEFF(I,J) = 0.0
          END DO
        END DO
        CALL TTCAL
          
      ELSE
************************** TTMODE B

        IF (NBTTMAX.LT.1) THEN
          WRITE (6,*) '*** ERROR: set NBTTMAX to 1 in param.h'
          STOP
        END IF
        
        READ (5,*)  (RG(K),K=1,3), (VG(K),K=1,3)
        DO I=1,3
          RG(I) = RG(I)*1000.0/RBAR
          VG(I) = VG(I)/VSTAR
        END DO

        WRITE (6,20)  RG(1), RG(2), RG(3), VG(1), VG(2), VG(3)
   20   FORMAT (/,12X,'TIDAL TENSOR MODE B:  RG =',1P,E10.3,E10.3,E10.3,
     &    ' VG =',E10.3,E10.3,E10.3)

      END IF

*** FRenaud

      RETURN
      END
