Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 16:11:30 +0200 (CEST)
Received: from [212.74.13.151] ([212.74.13.151]:23540 "EHLO dell.zee2.com")
	by linux-mips.org with ESMTP id <S1122961AbSIMOLa>;
	Fri, 13 Sep 2002 16:11:30 +0200
Received: from zee2.com (localhost [127.0.0.1])
	by dell.zee2.com (8.11.6/8.11.6) with ESMTP id g8DEBAC00535;
	Fri, 13 Sep 2002 15:11:12 +0100
Message-ID: <3D81F1D8.5E92F8EB@zee2.com>
Date: Fri, 13 Sep 2002 15:10:32 +0100
From: Stuart Hughes <seh@zee2.com>
Organization: Zee2 Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb
References: <3D81B8D3.1609CD69@zee2.com> <20020913135113.GA10721@nevyn.them.org>
Content-Type: multipart/mixed;
 boundary="------------04880802BDFFA3222F4BF6F2"
Return-Path: <seh@zee2.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: seh@zee2.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------04880802BDFFA3222F4BF6F2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Daniel,

Thanks for your help.  I also just found a posting by you from January
explaining this. I tried it out, and it works like a dream.  FWIW I've
attached a patch I applied to glibc.

Regards, Stuart


Daniel Jacobowitz wrote:
> 
> On Fri, Sep 13, 2002 at 11:07:15AM +0100, Stuart Hughes wrote:
> > Hi,
> >
> > I've been trying to debug a simple multi-threaded test program using
> > gdb, and it always fails as follows:
> >
> > [New Thread 1024 (LWP
> > 39)]
> >
> > Program received signal SIGTRAP, Trace/breakpoint
> > trap.
> > [Switching to Thread 1024 (LWP
> > 39)]
> > warning: Warning: GDB can't find the start of the function at
> > 0xffffffff.
> >
> > I've tried various different compilers, gdb, glibc version but the
> > problem is the same.  Note that I can debug non-threaded c/c++ programs
> > without any problem.  My environment is as follows:
> >
> > CPU:          NEC VR5432
> > kernel:       linux-2.4.10 + patches
> > glibc:                2.2.3 + patches
> 
> Not enough patches I'd bet.  Glibc 2.2.3 had an incorrect size listed
> for elf_gregset_t, and it was fixed in 2.2.5.  That would cause this
> problem.
> 
> > gdb:          5.2/3 from CVS
> > gcc:          3.1 (also tried 3.0.1)
> > binutils:     Version 2.11.90.0.25
> >
> > Does anyone have any idea what is wrong and how to fix it.
> >
> > Regards, Stuart
> >
> >
> 
> --
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
--------------04880802BDFFA3222F4BF6F2
Content-Type: text/plain; charset=us-ascii;
 name="glibc-2.2.3-gdb-pthread-diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="glibc-2.2.3-gdb-pthread-diff"

--- glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/procfs.h.orig	Fri Sep 13 14:26:42 2002
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/procfs.h	Fri Sep 13 14:26:54 2002
@@ -101,8 +101,8 @@
 typedef void *psaddr_t;
 
 /* Register sets.  Linux has different names.  */
-typedef gregset_t prgregset_t;
-typedef fpregset_t prfpregset_t;
+typedef elf_gregset_t prgregset_t;
+typedef elf_fpregset_t prfpregset_t;
 
 /* We don't have any differences between processes and threads,
    therefore habe only ine PID type.  */

--------------04880802BDFFA3222F4BF6F2--
