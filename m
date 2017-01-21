Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2017 01:54:51 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:40435 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993014AbdAUAyVTGwy0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2017 01:54:21 +0100
X-QQ-mid: bizesmtp16t1484960037to29ek0b
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 21 Jan 2017 08:53:38 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72B00A0000000
X-QQ-FEAT: zwoLj9LdjHtr5qCn53OXAZFe4p+rHz/zf2J9dB8kwGxV8eJd135Jjyq2F8Yhj
        ANS6dUq1Y9M7aA8qaq9yvFEwgF/jC7HYmpXpSHuMkPQlRJPWvgyM3yRnmneWWrfB9fEzuRq
        pIcjKOkG/sWm7lvzKqfxKa+azyXCMEIo85eulthRYU3/95R4Xijzz1Nri5z0x8TMY/XxQXd
        W75R0Cno+SLL/kT/uq2Tj2N4Vy8oV5SlxYckc5ORdfc2B+Mc/de67AN7Y7qiNvlMh20I5eF
        OpqwXRJhqCiPJJgooCRWtFWPSdLE4Z3N/Rx4gLXGejEoqa
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org,
        Rui Wang <wangr@lemote.com>
Subject: [PATCH RESEND 2/4] MIPS: Check TLB before handle_ri_rdhwr() for Loongson-3
Date:   Sat, 21 Jan 2017 08:56:04 +0800
Message-Id: <1484960166-30022-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1484960166-30022-1-git-send-email-chenhc@lemote.com>
References: <1484960166-30022-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56437
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

Loongson-3's micro TLB (ITLB) is not strictly a subset of JTLB. That
means: when a JTLB entry is replaced by hardware, there may be an old
valid entry exists in ITLB. So, a TLB miss exception may occur while
handle_ri_rdhwr() is running because it try to access EPC's content.
However, handle_ri_rdhwr() doesn't clear EXL, which makes a TLB Refill
exception be treated as a TLB Invalid exception and tlbp may fail. In
this case, if FTLB (which is usually set-associative instead of set-
associative) is enabled, a tlbp failure will cause an invalid tlbwi,
which will hang the whole system.

This patch rename handle_ri_rdhwr_vivt to handle_ri_rdhwr_tlbp and use
it for Loongson-3. It try to solve the same problem described as below,
but more straightforwards.

https://patchwork.linux-mips.org/patch/12591/

I think Loongson-2 has the same problem, but it has no FTLB, so we just
keep it as is.

Cc: <stable@vger.kernel.org>
Cc: Rui Wang <wangr@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/genex.S |  4 ++--
 arch/mips/kernel/traps.c | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 0a7ba4b..3a98ef6 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -519,7 +519,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER reserved reserved sti verbose	/* others */
 
 	.align	5
-	LEAF(handle_ri_rdhwr_vivt)
+	LEAF(handle_ri_rdhwr_tlbp)
 	.set	push
 	.set	noat
 	.set	noreorder
@@ -538,7 +538,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	pop
 	bltz	k1, handle_ri	/* slow path */
 	/* fall thru */
-	END(handle_ri_rdhwr_vivt)
+	END(handle_ri_rdhwr_tlbp)
 
 	LEAF(handle_ri_rdhwr)
 	.set	push
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cb479be3..0ed01a3 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -82,7 +82,7 @@ extern asmlinkage void handle_dbe(void);
 extern asmlinkage void handle_sys(void);
 extern asmlinkage void handle_bp(void);
 extern asmlinkage void handle_ri(void);
-extern asmlinkage void handle_ri_rdhwr_vivt(void);
+extern asmlinkage void handle_ri_rdhwr_tlbp(void);
 extern asmlinkage void handle_ri_rdhwr(void);
 extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
@@ -2407,9 +2407,18 @@ void __init trap_init(void)
 
 	set_except_vector(EXCCODE_SYS, handle_sys);
 	set_except_vector(EXCCODE_BP, handle_bp);
-	set_except_vector(EXCCODE_RI, rdhwr_noopt ? handle_ri :
-			  (cpu_has_vtag_icache ?
-			   handle_ri_rdhwr_vivt : handle_ri_rdhwr));
+
+	if (rdhwr_noopt)
+		set_except_vector(EXCCODE_RI, handle_ri);
+	else {
+		if (cpu_has_vtag_icache)
+			set_except_vector(EXCCODE_RI, handle_ri_rdhwr_tlbp);
+		else if (current_cpu_type() == CPU_LOONGSON3)
+			set_except_vector(EXCCODE_RI, handle_ri_rdhwr_tlbp);
+		else
+			set_except_vector(EXCCODE_RI, handle_ri_rdhwr);
+	}
+
 	set_except_vector(EXCCODE_CPU, handle_cpu);
 	set_except_vector(EXCCODE_OV, handle_ov);
 	set_except_vector(EXCCODE_TR, handle_tr);
-- 
2.7.0
