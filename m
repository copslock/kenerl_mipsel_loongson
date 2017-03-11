Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Mar 2017 06:21:32 +0100 (CET)
Received: from smtpbg202.qq.com ([184.105.206.29]:39383 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993870AbdCKFUFvzjhF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Mar 2017 06:20:05 +0100
X-QQ-mid: bizesmtp8t1489209551th8hsr6xr
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 11 Mar 2017 13:19:10 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82B00A0000000
X-QQ-FEAT: r8geFCKg7nZQtf7ti8dCgjxhE91fMindn7YlS/5TDKMR0XGcCxoYyJW0AYHyn
        CUvBeeDcqBsu63Hytmhq3ft9Cc4dpvhfxXobGmgNFOa1SEbe51GZp7jGR5R5wOjP34Gpbzd
        TDXvFnfHq6x5BQ64OWCCe1egDgEtPSoE/S9Z6YW7IsGfewGT8PoX/+7IsX+0wLO5dAClIyf
        xHrcfnFc1Po1v5ELKUESxe53yEbVuDzHhV6m9v+M8Fg0XEVtBf33uAZWlkhuiGwJ8IZ491D
        yF+ceE1dlJm6yKxIR8t3AXuqH6JWk+ZTNsag==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org,
        Rui Wang <wangr@lemote.com>
Subject: [PATCH V2 2/7] MIPS: Check TLB before handle_ri_rdhwr() for Loongson-3
Date:   Sat, 11 Mar 2017 13:19:53 +0800
Message-Id: <1489209598-30312-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
References: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57140
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



©
