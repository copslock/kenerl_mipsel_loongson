Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EII6101809
	for linux-mips-outgoing; Fri, 14 Sep 2001 11:18:06 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EIHqe01804
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 11:17:52 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id CEEBA125C3; Fri, 14 Sep 2001 11:17:51 -0700 (PDT)
Date: Fri, 14 Sep 2001 11:17:51 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: GNU C Library <libc-alpha@sourceware.cygnus.com>
Cc: linux-mips@oss.sgi.com
Subject: PATCH: Update sysdeps/mips/fpu/libm-test-ulps
Message-ID: <20010914111751.A17316@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a patch for sysdeps/mips/fpu/libm-test-ulps. BTW, I got many
math failures on Linux/mipsel. Has anyone else seen them?


H.J.
----
2001-09-14  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/fpu/libm-test-ulps: Updated.

--- sysdeps/mips/fpu/libm-test-ulps.mips	Fri Apr 27 21:25:17 2001
+++ sysdeps/mips/fpu/libm-test-ulps	Fri Sep 14 11:01:52 2001
@@ -7,7 +7,7 @@ ifloat: 2
 Test "asin (0.5) == pi/6":
 float: 2
 ifloat: 2
-Test "asin (0.7) == 0.7753974966107530637":
+Test "asin (0.7) == 0.77539749661075306374035335271498708":
 double: 1
 float: 2
 idouble: 1
@@ -175,12 +175,12 @@ idouble: 1
 Test "Imaginary part of: cexp (-2.0 - 3.0 i) == -0.13398091492954261346140525546115575 - 0.019098516261135196432576240858800925 i":
 float: 1
 ifloat: 1
-Test "Real part of: cexp (0.7 + 1.2 i) == 0.7296989091503236012 + 1.8768962328348102821 i":
+Test "Real part of: cexp (0.7 + 1.2 i) == 0.72969890915032360123451688642930727 + 1.8768962328348102821139467908203072 i":
 double: 1
 float: 1
 idouble: 1
 ifloat: 1
-Test "Imaginary part of: cexp (0.7 + 1.2 i) == 0.7296989091503236012 + 1.8768962328348102821 i":
+Test "Imaginary part of: cexp (0.7 + 1.2 i) == 0.72969890915032360123451688642930727 + 1.8768962328348102821139467908203072 i":
 float: 1
 ifloat: 1
 
@@ -249,7 +249,7 @@ float: 1
 ifloat: 1
 
 # cos
-Test "cos (0.7) == 0.7648421872844884262":
+Test "cos (0.7) == 0.76484218728448842625585999019186495":
 double: 1
 float: 1
 idouble: 1
@@ -374,7 +374,7 @@ double: 2
 float: 1
 idouble: 2
 ifloat: 1
-Test "exp10 (0.7) == 5.0118723362727228500":
+Test "exp10 (0.7) == 5.0118723362727228500155418688494574":
 float: 1
 ifloat: 1
 Test "exp10 (3) == 1000":
@@ -451,6 +451,21 @@ ifloat: 2
 Test "j0 (8.0) == 0.17165080713755390609":
 float: 1
 ifloat: 1
+Test "j0 (4.0) == -3.9714980986384737228659076845169804197562E-1":
+double: 1
+float:  1
+idouble: 1
+ifloat:  1
+ildouble: 1
+ldouble: 1
+Test "j0 (-4.0) == -3.9714980986384737228659076845169804197562E-1":
+double: 1
+float:  1
+idouble: 1
+ifloat:  1
+ildouble: 1
+ldouble: 1
+
 
 # j1
 Test "j1 (10.0) == 0.043472746168861436670":
@@ -563,7 +578,7 @@ idouble: 1
 ifloat: 1
 
 # sincos
-Test "sincos (0.7, &sin_res, &cos_res) puts 0.76484218728448842626 in cos_res":
+Test "sincos (0.7, &sin_res, &cos_res) puts 0.76484218728448842625585999019186495 in cos_res":
 double: 1
 float: 1
 idouble: 1
@@ -573,7 +588,7 @@ double: 1
 float: 0.5
 idouble: 1
 ifloat: 0.5
