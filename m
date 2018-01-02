Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 12:32:36 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:57124 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992521AbeABLcLoekra (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 12:32:11 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 02 Jan 2018 11:32:07 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 2 Jan 2018 03:32:05 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH 2/2] MIPS: Watch: Avoid duplication of bits in mips_read_watch_registers
Date:   Tue, 2 Jan 2018 11:31:22 +0000
Message-ID: <1514892682-30328-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
References: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1514892726-637139-22022-392290-1
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
X-archive-position: 61823
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

Currently the bits to be masked when watchhi is read is defined inline
for each register. To avoid this, define the bits once and mask each
register with that value.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/watch.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
index 329d2209521d..0e61a5b7647f 100644
--- a/arch/mips/kernel/watch.c
+++ b/arch/mips/kernel/watch.c
@@ -48,21 +48,19 @@ void mips_read_watch_registers(void)
 {
 	struct mips3264_watch_reg_state *watches =
 		&current->thread.watch.mips3264;
+	unsigned int watchhi_mask = MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW;
+
 	switch (current_cpu_data.watch_reg_use_cnt) {
 	default:
 		BUG();
 	case 4:
-		watches->watchhi[3] = (read_c0_watchhi3() &
-				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
+		watches->watchhi[3] = (read_c0_watchhi3() & watchhi_mask);
 	case 3:
-		watches->watchhi[2] = (read_c0_watchhi2() &
-				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
+		watches->watchhi[2] = (read_c0_watchhi2() & watchhi_mask);
 	case 2:
-		watches->watchhi[1] = (read_c0_watchhi1() &
-				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
+		watches->watchhi[1] = (read_c0_watchhi1() & watchhi_mask);
 	case 1:
-		watches->watchhi[0] = (read_c0_watchhi0() &
-				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
+		watches->watchhi[0] = (read_c0_watchhi0() & watchhi_mask);
 	}
 	if (current_cpu_data.watch_reg_use_cnt == 1 &&
 	    (watches->watchhi[0] & MIPS_WATCHHI_IRW) == 0) {
-- 
2.7.4
