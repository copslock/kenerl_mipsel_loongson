Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7N7pcU17936
	for linux-mips-outgoing; Thu, 23 Aug 2001 00:51:38 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7N7pZd17933
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 00:51:35 -0700
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 15ZpH4-00022h-00; Thu, 23 Aug 2001 09:51:34 +0200
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15ZpH3-0002zf-00; Thu, 23 Aug 2001 09:51:33 +0200
Date: Thu, 23 Aug 2001 09:51:33 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: Patch: don't report rd found when none is there
Message-ID: <20010823095133.A11435@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com,
	Ralf Baechle <ralf@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The current code in a/m/k/setup.c assigns __rd_start & __rd_end to
initrd_start and initrd_end even when no ramdisk was added to the kernel
image. This gives an "Initial ramdisk at:...." message even though no
ramdisk is there. Attached patch fixes this. It furthermore prevents
initrd_{start,end} being overriden(in case it gets set somewhere in the
board specific code).
 -- Guido

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rd_found_2001-08-23.diff"

--- arch/mips/kernel/setup.c.orig	Thu Aug 23 09:36:31 2001
+++ arch/mips/kernel/setup.c	Thu Aug 23 09:36:40 2001
@@ -725,8 +719,10 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Board specific code should have set up initrd_start and initrd_end */
 	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
+	if( __rd_start != __rd_end ) {
+		initrd_start = (unsigned long)&__rd_start;
+		initrd_end = (unsigned long)&__rd_end;
+	}
 	initrd_below_start_ok = 1;
 	if (initrd_start) {
 		unsigned long initrd_size = ((unsigned char *)initrd_end) - ((unsigned char *)initrd_start); 

--LQksG6bCIzRHxTLp--
