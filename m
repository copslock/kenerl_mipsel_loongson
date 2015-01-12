Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 08:08:20 +0100 (CET)
Received: from jaguar.aricent.com ([180.151.2.24]:41155 "EHLO
        jaguar.aricent.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011344AbbALHIImVyxx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 08:08:08 +0100
Received: from jaguar.aricent.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F48B218B95;
        Mon, 12 Jan 2015 12:38:02 +0530 (IST)
Received: from GUREXHT01.ASIAN.AD.ARICENT.COM (unknown [10.203.171.136])
        by jaguar.aricent.com (Postfix) with ESMTPS id 2FDCF218B78;
        Mon, 12 Jan 2015 12:38:02 +0530 (IST)
Received: from imsseuq.aricent.com (10.203.171.248) by
 GUREXHT01.ASIAN.AD.ARICENT.COM (10.203.171.136) with Microsoft SMTP Server id
 8.3.342.0; Mon, 12 Jan 2015 12:38:00 +0530
Received: from h2512.localdomain ([172.16.116.228])     by imsseuq.aricent.com
 (8.13.1/8.13.1) with ESMTP id t0C6VBrF019509;  Mon, 12 Jan 2015 12:01:35 +0530
From:   Abhishek Paliwal <abhishek.paliwal@aricent.com>
To:     <kexin.hao@windriver.com>, <bo.liu@windriver.com>
CC:     Chandrakala.Chavva@caviumnetworks.com, rakesh.garg@aricent.com,
        Abhishek Paliwal <abhishek.paliwal@aricent.com>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 5/9] MIPS donot build fast TLB refill handler with 32-bit  kernels.
Date:   Mon, 12 Jan 2015 12:36:21 +0530
Message-ID: <1421046385-2535-6-git-send-email-abhishek.paliwal@aricent.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
References: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
Return-Path: <abhishek.paliwal@aricent.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhishek.paliwal@aricent.com
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

commit  35d0470668cca234e49ed35342b3f9a0eec8355c upstream

The fast handler only supports 64-bit kernels.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/7010/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Abhishek Paliwal <abhishek.paliwal@aricent.com>
---
 arch/mips/mm/tlbex.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index aa24119..c05f2fd 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1247,13 +1247,17 @@ static void build_r4000_tlb_refill_handler(void)
        unsigned int final_len;
        struct mips_huge_tlb_info htlb_info __maybe_unused;
        enum vmalloc64_mode vmalloc_mode __maybe_unused;
-
+#ifdef CONFIG_64BIT
+       bool is64bit = true;
+#else
+       bool is64bit = false;
+#endif
        memset(tlb_handler, 0, sizeof(tlb_handler));
        memset(labels, 0, sizeof(labels));
        memset(relocs, 0, sizeof(relocs));
        memset(final_handler, 0, sizeof(final_handler));

-       if ((scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
+       if (is64bit && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
                htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
                                                          scratch_reg);
                vmalloc_mode = refill_scratch;
--
1.8.1.4



"DISCLAIMER: This message is proprietary to Aricent and is intended solely for the use of the individual to whom it is addressed. It may contain privileged or confidential information and should not be circulated or used for any purpose other than for what it is intended. If you have received this message in error, please notify the originator immediately. If you are not the intended recipient, you are notified that you are strictly prohibited from using, copying, altering, or disclosing the contents of this message. Aricent accepts no responsibility for loss or damage arising from the use of the information transmitted by this email including damage from virus."
