*       NBODY6 parameters.
*       ------------------
*
*       Choose between small or large run.
*     PARAMETER  (NMAX=240020,KMAX=20,LMAX=500,MMAX=5,
*     PARAMETER  (NMAX=130010,KMAX=10010,LMAX=500,MMAX=50,
      PARAMETER  (NMAX=102010,KMAX=1010,LMAX=500,MMAX=50,
*     PARAMETER  (NMAX=65566,KMAX=3010,LMAX=500,MMAX=10,
*     PARAMETER  (NMAX=65566,KMAX=10,LMAX=500,MMAX=10,
*     PARAMETER  (NMAX=34010,KMAX=2010,LMAX=500,MMAX=100,
*     PARAMETER  (NMAX=25020,KMAX=1010,LMAX=300,MMAX=10,
*      PARAMETER  (NMAX=4010,KMAX=1010,LMAX=200,MMAX=10,
*** FlorentR - maximum number of tensors to read
*     &            MLD=22,MLR=22,MLV=10,MCL=10,NCMAX=10,NTMAX=100)
     &     MLD=22,MLR=22,MLV=10,MCL=10,NCMAX=10,NTMAX=100,
     &     NBTTMAX=1000000,
*** FRenaud
*
*      BEGIN NBODY6MP
     &     NPOPSMAX=2)
*      END NBODY6MP
*
*       ------------------------------------------------------
*       NMAX    Maximum number of single bodies + 3*NBIN + NHI.
*       KMAX    Maximum number of KS solutions.
*       LMAX    Maximum size of neighbour lists.
*       MMAX    Maximum number of merged binaries.
*       MLD     Maximum number of disrupted KS components.
*       MLR     Maximum number of recently regularized KS pairs.
*       MLV     Maximum number of high-velocity particles.
*       MCL     Maximum number of interstellar clouds.
*       NCMAX   Maximum number of chain members (do not change).
*       NTMAX   Maximum number of circularizing binaries.
*       BEGIN NBODY6MP
*       NPOPSMAX Maximum number of sub-populations
*       END NBODY6MP
*       ------------------------------------------------------
*
