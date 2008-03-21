Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 15:12:00 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:40550 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S28577181AbYCUPL6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 15:11:58 +0000
Received: from SNaIlmail.Peter (85.233.32.210.static.cablesurf.de [85.233.32.210])
	by mail1.pearl-online.net (Postfix) with ESMTP id 5E53FCAF8;
	Fri, 21 Mar 2008 16:11:41 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id m2KIbLfM000974;
	Thu, 20 Mar 2008 19:37:22 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.24-ip28) with ESMTP id m2LF3HE3000201;
	Fri, 21 Mar 2008 16:03:17 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id m2LF3GoO000198;
	Fri, 21 Mar 2008 16:03:17 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Fri, 21 Mar 2008 16:03:16 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] IP28: fix MC GIOPAR setting
Message-ID: <Pine.LNX.4.58.0803211535570.423@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



We must not omit the MASTERGFX setting, unless we want Impact DMA to hang ;-)


Signed-off-by: peter fuerst <post@pfrst.de>


--- a/arch/mips/sgi-ip22/ip22-mc.c	Tue Jan 29 10:14:58 2008
+++ b/arch/mips/sgi-ip22/ip22-mc.c	Fri Mar 21 13:59:42 2008
@@ -180,7 +180,9 @@
 	/* First the basic invariants across all GIO64 implementations. */
 	tmp = SGIMC_GIOPAR_HPC64;	/* All 1st HPC's interface at 64bits */
 	tmp |= SGIMC_GIOPAR_ONEBUS;	/* Only one physical GIO bus exists */
-
+#ifdef CONFIG_SGI_IP28
+	tmp |= SGIMC_GIOPAR_MASTERGFX;	/* GFX can act as a bus master */
+#endif
 	if (ip22_is_fullhouse()) {
 		/* Fullhouse specific settings. */
 		if (SGIOC_SYSID_BOARDREV(sgioc->sysid) < 2) {