-Test "sincos (M_PI_6l*2.0, &sin_res, &cos_res) puts 0.866025403784438646764 in sin_res":
+Test "sincos (M_PI_6l*2.0, &sin_res, &cos_res) puts 0.86602540378443864676372317075293616 in sin_res":
 double: 1
 float: 1
 idouble: 1
@@ -583,7 +598,7 @@ double: 0.2758
 float: 0.3667
 idouble: 0.2758
 ifloat: 0.3667
-Test "sincos (pi/6, &sin_res, &cos_res) puts 0.866025403784438646764 in cos_res":
+Test "sincos (pi/6, &sin_res, &cos_res) puts 0.86602540378443864676372317075293616 in cos_res":
 float: 1
 ifloat: 1
 
@@ -605,6 +620,13 @@ double: 1
 float: 1
 idouble: 1
 ifloat: 1
+Test "tanh (-0.7) == -0.60436777711716349631":
+double: 1
+float: 1
+idouble: 1
+ifloat: 1
+ildouble:  1
+ldouble:  1
 
 # tgamma
 Test "tgamma (-0.5) == -2 sqrt (pi)":

--FCuugMFkClbJLl1L
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="test-float.out.gz"
Content-Transfer-Encoding: base64

H4sICJ1GojsCA3Rlc3QtZmxvYXQub3V0AN2azW7bOBSF934KoosiQSKXkuOJFaDLKdBNF8Xs
B7RM2QxkUqGoiTVPP6T8E8ppC4SHigf1IrFkn4+Xh5dXpCXDGyPkmpSVYoZcPQuzUa0hQlZC
clK2sjBCyeZ68oWJqtX8gbBCNeTqG/t2TT5/Jvb/A/lzV/DafY98+Cr/YZVYEVVzzdypD6Th
xlM3QgJqw0B11stvSSgD6jzUdys+Nn5LPtqjvzVv7Dt70r27JnVrGke1g0cOH7+pAcxb2+IG
GxpAbj3YQM4CaixyvqshcUoheQapt2m4vFJrJHYnryF5BqmXQLoVrLJyGl6EDoQUJvS1JP0f
xEAv62Qfg5AlwrDyOHFADIkPaoUxiqU24ZOjZEvgArvpamXOhsIehDCSGJBBXiGMJAYk1NVa
PQ+maRqoTjA5FD4F9Ukaw78U1CcAYDZF6uQTMqn/spuMHzAm33nTVuZhQoRdqZ5e2TSb59l8
Pltk6Ywu7tM5pQvKb9Lcfkh36XSWLxacDl/1zR93E9LYzUu1IkvucNKuZ/u/590InUu/lQlZ
RvM+hrv7ty37dAmsGXVZhKvXbLtlwKoN1BtQX3BRARfGSikdLpec6WUnJJDARrcSGL1yq1Zg
Jdd8y4RccY1znlr1ArG76F3gvrPuGrG2C6YEWMaeUxIaOMQ7w0pzciedpijHIsJdPo8H4Rj1
zPQqQseOILhng4iC58RKbKG1yR6Qo4AEJvQ25CggQQjQBuzgQwQGtJf0vYjACK/VbDfISxog
93IqD5D7OZmEALyKTEPleXD4fj4HhQ/tPw8WDhhJGATaw/peHBlIHOEJ7X56BxLayYGEdnIo
oYWEEvokz4PDhxLaAcCE7i1EE/rUkfCEfvECSOgTBKjQB0Lm9vV2cx+OSQ+/DIRjiv5XO+cD
udnfggoyNyrG6X3KW/v0nbOK1MzulVXpmP3Nt/PQ9o24s4LUVduQfh2vSvIv1+qTOy+VIU3N
C1EKvsIDSC4eAR00X4tP2fFEhN6NCfecOjmX7I/jwJMz+E1M+Osxf7stBdPr+BPjeFf7lbkx
+n+CJyOMnBc5bu4Z3Bs4OqUDdn889mT1svKSrfs54ZWuSD0bjz1ORmxeX0HiBb758aUzHn0k
X5R8HI19vHVyZN2SkRrySslFprtXJy/Z+k8uAe/Y+8u2P05m2bnnhtGHe8fv0LnNq6XZu7f/
i8r2TgZcPIJflJc48GHt6I9iRR19WhyfVhyJHTHwR+Axt0fgCbtHCd1acPIUk8/A1oHoO8D0
DjC9w0zvMNM7zPQuzPSJe7SBNK0w3K7mtnXFjS13E0Kyu8UdMe5Du9fizb5KZtmC9icbUipN
+AlfVmzd2GNetFY/tfp0fk+41ko3RBVFq7U7/R9y/CqZsi4AAA==

