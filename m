Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3EF618d003867
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 14 Apr 2002 08:06:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3EF61Fw003866
	for linux-mips-outgoing; Sun, 14 Apr 2002 08:06:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3EF5r8d003852
	for <linux-mips@oss.sgi.com>; Sun, 14 Apr 2002 08:05:54 -0700
Received: (qmail 24676 invoked by uid 0); 14 Apr 2002 15:06:33 -0000
Received: from pd9e4155d.dip.t-dialin.net (HELO bogon.ms20.nix) (217.228.21.93)
  by mail.gmx.net (mp010-rz3) with SMTP; 14 Apr 2002 15:06:33 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 912AA365C6; Sun, 14 Apr 2002 17:04:56 +0200 (CEST)
Date: Sun, 14 Apr 2002 17:04:56 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: ralf@gnu.org
Subject: [patch]: minor addinitrd.c cleanup
Message-ID: <20020414150456.GA11128@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com, ralf@gnu.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
patch makes sure we:
 - don't overwrite an existing .data section in the ecoff
 - opens the original kernel image read only
applies to 2.4 as well as 2.5.
 -- Guido

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="addinitrd-2002-04-14.diff"

Index: arch/mips/boot/addinitrd.c
===================================================================
RCS file: /cvs/linux/arch/mips/boot/addinitrd.c,v
retrieving revision 1.1.6.1
diff -u -u -r1.1.6.1 addinitrd.c
--- arch/mips/boot/addinitrd.c	2001/12/13 21:22:23	1.1.6.1
+++ arch/mips/boot/addinitrd.c	2002/04/14 14:59:50
@@ -2,6 +2,8 @@
  * addinitrd - program to add a initrd image to an ecoff kernel
  *
  * (C) 1999 Thomas Bogendoerfer
+ *     2002 Guido Guenther <agx@sigxcpu.org>
+ *
  */
 
 #include <sys/types.h>
@@ -54,7 +56,7 @@
 		exit (1);
 	}
 
-	if ((fd_vmlinux = open (argv[1],O_RDWR)) < 0)
+	if ((fd_vmlinux = open (argv[1],O_RDONLY)) < 0)
 		 die ("open vmlinux");
 	if (read (fd_vmlinux, &efile, sizeof efile) != sizeof efile)
 		die ("read file header");
@@ -65,7 +67,10 @@
 	/*
 	 * check whether the file is good for us
 	 */
-	/* TBD */
+	if( eaout.dsize || esecs[1].s_size ) {
+		fprintf(2,".data section not empty. Giving up!\n");
+		exit(1);
+	}
 
 	/*
 	 * check, if we have to swab words

--82I3+IH0IqGh5yIs--
