Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fANDtOU13809
	for linux-mips-outgoing; Fri, 23 Nov 2001 05:55:24 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fANDtJo13806
	for <linux-mips@oss.sgi.com>; Fri, 23 Nov 2001 05:55:20 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 167FrS-0003BZ-00; Fri, 23 Nov 2001 13:55:18 +0100
Date: Fri, 23 Nov 2001 13:55:18 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: ralf@gnu.org
Subject: emebedded ramdisk vs initrd
Message-ID: <20011123135518.A12210@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com, ralf@gnu.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Trying to link in arch/mips/ramdisk/ramdisk.o whenever
CONFIG_BLK_DEV_INITRD is defined is a bad idea, since there are other
ways to use a ramdisk (bootloader, addinitrd). I suggest to use
CONFIG_EMBEDDED_RAMDISK instead , since it's already used by sibyte/swarm. 
 -- Guido

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ramdisk.diff"

--- arch/mips/Makefile.orig	Fri Nov 23 13:43:52 2001
+++ arch/mips/Makefile	Fri Nov 23 13:46:37 2001
@@ -111,7 +111,7 @@
 # You need a compressed ramdisk image, named ramdisk.gz in
 # arch/mips/ramdisk
 #
-ifdef CONFIG_BLK_DEV_INITRD
+ifdef CONFIG_EMBEDDED_RAMDISK
 CORE_FILES	+= arch/mips/ramdisk/ramdisk.o
 SUBDIRS		+= arch/mips/ramdisk
 endif

--EVF5PPMfhYS0aIcm--