--FCuugMFkClbJLl1L
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="test-double.out.gz"
Content-Transfer-Encoding: base64

H4sICBNHojsCA3Rlc3QtZG91YmxlLm91dADNm02P0zAQhu/7KywOiBXr4nSFRJH2CBIXDog7
clOn9SqNs7bDNvx67HyUfCyV8HgaTtukO48n70zGYye1wlhZ7MlOVdtckDfP0h5UZYksclkI
klVFaqUqzO3NZy7zSouPhFtekDdf+ddb8vBA3N+P5NMpFaX/P/LqS/GT53JHVCk096deESPs
2HrdmN+RUEaqTLgDRhYg437wO/LaHf3QwrhP7qT/dEvKyhpPdQKS7ut/GgCmrRvxAAsNwNxp
cAApC7CGeS5OJcg4YSDzNcj6mISb52oP8d2blyDzNch6C0i3lOfOnIUXoY6QgAlNLUn+Ax/Y
sko2PsgigzCceRw/QIwCHtQcxki32obfHBnfAibYQ10qOwmFOwhh0BiQUV5BGDQGJDixniAR
hVkLnYGM03DrPT8eOWCSANpboH0qZA64D3OldLh5Ibje1rIARN5qtwAAXMBR7YB5r8XxqVJ/
IK7ZPgW2p2Vt5N7VVQqY7aYUygJDc7I8s0L3VX6VQDkOEa7y1B8Ix6pnrncRLqwHga9s5FFw
Lu/kEdTmtIANFEDBhEaGDRRAIQRQn9bpEIEBajmHWkRghNdYfhrlJQswH+TUJsB8mJM0BDCo
yCzUfBPs/jCfg9wHtamdhCMGDYOAWt2hFj0D4kd4QvsdOkBCe3NAQntzUELLApTQZ/NNsPug
hPYAYEI3EkIT+nwh4Qn9RwtAQp8hgArdEdYrl9b3KxaOSVasa4NDMWmzuPc6kLftTnWQuFEx
3n5I+ddr+iZ4Tkru1rgq88xmj37qWjuIPytJmVeGNH28ysgvodU7f75wq3RTilRmUuzgDtDF
PWCj4Uv5bt2fiHB1mPCBUmflaHscB04n8Lcx4fOYR5HlMM/pwXEEOsXFM0RhKCZ8mo1xZZmm
Y3x6DGVSrvfxC3X/MHZ2s8e4H89wilBJTNcmLVbgTd9kLesBVr1rnwdjFaSWPlOPxuVfqBvX
CM7l2nJFDzDyo39RwsHYio3gLBaaEjaqGiyez9NqF9Hnaa2LgvYao4WRMuwUQYHPWpqBSBHY
E1VoTPa08EX2fFZXY9LPNwxCPOd3fWy/o2fiYNUxK4T+GLvOD5ZUS46O0J+/uFiMyX65qF5P
N7rs8Hg3xGFpbQ8Li4vXOuPuFAzXrEtVs8Oy5Qxvpmhec0UKXP8KLYbf3VuqSJ53dIqLR5qi
BnSKSscJK2ZQUUOKGVDMcKIFUxWPaOxSPY/YdwRpoMGG1iKTz2DDcsnR/7IXe8WrX278adsY
aWHcbtZiLOgxN2HbHbwLklwhJPNO+urjX5hGriTA4h5cKIpx4JG3WlH3ntuX6Zd89NJ6gNTe
nH8rgKEd5p5s3G22R8AP4x4Bv8l7LEBvGXvzBGZ+Dxwd4H0NEL0GiF7DRK9hotcw0esw0W++
C+PqUSWtcP37scyFdVXphpD1e5YQ679MuRGmLWbr9YdNc9KQTGkizvgs53vjjkVaOfuVs082
90RorbQhKk0rrf3p37WGOb5pPgAA

