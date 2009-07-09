Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2009 04:22:54 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:47383 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493062AbZGICWq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Jul 2009 04:22:46 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n692MdDE027262
	for <linux-mips@linux-mips.org>; Wed, 8 Jul 2009 19:22:39 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Jul 2009 19:22:38 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n692McQv019556;
	Wed, 8 Jul 2009 19:22:38 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH] Move Cross VPE writes to a latter stage in loop after a TC is
	assigned to VPE.
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Wed, 08 Jul 2009 19:22:35 -0700
Message-ID: <20090709022234.13969.44737.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jul 2009 02:22:39.0012 (UTC) FILETIME=[214B9640:01CA003C]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Kurt Martin <kurt@mips.com>

This patch was part of the series of patches I sent previously. In this version, I
accomodated and tested Kevin D.Kissel's  suggestion. Also the case when
no TCs are assigned to a VPE is checked.

Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Raghu Gandham <raghu@mips.com>
---

 arch/mips/kernel/smtc.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 8a0626c..c16bb6d 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -465,11 +465,8 @@ void smtc_prepare_cpus(int cpus)
 	smtc_configure_tlb();
 
 	for (tc = 0, vpe = 0 ; (vpe < nvpe) && (tc < ntc) ; vpe++) {
-		/*
-		 * Set the MVP bits.
-		 */
-		settc(tc);
-		write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() | VPECONF0_MVP);
+		if (tcpervpe[vpe] == 0)
+			continue;
 		if (vpe != 0)
 			printk(", ");
 		printk("VPE %d: TC", vpe);
@@ -488,6 +485,12 @@ void smtc_prepare_cpus(int cpus)
 		}
 		if (vpe != 0) {
 			/*
+			 * Allow this VPE to control others.
+			 */
+			write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() |
+					      VPECONF0_MVP);
+
+			/*
 			 * Clear any stale software interrupts from VPE's Cause
 			 */
 			write_vpe_c0_cause(0);
