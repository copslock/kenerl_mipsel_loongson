Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 18:07:23 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:44773 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225237AbUEKRHW>; Tue, 11 May 2004 18:07:22 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id B247A4B6A1; Tue, 11 May 2004 19:07:20 +0200 (CEST)
Date: Tue, 11 May 2004 19:07:20 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: [Semi-OT] Example on how to use crosstool.sh
Message-ID: <20040511170720.GV1912@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q/AGl/UrDvkbRExF"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--Q/AGl/UrDvkbRExF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Here's an example on how I use Dan Kegel's crosstool.sh script:

-----------------------------------------------------------
#!/bin/sh

PREFIX=3D/home/jbglaw/cross_jb/install    \
BUILD_DIR=3Dxx_build                      \
SRC_DIR=3D.                               \
BINUTILS_DIR=3Dbinutils-2.15.91           \
GCC_DIR=3Dgcc-HEAD-20040509               \
GLIBC_DIR=3Dglibc-2.3.2                   \
LINUX_DIR=3Dlinux-2.6.x                   \
TARGET=3Dalpha-linux                      \
TARGET_CFLAGS=3D"-O -g"                   \
BUILD=3D`/usr/share/misc/config.guess`    \
USE_SYSROOT=3Dyes                         \
PARALLELMFLAGS=3D"-j2"			\
KERNEL_CONFIG=3Dconfig-alpha              ./crosstool.sh
-----------------------------------------------------------

PREFIX		is where all your crosscompiler tools will be
		installed into

BUILD_DIR	is where some subdirs will be created to build all
		the parts. You need some MBs free there:)

SRC_DIR		This is where all the source sub-directories
		(GCC_DIR, GLIBC_DIR, LINUX_DIR, BINUTILS_DIR) are in

GCC_DIR, GLIBC_DIR, LINUX_DIR, BINUTILS_DIR
		Subdirs within SRC_DIR that contain the actual sources

TARGET		Guess it:)

TARGET_CFLAGS	CFLAGS used to for the toolchain to be created. "-O -g"
		to have them optimized, as well as keep debug infos (in
		case the compilers crash, you may want to help toolchain
		people to debug the problem).

USE_SYSROOT	Internal flag, which changes the destination directory
		for some target-relevant files. I admit I haven't yet
		understood that throughoutly:)

PARALLELMFLAGS	Have a SMP machine?

KERNEL_CONFIG	A ./linux/.config file for the kernel in LINUX_DIR. Used
		to get proper kernel header files.

BUILD		This machine's GNU quadrupel. Call config.guess to get
		it; if you don't supply it, crosstool.sh will try to
		call ./config.guess, which doesn't exist if you copy
		crosstool.sh out of Dan Kegel's distribution:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--Q/AGl/UrDvkbRExF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoQhIHb1edYOZ4bsRAmQMAJ9wRMpdaix6ZNhfrAZ2nbI/GXIs5ACfflB5
uYMRA0A1lET1kn2z/QSU86Y=
=XUpE
-----END PGP SIGNATURE-----

--Q/AGl/UrDvkbRExF--
