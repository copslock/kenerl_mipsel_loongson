Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 09:59:21 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:903 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603247AbYCFJ5m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:42 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id B3F65341D4;
	Thu,  6 Mar 2008 18:57:31 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id 828DF4F763; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094758.763268872@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:40 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 03/12] kexec-tools: mipsel: Update mipsel port for recent build changes
Content-Disposition: inline; filename=mips-build.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/Makefile                 |    1 +
 kexec/arch/mipsel/Makefile     |   13 +++++++++----
 purgatory/Makefile             |    1 +
 purgatory/arch/mipsel/Makefile |    8 ++++++--
 4 files changed, 17 insertions(+), 6 deletions(-)

Index: kexec-tools-mips/kexec/Makefile
===================================================================
--- kexec-tools-mips.orig/kexec/Makefile	2008-02-27 19:05:29.000000000 +0900
+++ kexec-tools-mips/kexec/Makefile	2008-02-27 19:05:48.000000000 +0900
@@ -33,6 +33,7 @@ include $(srcdir)/kexec/arch/alpha/Makef
 include $(srcdir)/kexec/arch/arm/Makefile
 include $(srcdir)/kexec/arch/i386/Makefile
 include $(srcdir)/kexec/arch/ia64/Makefile
+include $(srcdir)/kexec/arch/mipsel/Makefile
 include $(srcdir)/kexec/arch/ppc/Makefile
 include $(srcdir)/kexec/arch/ppc64/Makefile
 include $(srcdir)/kexec/arch/s390/Makefile
Index: kexec-tools-mips/kexec/arch/mipsel/Makefile
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/Makefile	2008-02-27 19:07:50.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/Makefile	2008-02-27 19:13:30.000000000 +0900
@@ -1,7 +1,12 @@
 #
 # kexec mipsel (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-mipsel.c
-KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-elf-mipsel.c
-KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-elf-rel-mipsel.c
-KEXEC_S_SRCS+= kexec/arch/mipsel/mipsel-setup-simple.S
+mipsel_KEXEC_SRCS =  kexec/arch/mipsel/kexec-mipsel.c
+mipsel_KEXEC_SRCS += kexec/arch/mipsel/kexec-elf-mipsel.c
+mipsel_KEXEC_SRCS += kexec/arch/mipsel/kexec-elf-rel-mipsel.c
+mipsel_KEXEC_SRCS += kexec/arch/mipsel/mipsel-setup-simple.S
+
+dist += kexec/arch/mipsel/Makefile $(mipsel_KEXEC_SRCS)			\
+	kexec/arch/mipsel/kexec-mipsel.h				\
+	kexec/arch/mipsel/include/arch/options.h
+
Index: kexec-tools-mips/purgatory/Makefile
===================================================================
--- kexec-tools-mips.orig/purgatory/Makefile	2008-02-27 19:08:55.000000000 +0900
+++ kexec-tools-mips/purgatory/Makefile	2008-02-27 19:09:05.000000000 +0900
@@ -20,6 +20,7 @@ include $(srcdir)/purgatory/arch/alpha/M
 include $(srcdir)/purgatory/arch/arm/Makefile
 include $(srcdir)/purgatory/arch/i386/Makefile
 include $(srcdir)/purgatory/arch/ia64/Makefile
+include $(srcdir)/purgatory/arch/mipsel/Makefile
 include $(srcdir)/purgatory/arch/ppc/Makefile
 include $(srcdir)/purgatory/arch/ppc64/Makefile
 include $(srcdir)/purgatory/arch/s390/Makefile
Index: kexec-tools-mips/purgatory/arch/mipsel/Makefile
===================================================================
--- kexec-tools-mips.orig/purgatory/arch/mipsel/Makefile	2008-02-27 19:08:55.000000000 +0900
+++ kexec-tools-mips/purgatory/arch/mipsel/Makefile	2008-02-27 19:11:04.000000000 +0900
@@ -2,6 +2,10 @@
 # Purgatory mipsel
 #
 
-PURGATORY_C_SRCS+= purgatory/arch/mipsel/purgatory-mipsel.c
-PURGATORY_C_SRCS+= purgatory/arch/mipsel/console-mipsel.c
+mipsel_PURGATORY_C_SRCS+= purgatory/arch/mipsel/purgatory-mipsel.c
+mipsel_PURGATORY_C_SRCS+= purgatory/arch/mipsel/console-mipsel.c
+
+dist += purgatory/arch/mipsel/Makefile $(mipsel_PURGATORY_C_SRCS)	\
+	purgatory/arch/mipsel/include/limits.h				\
+	purgatory/arch/mipsel/purgatory-mipsel.h
 

-- 

-- 
Horms
