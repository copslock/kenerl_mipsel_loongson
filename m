Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA87245 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 Jan 1999 11:32:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA14061
	for linux-list;
	Mon, 18 Jan 1999 11:31:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA79753
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 Jan 1999 11:31:50 -0800 (PST)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from mdaxp1.umassd.edu (MDAxp1.UMassD.Edu [134.88.120.66]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05463
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 14:31:49 -0500 (EST)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from us08-568b-1.res.umassd.edu by umassd.edu (PMDF V5.1-12 #22746)
 with ESMTP id <01J6OTWQPHNQ8WWIJ9@umassd.edu> for linux@cthulhu.engr.sgi.com;
 Mon, 18 Jan 1999 14:31:47 EST
Received: from matthias by us08-568b-1.res.umassd.edu with local
 (Exim 1.92 #1 (Debian)) id 102KOJ-0000Gb-00; Mon, 18 Jan 1999 14:31:15 -0500
Date: Mon, 18 Jan 1999 14:31:14 -0500
From: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Subject: compiling kernel
To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Message-id: <19990118143114.A988@fmc-container.mach.uni-karlsruhe.de>
MIME-version: 1.0
X-Mailer: Mutt 0.93i
Content-type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-md5; boundary=FCuugMFkClbJLl1L
Mail-Followup-To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

I try to compile my own kernel for my Indy.
I got the sources from cvs yesterday and made=20

 make config
 make dep
 make clean
 make vmlinux

It compiles fine but it will not boot. I get the following message:

>> boot vmlinux                                                            =
                                                          =20
115360+19600+3136+334528+42744d+4248+6368 entry: 0x89fa8840                =
                                                          =20
                                                                           =
                                                          =20
Exception: <vector=3DUTLB Miss>                                            =
                                                            =20
Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=3D???,MODE=3DKERNEL,EXL,IE>=
                                                              =20
Cause register: 0x8008<CE=3D0,IP8,EXC=3DRMISS>                             =
                                                              =20
Exception PC: 0x8810fa1c, Exception RA: 0x8800260c                         =
                                                          =20
exception, bad address: 0x7                                                =
                                                          =20
Local I/O interrupt register 1: 0x80 <VR/GIO2>                             =
                                                          =20
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):            =
                                                          =20
  arg: 7 89fff938 89fffc40 880025dc                                        =
                                                          =20
  tmp: 8816010c 8816010c 10 881189c8 14 89fad9e0 0 48                      =
                                                          =20
  sve: 89fdf3e8 89fffc40 89fb2720 89fff938 a8747420 9fc56394 0 9fc56394    =
                                                          =20
  t8 48 t9 89fffe54 at 1 v0 0 v1 89fff890 k1 bad11bad                      =
                                                          =20
  gp 881bc4a0 fp 9fc4be88 sp 89fff890 ra 8800260c                          =
                                                          =20
                                                                           =
                                                          =20
PANIC: Unexpected exception                                                =
                                                          =20

I used the Indy running Linux 2.1.121 from ftp.linux.sgi.com/pub/test
and egcs-1.0.2 from hardhat and also my i586 with the crosscompiler
from ftp.linux.sgi.com with the same results.
The vmlinux-indy-2.1.121.tar.gz boots fine.

What am I doing wrong?

Regards
 Matthias

--=20
Matthias Kleinschmidt
Cedar Dell 568B, Box 5398
UMass Dartmouth
285 Old Westport Rd.
North Dartmouth, MA 02747
email: matthias@fmc-container.mach.uni-karlsruhe.de

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQCVAwUBNqOMAsXMHXe35ITFAQG4EAP9H+R5hAV508OXOqdx5ypxn/38W2iFtZVM
BtDsrGgwEHfewj3aqMSngDGSlSym9NiMsgYMYCaqX8UxQ/e1JqqAfIxe4sZCobJa
xkIMEOMvZh7FyaOtZMBSwxK+fDii7APILzCVKLmV9f7rXPm32L8pswIqAQ2Vl3md
y4Felz42v2s=
=jZN3
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
