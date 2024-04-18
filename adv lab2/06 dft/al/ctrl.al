# This is an input file for Al, with comments documenting the input.
# Lines beginning with '#' are comment lines.

# Version control
VERS    LMF-6 LMASA-6 LM:7 ASA:7 FP:7
IO      SHOW=f HELP=F VERBOS=31,30 WKP=F IACTIV=0

# Variable declarations used as input in other categories
#   a is the lattice constant for Al, in a.u.
#   nk    number k-points divisions for BZ integrations
#   dist  parameter defining lattice shear; see SHEAR below
#   bzj   0=> k-points include gamma; 1=> k-points offset from gamma; see BZJOB
#   vol   cell volume
#   avw   average WS radius
#   rmt   MT radius.  It corresponds to about 0.6% sphere overlap for the
#                     undistorted case.  lmf can handle up to about
#                     10% overlaps with negligible loss in accuracy.
#   gmax  energy cutoff for specifying FT mesh
CONST   a=7.606 da=0
        nk=12 dist=0 bzj=1
        vol=a^3/4 avw=(3/4/pi*vol)^(1/3) rmt=.91*avw
        gmax=7 nit=10
STRUC   NBAS=1 NSPEC=1
        ALAT=a PLAT=  .0 .5 .5  .5  .0 .5  .5 .5  .0
        DALAT=da
SITE    ATOM=A POS= 0 0 0
#  KMXA  defines the cutoff in the polynomial expansion of augmented basis functions.
#        (If not specified, a default is chosen.) KMXA=4 is a rather strict cutoff.
#  A=    parameter defining radial mesh for tabulation of augmented w.f. and density
#  EREF= reference energy, subtracted from the total energy.
#  RSMG= smoothing radius used in electrostatics
#  RFOCA=smoothing radius used in fitting core tails
#  LFOCA=1=> frozen core with tails expanded into the interstitial
#        2=> frozen core with xc pot from tails treated in perturbation theory
#  LMXA= l-cutoff for the basis function in augmentation spheres.
#
#  RSMH,EH, RSMH2, EH2 below define the basis set.
#  NB: the %const construct defines variables in a manner similar to the
#  CONST category above.  But variables defined with the %const or %var
#  are defined for the preprocessor stages, and are cleared once the
#  preprocessor is complete.  See doc/input-file-style.txt
SPEC    ATOM=A Z=13 R=rmt
        KMXA=4
        A=.025
        EREF=-483.5463
# The following line is not needed since these are the defaults.
        RSMG=.25*rmt RFOCA=0.4*rmt LFOCA=2 LMXA=2 LMX=2

% const rsm1=1.8 rsmd1=1.8 ed1=-.1
        RSMH={rsm1},{rsm1},{rsmd1} EH=-.1,-.1,{ed1}
%ifdef bigbas
% const rsm2=1.8
        RSMH2={rsm2},0,{rsmd1} EH2=-1,-1,-1
%endif
HAM     FORCES=0 XCFUN=2 ELIND=-1 TOL=1e-6 NSPIN=1 REL=t QASA=0
#         GMAX=gmax
        FTMESH=10 10 10
% const hf=f
OPTIONS NSPIN=1 REL=t XCFUN=2 HF={hf}
BZ      NKABC=nk BZJOB=bzj N.W=.002 NPTS=1001 SAVDOS=t
        EF0=0 DELEF=.1 TETRA=t DOS=0-1 0+.5 METAL=2
% ifdef hf
        NEVMX=-1
% endif
EWALD   AS=2.0 TOL=1D-8 ALAT0=a NKRMX=600 NKDMX=600
ITER    MIX=A3 CONV=1e-6 CONVC=1e-5 NIT=nit