--FCuugMFkClbJLl1L
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="test-fenv.out.gz"
Content-Transfer-Encoding: base64

H4sICA9coTsCA3Rlc3QtZmVudi5vdXQA7ZpfT9pgFIfv/RQn3mwmi5tLduMd05KYMTDKmNuN
qe2LvkltTd+ibp9+bSnFGSgltFLg8cIYfWnP7/zh/J5iX5noWM58HWnb8/5I/E3Us6MeIh34
RsxdMPJcuVHieMoOlbsncm4bcyzW5JDsn54Nvv76bV309kUb8YNIjIpmHTzrDlqds9PFx6yr
1kl/0bEf3VProt3p/Vx0sDeYca6fCr8IRr6r/Vtxdaic9PhUso6zYnv6r3IlCsRP9JvpDfKX
3geuSq7c73Wt1oV12T/MLj5U46Slkcj7tnXd6nSurasT67x/ME6oeZXwLUvvUIW2NmpOBtK/
LZ+BEupLKC+luoziqdpLFX08SaoqsdA85uPkhAw9+/aDPOnoTpIuKsrn0mqbUet56tM+z/Sn
0m3PBDLyS6nfqG5fpv5V1b5Znf6y1vGPj2oJsSVL3QDBWTgrDnZ1et+yrXPtOzrWhbXfoqGe
WedlR7q6EtcvN73X24x0lZoraelM+86OdEHtt2qkZ9S5hpGusrwryM0vtPahXl5SQbe+kLXm
ea18EBdUbItGcU4R1zOMlZZ3juDJmYbNYmWqtm0Ui+u1RZM4u4QNHsTlC2sPIxULU/FvlP+Y
PoXr9r63Lr9dW93BgTyEgaNM8iDuSXue2DdBmNwh+Xq6U/6MZ3i59oPkZo7teco93GOTsEnY
JGwSNgmbZLVNItK2tXcs5+Priatd/10UJ9FROk6m0be+HV/ed0U960i5434ykR2NjHw5+nw4
P9zTdmdmrIlONh+bj83H5mPzsfnYfCXjHSdxEm8WlR+E98l/E43DMTIMkmCUb9942TXjo5Fz
OA4/aZf/Pkd+JcLVJnnh6zDgVrY325vtzfZme7O9d3V7V53zcuHyuADDgeHAcGA4MBwYDgxH
sw1HqbTX0LTZLGJ+MD+YH8wP5gfzg/nB/Oyu+Wluy2LVsGpYNawaVg2rhlXDqmHVNsqqVdqw
2Q0K6p+HwDNBjCZGE6OJ0cRoYjQxmhhNjGaDjWadrTovVB7A4ovxxfhifDG+GF+ML8YX44vx
xfUnu5Y2TfcBHh2PjkfHo+PR8eh4dDw6Hh2PjkdvsEdvcptCFBAFRAFRQBQQBUQBUUAUEAVE
AVFUSRQVt2l6g8LaZyHwCQs8BA/BQ/AQPAQPwUPwEDwED8FD8FCTcl0mVD7OAt/AN/ANfAPf
wDfwDXwD38A38A1823Z8W1eb5p4EmAQmgUlgEpgEJoFJYBKYBCaBSWASmAQmV4PJ5jYq8Av8
Ar/AL/AL/AK/wC/wC/wCv8Av8Av87ij8Vtqq+S0KOuBFGHx6DcAD8AA8AA/AA/AAPAAPwAPw
ADwAD8AD8DsE8HU27PxwV0r7Ou65rkGZ+HISsBlvFNRrC+pV6fv65A4FLTANgjcIGm4TG65O
FzE3WN6SmRAmpK4JWZjxvaNPosIwCI0EjjMKw+RV/wDYC1eOfNEAAA==

--FCuugMFkClbJLl1L--
