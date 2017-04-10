Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:54:13 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993950AbdDJQwBZWc4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:52:01 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D2CEB88;
        Mon, 10 Apr 2017 16:51:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Rui Wang <wangr@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 057/110] MIPS: Check TLB before handle_ri_rdhwr() for Loongson-3
Date:   Mon, 10 Apr 2017 18:42:48 +0200
Message-Id: <20170410164204.407585990@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410164201.247583164@linuxfoundation.org>
References: <20170410164201.247583164@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 5a34133167dce36666ea054e30a561b7f4413b7f upstream.

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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Rui Wang <wangr@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15753/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/genex.S |    4 ++--
 arch/mips/kernel/traps.c |   17 +++++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -448,7 +448,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER reserved reserved sti verbose	/* others */
 
 	.align	5
-	LEAF(handle_ri_rdhwr_vivt)
+	LEAF(handle_ri_rdhwr_tlbp)
 	.set	push
 	.set	noat
 	.set	noreorder
@@ -467,7 +467,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	pop
 	bltz	k1, handle_ri	/* slow path */
 	/* fall thru */
-	END(handle_ri_rdhwr_vivt)
+	END(handle_ri_rdhwr_tlbp)
 
 	LEAF(handle_ri_rdhwr)
 	.set	push
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -81,7 +81,7 @@ extern asmlinkage void handle_dbe(void);
 extern asmlinkage void handle_sys(void);
 extern asmlinkage void handle_bp(void);
 extern asmlinkage void handle_ri(void);
-extern asmlinkage void handle_ri_rdhwr_vivt(void);
+extern asmlinkage void handle_ri_rdhwr_tlbp(void);
 extern asmlinkage void handle_ri_rdhwr(void);
 extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
@@ -2352,9 +2352,18 @@ void __init trap_init(void)
 
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
