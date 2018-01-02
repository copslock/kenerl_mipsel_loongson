Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 12:32:11 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:42343 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeABLcEsPJ3a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 12:32:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 02 Jan 2018 11:32:00 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 2 Jan 2018 03:31:58 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH 1/2] MIPS: Watch: Avoid duplication of bits in mips_install_watch_registers.
Date:   Tue, 2 Jan 2018 11:31:21 +0000
Message-ID: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1514892719-637139-22015-392313-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188570
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Currently the bits to be set in the watchhi register in addition to that
requested by the user is defined inline for each register. To avoid
this, define the bits once and or that in for each register.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/watch.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
index 19fcab7348b1..329d2209521d 100644
--- a/arch/mips/kernel/watch.c
+++ b/arch/mips/kernel/watch.c
@@ -18,27 +18,24 @@
 void mips_install_watch_registers(struct task_struct *t)
 {
 	struct mips3264_watch_reg_state *watches = &t->thread.watch.mips3264;
+	unsigned int watchhi = MIPS_WATCHHI_G |		/* Trap all ASIDs */
+			       MIPS_WATCHHI_IRW;	/* Clear result bits */
+
 	switch (current_cpu_data.watch_reg_use_cnt) {
 	default:
 		BUG();
 	case 4:
 		write_c0_watchlo3(watches->watchlo[3]);
-		/* Write 1 to the I, R, and W bits to clear them, and
-		   1 to G so all ASIDs are trapped. */
-		write_c0_watchhi3(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
-				  watches->watchhi[3]);
+		write_c0_watchhi3(watchhi | watches->watchhi[3]);
 	case 3:
 		write_c0_watchlo2(watches->watchlo[2]);
-		write_c0_watchhi2(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
-				  watches->watchhi[2]);
+		write_c0_watchhi2(watchhi | watches->watchhi[2]);
 	case 2:
 		write_c0_watchlo1(watches->watchlo[1]);
-		write_c0_watchhi1(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
-				  watches->watchhi[1]);
+		write_c0_watchhi1(watchhi | watches->watchhi[1]);
 	case 1:
 		write_c0_watchlo0(watches->watchlo[0]);
-		write_c0_watchhi0(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
-				  watches->watchhi[0]);
+		write_c0_watchhi0(watchhi | watches->watchhi[0]);
 	}
 }
 
-- 
2.7.4
