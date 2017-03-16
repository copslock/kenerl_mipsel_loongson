Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 14:01:51 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:43802 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991955AbdCPNBnhL2p- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 14:01:43 +0100
X-QQ-mid: bizesmtp3t1489669273tpubs2qpj
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 16 Mar 2017 20:59:34 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82B00A0000000
X-QQ-FEAT: 6dXuswn9i1XkKQy+x6LHQhr6m86ZsqaYMT4wsuUbfvNbb4B1lGjQwn0dL4S5M
        EjLvmgW6oiMHz1jTQTSEFcylyGrWcsyWzYEPD/ekt186msFJNFWVevJCl/K+7Yz8cztRJUN
        KMVgb/iJvBgAe6qeiaXZHk6tokQgamRqPooeILQnx3zLg4ZncFPpG8nS4tUkHEtJvIS8SZU
        +w+6ZAw6KyZRJwBoAadca1/XjwL2jEjPFpZlgm5PLxdCWWQlbySPQTsz1eFzxU4pP7sBzS1
        F/ehrafvzs0oZmC42cyqxoJyo9p1rl4IqwQT3an2zi2kRP
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org,
        Rui Wang <wangr@lemote.com>
Subject: [PATCH RESEND V2 2/7] MIPS: Check TLB before handle_ri_rdhwr() for Loongson-3
Date:   Thu, 16 Mar 2017 21:00:26 +0800
Message-Id: <1489669231-28162-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1489669231-28162-1-git-send-email-chenhc@lemote.com>
References: <1489669231-28162-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57324
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
index 7ec9612..2ac6c26 100644
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
index c7d17cf..b49e7bf 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -83,7 +83,7 @@ extern asmlinkage void handle_dbe(void);
 extern asmlinkage void handle_sys(void);
 extern asmlinkage void handle_bp(void);
 extern asmlinkage void handle_ri(void);
-extern asmlinkage void handle_ri_rdhwr_vivt(void);
+extern asmlinkage void handle_ri_rdhwr_tlbp(void);
 extern asmlinkage void handle_ri_rdhwr(void);
 extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
@@ -2408,9 +2408,18 @@ void __init trap_init(void)
 
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
