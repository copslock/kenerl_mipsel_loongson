Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA445190 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 05:11:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA19645 for linux-list; Tue, 6 Jan 1998 05:11:20 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA19636 for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 05:11:18 -0800
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id FAA14617
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 05:11:16 -0800
	env-from (conradp@cse.unsw.edu.au)
Received: From bell07 With LocalMail ; Wed, 7 Jan 98 00:10:54 +1100 
From: Conrad Parker <conradp@cse.unsw.edu.au>
To: linux@cthulhu.engr.sgi.com
Date: Wed, 7 Jan 1998 00:10:33 +1100 (EST)
X-Sender: conradp@bell07.orchestra.cse.unsw.EDU.AU
cc: "Andrew John O'Brien" <andrewo@cse.unsw.edu.au>
Subject: i386 crosscompile problems
Message-ID: <Pine.GSO.3.95.980106234535.24128T-100000@bell07.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hi,

we're attempting to cross-compile a bootstrap kernel for an r4600 indy
with no L2 cache, from an i386-linux box. We have had most success so far
with kernel snapshot 971208 from ftp.linux.sgi.com, patched to work with
no L2 cache. We have built binutils-2.8.1.0.15 patched with the
binutils-2.8.1-1 patch, and using the gcc cross compiler 2.7.2-3 binary
release (rpm).

When compiling the kernel, we get lots of mips-linux-ld warnings along the
lines of:

mips-linux-ld: Warning: type of symbol 'prom_imode' changed from 1 to 2 in
misc.o

for lots of symbols in lots of object files...
Everything seems to compile fine, without excessive other warnings from
gcc and the native mips code passes through without a hitch.

When the resulting kernel is used from bootp, we get the following dump
immediately:

Exception: <vector=XUT>
Status register: 0x10004801<CU0,IM7,IM4,IPL=???,MODE=KERNEL,IE>
Cause register: 0x801c<CE=0,IP8,EXC=DBE>
Exception PC: 0x9fc31f20, Exception RA: 0x88018d04
Data Bus error Local I/O interrupt register 1: 0x80 <VR/GIO2>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: f 8800bde0 8800253c 80000200
  tmp: 8800253c 34392e31 0 33000000 0 37312e32 32352e36 8812b130
  sve: 20 a87ff234 a87498d4 a87ff53c a8747420 9fc56394 0 9fc56394
  t8 0 t9 9fc20260 at 8816003c v0 80000080 v1 8800bde0 k1 bad11bad
  gp 0 fp 9fc4de88 sp 88009f88 ra 88018d04

PANIC: Unexpected exception


ouch. We expect the problem is with our configuration of binutils and/or
gcc. Can anyone help?

K.

--
Conrad Parker conradp@cse.unsw.edu.au
Linux Life: http://www.cse.unsw.edu.au/~conradp/linux/
