Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id LAA51641 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Jan 1998 11:00:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA21879 for linux-list; Thu, 15 Jan 1998 10:56:42 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA21872 for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 10:56:40 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA02173
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 10:56:28 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA12013;
	Thu, 15 Jan 1998 13:59:05 -0500
Date: Thu, 15 Jan 1998 13:59:05 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ewt@redhat.com
cc: ralf@uni-koblenz.de, SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: mipseb and mipsel patches to RPM...
In-Reply-To: <19980115062501.64925@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980115134924.4203E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Erik,

	Please consider this as the final patch for the mips byteorder
issue.  It'd be nice to get this into the next version of rpm (101?).

	Thanks!

- Alex



diff -rc rpm-2.4.99.orig/lib/rpmrc.c rpm-2.4.99/lib/rpmrc.c
*** rpm-2.4.99.orig/lib/rpmrc.c	Tue Jan 13 16:08:24 1998
--- rpm-2.4.99/lib/rpmrc.c	Thu Jan 15 12:21:29 1998
***************
*** 682,687 ****
--- 682,699 ----
  	while (*chptr++)
  	    if (*chptr == '/') *chptr = '-';
  
+             #if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL)
+                 /* little endian */
+ 		strcpy(un.machine, "mipsel");
+             #else
+                #if defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB)
+                /* big endian */
+ 		    strcpy(un.machine, "mipseb");
+                #else
+                     /* This doesn't happen (TM) */
+                #endif
+             #endif
+ 
  	#if defined(__hpux) && defined(_SC_CPU_VERSION)
  	{
  	    int cpu_version = sysconf(_SC_CPU_VERSION);
diff -rc rpm-2.4.99.orig/lib-rpmrc.in rpm-2.4.99/lib-rpmrc.in
*** rpm-2.4.99.orig/lib-rpmrc.in	Tue Jan 13 16:08:23 1998
--- rpm-2.4.99/lib-rpmrc.in	Wed Jan 14 18:41:13 1998
***************
*** 41,47 ****
  arch_canon: 	sun4c:	sparc	3
  arch_canon:     sun4d:  sparc   3
  # This is really a place holder for MIPS.
! arch_canon:	mips:	mips	4
  arch_canon:	ppc:	ppc	5
  arch_canon:	m68k:	m68k	6
  arch_canon:	IP:	sgi	7
--- 41,47 ----
  arch_canon: 	sun4c:	sparc	3
  arch_canon:     sun4d:  sparc   3
  # This is really a place holder for MIPS.
! arch_canon:	mipseb:	mipseb	4
  arch_canon:	ppc:	ppc	5
  arch_canon:	m68k:	m68k	6
  arch_canon:	IP:	sgi	7
***************
*** 50,55 ****
--- 50,56 ----
  arch_canon:    9000/712:       hppa1.1 9
  
  arch_canon:    sun4u:   usparc  10
+ arch_canon:	mipsel:	mipsel	11
  
  #############################################################
  # Canonical OS names and numbers
***************
*** 118,124 ****
  arch_compat: sparc: noarch
  
  arch_compat: ppc: noarch
! arch_compat: mips: noarch
  
  arch_compat: hppa1.1: hppa1.0
  arch_compat: hppa1.0: noarch
--- 119,126 ----
  arch_compat: sparc: noarch
  
  arch_compat: ppc: noarch
! arch_compat: mipseb: noarch
! arch_compat: mipsel: noarch
  
  arch_compat: hppa1.1: hppa1.0
  arch_compat: hppa1.0: noarch
***************
*** 137,140 ****
  buildarch_compat: alpha: noarch
  buildarch_compat: m68k: noarch
  buildarch_compat: ppc: noarch
! buildarch_compat: mips: noarch
--- 139,144 ----
  buildarch_compat: alpha: noarch
  buildarch_compat: m68k: noarch
  buildarch_compat: ppc: noarch
! buildarch_compat: mipsel: noarch
! buildarch_compat: mipseb: noarch
! 
diff -rc rpm-2.4.99.orig/rpm.magic rpm-2.4.99/rpm.magic
*** rpm-2.4.99.orig/rpm.magic	Tue Jan 13 16:08:23 1998
--- rpm-2.4.99/rpm.magic	Wed Jan 14 16:43:43 1998
***************
*** 10,17 ****
  >>8	beshort		1		i386
  >>8	beshort		2		Alpha
  >>8	beshort		3		Sparc
! >>8	beshort		4		MIPS
  >>8	beshort		5		PowerPC
  >>8	beshort		6		68000
  >>8	beshort		7		SGI
  >>10	string		x		%s
--- 10,18 ----
  >>8	beshort		1		i386
  >>8	beshort		2		Alpha
  >>8	beshort		3		Sparc
! >>8	beshort		4		MIPS big endian
  >>8	beshort		5		PowerPC
  >>8	beshort		6		68000
  >>8	beshort		7		SGI
+ >>8	beshort		11		MIPS little endian
  >>10	string		x		%s


-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
