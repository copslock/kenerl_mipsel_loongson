Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 23:03:23 +0100 (CET)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:58437 "EHLO
	brian.localnet") by linux-mips.org with ESMTP id <S1121743AbSKGWDX>;
	Thu, 7 Nov 2002 23:03:23 +0100
Received: from brm by brian.localnet with local (Exim 3.35 #1 (Debian))
	id 189uk6-0001Rj-00
	for <linux-mips@linux-mips.org>; Thu, 07 Nov 2002 23:03:14 +0100
To: linux-mips@linux-mips.org
Subject: [PATCH 2.5] initramfs fix 
Message-Id: <E189uk6-0001Rj-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Thu, 07 Nov 2002 23:03:14 +0100
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi,
	I have had a little problem with initramfs, Finally I have
found out that the problem is that when I make a flash image I do an
objcopy of the kernel image to get something which can be flashed.
Unfortunately objcopy thinks that the .init.initramfs is a useless section
and throws it away because it does not have the alloc flag set.
Here is a fix.

/Brian

Index: usr/Makefile
===================================================================
RCS file: /home/cvs/linux/usr/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- usr/Makefile	5 Nov 2002 15:18:25 -0000	1.1
+++ usr/Makefile	7 Nov 2002 21:59:31 -0000
@@ -17,6 +17,7 @@
 	$(OBJCOPY) $(ARCHBLOBLFLAGS) \
 		--only-section=.init.initramfs \
 		--add-section=.init.initramfs=$(obj)/initramfs_data.cpio.gz \
+		--set-section-flags .init.initramfs=alloc \
 		$(obj)/empty.o $(obj)/initramfs_data.o
 	$(STRIP) -s $(obj)/initramfs_data.o
 
