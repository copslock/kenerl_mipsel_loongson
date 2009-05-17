Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2009 22:57:30 +0100 (BST)
Received: from mail1.pearl-online.net ([62.159.194.147]:26511 "EHLO
	mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022459AbZEQV5S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 May 2009 22:57:18 +0100
Received: from Mobile0.Peter (83.243.117.39.dynamic.cablesurf.de [83.243.117.39])
	by mail1.pearl-online.net (Postfix) with ESMTP id 3FF61B99C;
	Sun, 17 May 2009 23:57:11 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id n4I04Y4I001322;
	Mon, 18 May 2009 00:04:34 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id n4HLnk0Q001273;
	Sun, 17 May 2009 23:49:46 +0200
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id n4HLnjaV001270;
	Sun, 17 May 2009 23:49:45 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sun, 17 May 2009 23:49:45 +0200 (CEST)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] -mr10k-cache-barrier=store
Message-ID: <Pine.LNX.4.58.0905172334550.1259@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Richard Sandiford's new code for inserting the cache-barriers, for GCC
4.3 and above and already incorporated in the current GCC-release, uses
a slightly different option-syntax.
(Accordingly i extended the patches for older GCC-releases to accept
both styles)


Signed-off-by: peter fuerst <post@pfrst.de>


--- git/arch/mips/Makefile	Thu May 14 12:50:28 2009
+++ wrk/arch/mips/Makefile	Sun May 17 23:14:10 2009
@@ -473,12 +473,12 @@
 # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
 #
 ifdef CONFIG_SGI_IP28
-  ifeq ($(call cc-option-yn,-mr10k-cache-barrier=1), n)
-      $(error gcc doesn't support needed option -mr10k-cache-barrier=1)
+  ifeq ($(call cc-option-yn,-mr10k-cache-barrier=store), n)
+      $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
   endif
 endif
 core-$(CONFIG_SGI_IP28)		+= arch/mips/sgi-ip22/
-cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=1 -I$(srctree)/arch/mips/include/asm/mach-ip28
+cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=store -I$(srctree)/arch/mips/include/asm/mach-ip28
 load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000

 #
