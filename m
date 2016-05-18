Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 18:13:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52377 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030081AbcERQMtKPD18 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 18:12:49 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id E5C7D9EFC6D5F;
        Wed, 18 May 2016 17:12:39 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 17:12:43 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 17:12:42 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 2/2] MIPS: CPS: Copy EVA configuration when starting secondary VPs.
Date:   Wed, 18 May 2016 17:12:36 +0100
Message-ID: <1463587956-9160-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1463587956-9160-1-git-send-email-matt.redfearn@imgtec.com>
References: <1463587956-9160-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

When starting secondary VPEs which support EVA and the SegCtl registers,
copy the memory segmentation configuration from the running VPE to ensure
that all VPEs in the core have a consistent virtual memory map.

The EVA configuration of secondary cores is dealt with when starting the
core via the CM.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2:
- Skip check for config3 existing - we know it must to be doing
multithreading
- Use a unique lable name in the function

 arch/mips/kernel/cps-vec.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index ac81edd44563..f8eae9189e38 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -431,6 +431,21 @@ LEAF(mips_cps_boot_vpes)
 	mfc0	t0, CP0_CONFIG
 	mttc0	t0, CP0_CONFIG
 
+	/*
+	 * Copy the EVA config from this VPE if the CPU supports it.
+	 * CONFIG3 must exist to be running MT startup - just read it.
+	 */
+	mfc0	t0, CP0_CONFIG, 3
+	and	t0, t0, MIPS_CONF3_SC
+	beqz	t0, 3f
+	 nop
+	mfc0    t0, CP0_SEGCTL0
+	mttc0	t0, CP0_SEGCTL0
+	mfc0    t0, CP0_SEGCTL1
+	mttc0	t0, CP0_SEGCTL1
+	mfc0    t0, CP0_SEGCTL2
+	mttc0	t0, CP0_SEGCTL2
+3:
 	/* Ensure no software interrupts are pending */
 	mttc0	zero, CP0_CAUSE
 	mttc0	zero, CP0_STATUS
-- 
2.5.0
