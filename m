Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 19:03:36 +0200 (CEST)
Received: from [212.74.13.151] ([212.74.13.151]:29680 "EHLO dell.zee2.com")
	by linux-mips.org with ESMTP id <S1122987AbSIQRDf>;
	Tue, 17 Sep 2002 19:03:35 +0200
Received: from zee2.com (localhost [127.0.0.1])
	by dell.zee2.com (8.11.6/8.11.6) with ESMTP id g8HH3HM10370
	for <linux-mips@linux-mips.org>; Tue, 17 Sep 2002 18:03:20 +0100
Message-ID: <3D876053.C2CD1D8C@zee2.com>
Date: Tue, 17 Sep 2002 18:03:15 +0100
From: Stuart Hughes <seh@zee2.com>
Organization: Zee2 Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: cannot debug multi-threaded programs with gdb/gdbserver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <seh@zee2.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: seh@zee2.com
Precedence: bulk
X-list: linux-mips

Hi,

I managed to get gdb to do multi-threaded debug using a gdb on the
target, after Daniel J helped with a patch to sys/procfs.h

I am now trying to do host target with gdb/gdbserver.  The program on
the target uses pthreads.

I can connect, but as soon as you try to continue (to a breakpoint) I
get:

Program received signal SIG32, Real-time event 32.
warning: Warning: GDB can't find the start of the function at
0x2abee684.
....

I know that SIG32 is used for the thread control on the target, but I'm
not sure if the host gdb is supposed to receive this.  I tried "set
handle SIG32 pass noprint nostop"
and variations, but this didn't help.
 
Does anyone know whether there is some special setup needed on
gdb/gdbserver to use the multi-threaded gdbserver ??



My environment is as follows:

CPU:		NEC VR5432
kernel: 	linux-2.4.18 + patches
glibc:		2.2.3 + patches
gdb:		5.2/3 from CVS
gcc:		3.1
binutils:	Version 2.11.90.0.25


cross-gdb configured using: 

configure --prefix=/usr --target=mipsel-linux --disable-sim
--disable-tcl --enable-threads --enable-shared

gdbserver configured using:

configure --prefix=/usr --host=mipsel-linux --target=mipsel-linux
--enable-threads --enable-shared


Regards, Stuart
