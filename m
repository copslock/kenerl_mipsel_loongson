Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 14:54:37 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:22055
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8224931AbUIWNyb>; Thu, 23 Sep 2004 14:54:31 +0100
Received: (qmail 29159 invoked from network); 23 Sep 2004 23:54:20 +1000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 23 Sep 2004 23:54:20 +1000
Message-ID: <4152D58B.608@longlandclan.hopto.org>
Date: Thu, 23 Sep 2004 23:54:19 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Kernel 2.6 for R4600 Indy
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070400090104030606090106"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070400090104030606090106
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi All,
	I've been trying to get Linux 2.6 going on my Indy for some time now.
However, I've had little success.  The machine works just fine under
Linux 2.4.26.

	The kernel config is attached.  Basically I've tried both booting a
MIPS32 kernel as well as a MIPS64 kernel.  In all cases, I've used the
same kernel parameters.  (root=/dev/hda3, and sometimes I put
init=/bin/sh or single there too.)

	Using a MIPS32 config, the kernel boots, mounts the / filesystem, but
then dies claiming it can't find /sbin/init.

	Using a MIPS64 config (built using gas-abi=o32 as suggested by Kumba),
it doesn't even get that far:

- From arcboot/SGI PROM:
(Arcboot version 0.3.8.2)
- -------------------------------8<--------------------------------------
Loading program segment 2 at 0x88002000, offset=0x0, size= 0x0 328085
Zeroing memory at 0x0032a085, size = 0x1bba3

Exception: <vector=Normal>
Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x8010<CE=0,IP8,EXC=RADE>
Exception PC: 0x830f018, Exception RA: 0x88804514
Read address error exception, bad address: 0x830f018
Local I/O interrupt register 1: 0x80 <VR/GIO2>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: a8740000 88002000 88001fe0 18
  tmp: a8740000 3 8880e0b4 830f018 8880e0b0 887fe8ec 887fe5e4 4
  sve: a8740000 3 400000 800000 16 3f80 0 10000000
  t8 a8740000 t9 ffffffff at ffffffff v0 ffffffff v1 ffffffff k1 830f018
  gp a8740000 f0 ffffffff sp ffffffff ra ffffffff

PANIC: Unexpected exception

[Press reset or ENTER to restart.]
- ------------------------------->8--------------------------------------

	Now, according to the Linux-MIPS website:
- -------------------------------8<--------------------------------------
*Self-compiled kernels crash when booting.*

When I build my own kernel, it crashes. On an Indy the crash message
looks like the following (the same problem hits other machines as well
but may look completely different):

 Exception: <vector=UTLB Miss>
 Status register: 0x300004803<CU1,CU0,IM4,IPL=???,MODE=KERNEL,EXL,IE>
 Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
 Exception PC: 0x881385cc, Exception RA: 0x88002614
 exception, bad address: 0x47c4
 Local I/O interrupt register 1: 0x80 <VR/GIO2>
 Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
   arg: 7 8bfff938 8bfffc4d 880025dc
   tmp: 8818c14c 8818c14c 10 881510c4 14 8bfad9e0 0 48
   sve: 8bfdf3e8 8bfffc40 8bfb2720 8bfff938 a8747420 9fc56394 0 9fc56394
   t8 48 t9 8bfffee66 at 1 v0 0 v1 8bfff890 k1 bad11bad
   gp 881dfd90 fp 9fc4be88 sp 8bfff8b8 ra 88002614

 PANIC: Unexpected exception

This problem is caused by a still unfixed bug in Binutils newer than
version 2.7. As a workaround, change the following line in
arch/mips/Makefile from:

       LINKFLAGS       = -static -N
to:
       LINKFLAGS       = -static
- ------------------------------->8--------------------------------------

	This looks scaringly similar to what I've already struck.  Certainly
the Status Register is almost identical.  I've also had it come up UTLB
Miss as well.

	It seems though, the fix is more illusive.  Looking at
arch/mips/Makefile, there's no LINKFLAGS line.  The closest thing I see
is LDFLAGS_vmlinux:

LDFLAGS_vmlinux                 += -G 0 -static -n

The binutils/gcc versions I'm using are cross compillers generated using
crossdev:

MIPS32 binutils:
GNU assembler 2.14.90.0.8 20040114
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `mips-unknown-linux-gnu'.

MIPS64 binutils:
GNU assembler 2.14.90.0.8 20040114
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `mips64-unknown-linux-gnu'.

MIPS32 gcc:
mips-unknown-linux-gnu-gcc (GCC) 3.3.3 20040217 (Gentoo Linux 3.3.3,
propolice-3.3-7)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

MIPS64 gcc:
mips64-unknown-linux-gnu-gcc (GCC) 3.3.3 20040217 (Gentoo Linux 3.3.3,
propolice-3.3-7)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

	Has this bug actually been fixed?  It seems the documentation here is a
little lacking as to what to change.

The machine's specs:
CPU: R4600 SC 133MHz [1]
RAM: 256MB 72pin EDO
HDD: 9.1GB IBM
OS:  Gentoo Linux/MIPS 1.4

	Apologies if this has been answered before... but I'm a bit of a newbie
when it comes to Linux/MIPS.[2]  Is there anything I missed when setting
this all up?

Reguards,
- --
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+
Footnotes:
1. A brief look at the MIPS Technologies website had me thinking that
only R5k and above are 64-bit, the R4k were 32-bit.  But it seems that
these too are 64-bit capable.
2. I'll admit though... I've learned more about the innards of a
computer playing with the Indy and Qube I own then I have from the last
two years of university study.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBUtWLuarJ1mMmSrkRAvIZAJ0QuwKzWGg3rRk9nzEU17bLfc38MgCfarfQ
+XK9eCVUaC88I5KtBh8fXjE=
=SIHi
-----END PGP SIGNATURE-----

--------------070400090104030606090106
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------070400090104030606090106--
