Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 17:41:46 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:47622 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994584AbeDQPl03w4iw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2018 17:41:26 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 17 Apr 2018 15:41:18 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 17 Apr 2018 08:41:35 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] MIPS: memset.S: Add comments to fault fixup handlers
Date:   Tue, 17 Apr 2018 16:40:03 +0100
Message-ID: <1523979603-492-4-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
References: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523979677-637139-30405-48655-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192083
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
X-archive-position: 63589
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

It is not immediately obvious what the expected inputs to these fault
handlers is and how they calculate the number of unset bytes. Having
stared deeply at this in order to fix some corner cases, add some
comments to addist those who follow.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v2:
- Add comments to fault handlers in new, separate, patch.

 arch/mips/lib/memset.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 1cc306520a55..a06dabe99d4b 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -231,16 +231,25 @@
 
 #ifdef CONFIG_CPU_MIPSR6
 .Lbyte_fixup\@:
+	/*
+	 * unset_bytes = current_addr + 1
+	 *      a2     =      t0      + 1
+	 */
 	PTR_SUBU	a2, $0, t0
 	jr		ra
 	 PTR_ADDIU	a2, 1
 #endif /* CONFIG_CPU_MIPSR6 */
 
 .Lfirst_fixup\@:
+	/* unset_bytes already in a2 */
 	jr	ra
 	 nop
 
 .Lfwd_fixup\@:
+	/*
+	 * unset_bytes = partial_start_addr +  #bytes   -     fault_addr
+	 *      a2     =         t1         + (a2 & 3f) - $28->task->BUADDR
+	 */
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, 0x3f
 	LONG_L		t0, THREAD_BUADDR(t0)
@@ -249,6 +258,10 @@
 	 LONG_SUBU	a2, t0
 
 .Lpartial_fixup\@:
+	/*
+	 * unset_bytes = partial_end_addr +      #bytes     -     fault_addr
+	 *      a2     =       a0         + (a2 & STORMASK) - $28->task->BUADDR
+	 */
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
@@ -257,10 +270,15 @@
 	 LONG_SUBU	a2, t0
 
 .Llast_fixup\@:
+	/* unset_bytes already in a2 */
 	jr		ra
 	 nop
 
 .Lsmall_fixup\@:
+	/*
+	 * unset_bytes = end_addr - current_addr + 1
+	 *      a2     =    t1    -      a0      + 1
+	 */
 	PTR_SUBU	a2, t1, a0
 	jr		ra
 	 PTR_ADDIU	a2, 1
-- 
2.7.4
