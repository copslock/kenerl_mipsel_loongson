Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA30061 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 20:00:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA11467 for linux-list; Wed, 14 Jan 1998 19:55:03 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA11458 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 19:54:57 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA25666
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 19:54:52 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA15565;
	Wed, 14 Jan 1998 22:56:59 -0500
Date: Wed, 14 Jan 1998 22:56:58 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ewt@redhat.com
cc: ralf@uni-koblenz.de, SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: mipseb and mipsel patches to RPM...
In-Reply-To: <19980115010335.21821@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980114214632.6815B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 15 Jan 1998 ralf@uni-koblenz.de wrote:
> Ah, you were the volunteer :-)  Recently I fixed RPM already, so we should
> somewhen deciede who's patch is the nicer.

Erik,

	Feel free to apply either Ralf's or my patch (below my .sig).  It
supports auto-byte order detection in defaultMachine(), and patches to the
rpmrc and rpm.magic files to change the name to mipseb and mipsel.

	I've made little-endian mips 11, and renamed the existing mips to
mipseb.

- Alex

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
z

diff -rc rpm-2.4.99.orig/lib/rpmrc.c rpm-2.4.99/lib/rpmrc.c
*** rpm-2.4.99.orig/lib/rpmrc.c	Tue Jan 13 16:08:24 1998
--- rpm-2.4.99/lib/rpmrc.c	Wed Jan 14 19:07:28 1998
***************
*** 669,674 ****
--- 669,681 ----
      char * chptr;
      struct canonEntry * canon;
  
+ #if defined (__mips)
+     union {
+       long l;
+       char c[sizeof (long)];
+     } u;
+ #endif
+ 
      if (!gotDefaults) {
  	uname(&un);
  	if (!strcmp(un.sysname, "AIX")) {
***************
*** 681,686 ****
--- 688,702 ----
  	chptr = un.machine;
  	while (*chptr++)
  	    if (*chptr == '/') *chptr = '-';
+ 
+ #if defined(__mips)
+             u.l = 1;
+             if (u.c[sizeof (long) - 1] == 1) {
+ 		    strcpy(un.machine, "mipseb");
+             } else {
+ 		    strcpy(un.machine, "mipsel");
+            }
+ #endif
  
  	#if defined(__hpux) && defined(_SC_CPU_VERSION)
  	{
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
