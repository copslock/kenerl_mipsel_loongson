Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2003 20:37:57 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:24875
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8224802AbTGOThp>; Tue, 15 Jul 2003 20:37:45 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19cVcH-0003Lr-00; Tue, 15 Jul 2003 21:37:37 +0200
To: linux-mips@linux-mips.org
Subject: [PATCH 2.5] kbuild error for mips (and possibly others)
Cc: ralf@linux-mips.org
Message-Id: <E19cVcH-0003Lr-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Tue, 15 Jul 2003 21:37:37 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi,
	there is a very annoying error in the 2.5 kbuild process
where the generation of the elfconfig.h file depends on the proper
configuration of the kernel being available (for mips at least) 
but configuring the kernel disallows the inclusion of the .config file
and thus the configuration and specifically CROSS_COMPILE is not set. 
This causes empty.o to fail to build because CC is now gcc and not 
mips(el)-linux-gcc and the -G option to gcc is invalid for my cross
compiler.

This patch fixes the problem. It also makes the *config targets 
not dependant on having the helper programs in scripts/ compiled
which they shouldn't be. They are not necessary.

/Brian

Index: scripts/Makefile
===================================================================
RCS file: /cvs/linux/scripts/Makefile,v
retrieving revision 1.20
diff -u -r1.20 Makefile
--- scripts/Makefile	5 Jun 2003 10:06:44 -0000	1.20
+++ scripts/Makefile	15 Jul 2003 19:28:29 -0000
@@ -7,6 +7,7 @@
 #                include/config/...
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml docs
 # conmakehash:	 Create arrays for initializing the kernel console tables
+ifdef include_config
 
 host-progs	:= fixdep split-include conmakehash docproc kallsyms modpost \
 		   mk_elfconfig pnmtologo
@@ -33,3 +34,5 @@
 	$(call if_changed,elfconfig)
 
 targets += elfconfig.h
+
+endif
