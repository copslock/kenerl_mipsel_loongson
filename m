Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 04:56:17 +0200 (CEST)
Received: from smtpbgau1.qq.com ([54.206.16.166]:58237 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007935AbbC2CzL0Bw3o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Mar 2015 04:55:11 +0200
X-QQ-mid: bizesmtp2t1427597658t862t045
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 29 Mar 2015 10:54:18 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52B00A0000000
X-QQ-FEAT: /peYvah/M2UOdDXNwWx6ThDSsc7XnR+30CdBqGvpbVRhRb/bxxVOE5ESNoGAD
        zssJChxd2HCPZW89B1V8qp4xt4Ac5xHc9CD3rMJp0+NpPn7PSTFWh/6WDuH3IMKyTFu76VN
        HHCbl1XWwMuFWJQCx5EOiVJVY81u4YBNhtWZjC0ADPwDsFhoBrj9y3WPE9eqJkLOP/+paMj
        IEaziaz5muWwzQlfvMuTxvToxnajYVD4rhH7w9XJ/Vg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH V9 1/7] MIPS: Hibernate: flush TLB entries earlier
Date:   Sun, 29 Mar 2015 10:54:05 +0800
Message-Id: <1427597650-2368-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
References: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

We found that TLB mismatch not only happens after kernel resume, but
also happens during snapshot restore. So move it to the beginning of
swsusp_arch_suspend().

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/power/hibernate.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 32a7c82..e7567c8 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
 END(swsusp_arch_suspend)
 
 LEAF(swsusp_arch_resume)
+	/* Avoid TLB mismatch during and after kernel resume */
+	jal local_flush_tlb_all
 	PTR_L t0, restore_pblist
 0:
 	PTR_L t1, PBE_ADDRESS(t0)   /* source */
@@ -43,7 +45,6 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
-	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
-- 
1.7.7.3
