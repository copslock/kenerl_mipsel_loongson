Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:52:31 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:39594 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492033AbZGBCtk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:49:40 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622hv2L016374
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:43:57 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:43:57 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622hv0S006020;
	Wed, 1 Jul 2009 19:43:57 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 15/15] Do not rely on the initial state of TC/VPE bindings
	when doing cross VPE writes
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:43:31 -0700
Message-ID: <20090702024331.23268.98671.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:43:57.0349 (UTC) FILETIME=[F25A1550:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Kurt Martin <kurt@mips.com>

Signed-off-by: Jaidev Patwardhan <jaidev@mips.com>
	Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/kernel/smtc.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 69240c4..3498b82 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -481,6 +481,18 @@ void smtc_prepare_cpus(int cpus)
 			 */
 			if (tc != 0) {
 				smtc_tc_setup(vpe, tc, cpu);
+				if (vpe != 0) {
+					/*
+					 * Set MVP bit (possibly again).  Do it
+					 * here to catch CPUs that have no TCs
+					 * bound to the VPE at reset.  In that
+					 * case, a TC must be bound to the VPE
+					 * before we can set VPEControl[MVP]
+					 */
+					write_vpe_c0_vpeconf0(
+						read_vpe_c0_vpeconf0() |
+						VPECONF0_MVP);
+				}
 				cpu++;
 			}
 			printk(" %d", tc);
