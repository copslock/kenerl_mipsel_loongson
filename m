Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 17:44:27 +0100 (BST)
Received: from one.ldsys.net ([IPv6:::ffff:208.176.63.109]:36139 "EHLO
	one.chi.ldsys.net") by linux-mips.org with ESMTP
	id <S8225262AbUJCQoX>; Sun, 3 Oct 2004 17:44:23 +0100
Received: from sex-machine.chi.ldsys.net (sex-machine.chi.ldsys.net [10.0.1.4])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by one.chi.ldsys.net (Postfix) with ESMTP id 5A07470C06
	for <linux-mips@linux-mips.org>; Sun,  3 Oct 2004 11:44:21 -0500 (CDT)
Subject: [PATCH] Kconfig for R5k/RM7k sc
From: "Christopher G. Stach II" <cgs@ldsys.net>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1096821864.3883.11.camel@sex-machine.chi.ldsys.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 11:44:24 -0500
Content-Transfer-Encoding: 7bit
Return-Path: <cgs@ldsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgs@ldsys.net
Precedence: bulk
X-list: linux-mips

    This should prevent the rm7k sc code from being built for IP32, etc.

Index: arch/mips/Kconfig
===================================================================
RCS file: /home/cvs/linux/arch/mips/Kconfig,v
retrieving revision 1.96
diff -u -b -B -r1.96 Kconfig
--- arch/mips/Kconfig   24 Sep 2004 21:43:04 -0000  1.96
+++ arch/mips/Kconfig   3 Oct 2004 16:30:34 -0000
@@ -497,8 +497,6 @@
    depends on MIPS64 && EXPERIMENTAL
    select DMA_NONCOHERENT
    select HW_HAS_PCI
-   select R5000_CPU_SCACHE
-   select RM7000_CPU_SCACHE
    help
      If you want this kernel to run on SGI O2 workstation, say Y here.

@@ -1155,11 +1153,13 @@

 config CPU_R5000
    bool "R5000"
+   select R5000_CPU_SCACHE
    help
      MIPS Technologies R5000-series processors other than the Nevada.

 config CPU_R5432
    bool "R5432"
+   select R5000_CPU_SCACHE

 config CPU_R6000
    bool "R6000"
@@ -1170,6 +1170,7 @@

 config CPU_NEVADA
    bool "R52xx"
+   select R5000_CPU_SCACHE
    help
      MIPS Technologies R52x0-series ("Nevada") processors.
 @@ -1187,6 +1188,7 @@

 config CPU_RM7000
    bool "RM7000"
+   select RM7000_CPU_SCACHE
  config CPU_RM9000
    bool "RM9000" 
