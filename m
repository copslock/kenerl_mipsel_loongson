Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id LAA52855 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Jan 1998 11:55:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA13024 for linux-list; Thu, 15 Jan 1998 11:51:46 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA13005 for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 11:51:45 -0800
Received: from lacrosse.redhat.com (lacrosse.redhat.com [207.175.42.154]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA21667
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 11:51:36 -0800
	env-from (ewt@redhat.com)
Received: from localhost (ewt@localhost)
	by lacrosse.redhat.com (8.8.7/8.8.7) with SMTP id OAA14391;
	Thu, 15 Jan 1998 14:51:18 -0500
Date: Thu, 15 Jan 1998 14:51:17 -0500 (EST)
From: Erik Troan <ewt@redhat.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: ralf@uni-koblenz.de, SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: mipseb and mipsel patches to RPM...
In-Reply-To: <Pine.LNX.3.95.980115134924.4203E-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.96.980115145002.13293F-100000@lacrosse.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 15 Jan 1998, Alex deVries wrote:

> 	Please consider this as the final patch for the mips byteorder
> issue.  It'd be nice to get this into the next version of rpm (101?).

Here's the final patch I used. It's basically the same as yours, I just
changed the #if stuff to look a bit cleaner. I also made the old 'mips'
architecture compatible with your new 'mipseb' one -- that should save
you some migration headaches.

Let me know if this doesn't look right.

Erik

Index: lib-rpmrc.in
===================================================================
RCS file: /usr/rhs/CVS/rpm/lib-rpmrc.in,v
retrieving revision 1.32
diff -u -r1.32 lib-rpmrc.in
--- lib-rpmrc.in	1997/12/30 19:26:15	1.32
+++ lib-rpmrc.in	1998/01/15 19:51:02
@@ -41,7 +41,7 @@
 arch_canon: 	sun4c:	sparc	3
 arch_canon:     sun4d:  sparc   3
 # This is really a place holder for MIPS.
-arch_canon:	mips:	mips	4
+arch_canon:	mipseb:	mipseb	4
 arch_canon:	ppc:	ppc	5
 arch_canon:	m68k:	m68k	6
 arch_canon:	IP:	sgi	7
@@ -50,6 +50,7 @@
 arch_canon:    9000/712:       hppa1.1 9
 
 arch_canon:    sun4u:   usparc  10
+arch_canon:	mipsel:	mipsel	11
 
 #############################################################
 # Canonical OS names and numbers
@@ -118,10 +119,13 @@
 arch_compat: sparc: noarch
 
 arch_compat: ppc: noarch
-arch_compat: mips: noarch
+arch_compat: mipseb: noarch
+arch_compat: mipsel: noarch
 
 arch_compat: hppa1.1: hppa1.0
 arch_compat: hppa1.0: noarch
+# we used to call mipseb just mips -- let those packages still work
+arch_compat: mipseb: mips
 
 os_compat:   IRIX64: IRIX
 
@@ -137,4 +141,6 @@
 buildarch_compat: alpha: noarch
 buildarch_compat: m68k: noarch
 buildarch_compat: ppc: noarch
-buildarch_compat: mips: noarch
+buildarch_compat: mipsel: noarch
+buildarch_compat: mipseb: noarch
+
Index: rpm.magic
===================================================================
RCS file: /usr/rhs/CVS/rpm/rpm.magic,v
retrieving revision 2.2
diff -u -r2.2 rpm.magic
--- rpm.magic	1996/05/22 20:39:33	2.2
+++ rpm.magic	1998/01/15 19:51:02
@@ -10,8 +10,9 @@
 >>8	beshort		1		i386
 >>8	beshort		2		Alpha
 >>8	beshort		3		Sparc
->>8	beshort		4		MIPS
+>>8	beshort		4		MIPS big endian
 >>8	beshort		5		PowerPC
 >>8	beshort		6		68000
 >>8	beshort		7		SGI
+>>8	beshort		11		MIPS little endian
 >>10	string		x		%s
Index: lib/rpmrc.c
===================================================================
RCS file: /usr/rhs/CVS/rpm/lib/rpmrc.c,v
retrieving revision 2.57
diff -u -r2.57 rpmrc.c
--- rpmrc.c	1998/01/12 16:58:16	2.57
+++ rpmrc.c	1998/01/15 19:51:02
@@ -682,6 +682,14 @@
 	while (*chptr++)
 	    if (*chptr == '/') *chptr = '-';
 
+	#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL)
+	    /* little endian */
+	    strcpy(un.machine, "mipsel");
+	#elif defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB)
+	   /* big endian */
+		strcpy(un.machine, "mipseb");
+	#endif
+
 	#if defined(__hpux) && defined(_SC_CPU_VERSION)
 	{
 	    int cpu_version = sysconf(_SC_CPU_VERSION);
