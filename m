Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 12:57:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33007 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008192AbbFDK4qsYUVN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 12:56:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F233CB5DE42DF;
        Thu,  4 Jun 2015 11:56:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Jun 2015 11:56:40 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 4 Jun 2015 11:56:39 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] MIPS: net: BPF: Move register definition to the BPF header
Date:   Thu, 4 Jun 2015 11:56:14 +0100
Message-ID: <1433415376-20952-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The registers will be used by a subsequent patch introducing
ASM helpers so move them to a common header.

Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 35 -----------------------------------
 arch/mips/net/bpf_jit.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 84cd09ba230a..954df295f945 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -63,41 +63,6 @@
 
 #define ptr typeof(unsigned long)
 
-/* ABI specific return values */
-#ifdef CONFIG_32BIT /* O32 */
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-#define r_err	MIPS_R_V1
-#define r_val	MIPS_R_V0
-#else /* CONFIG_CPU_LITTLE_ENDIAN */
-#define r_err	MIPS_R_V0
-#define r_val	MIPS_R_V1
-#endif
-#else /* N64 */
-#define r_err	MIPS_R_V0
-#define r_val	MIPS_R_V0
-#endif
-
-#define r_ret	MIPS_R_V0
-
-/*
- * Use 2 scratch registers to avoid pipeline interlocks.
- * There is no overhead during epilogue and prologue since
- * any of the $s0-$s6 registers will only be preserved if
- * they are going to actually be used.
- */
-#define r_off		MIPS_R_S2
-#define r_A		MIPS_R_S3
-#define r_X		MIPS_R_S4
-#define r_skb		MIPS_R_S5
-#define r_M		MIPS_R_S6
-#define r_s0		MIPS_R_T4 /* scratch reg 1 */
-#define r_s1		MIPS_R_T5 /* scratch reg 2 */
-#define r_tmp_imm	MIPS_R_T6 /* No need to preserve this */
-#define r_tmp		MIPS_R_T7 /* No need to preserve this */
-#define r_zero		MIPS_R_ZERO
-#define r_sp		MIPS_R_SP
-#define r_ra		MIPS_R_RA
-
 #define SCRATCH_OFF(k)		(4 * (k))
 
 /* JIT flags */
diff --git a/arch/mips/net/bpf_jit.h b/arch/mips/net/bpf_jit.h
index f9b5a4d3dbf4..3afa7a6d81b3 100644
--- a/arch/mips/net/bpf_jit.h
+++ b/arch/mips/net/bpf_jit.h
@@ -43,4 +43,39 @@
 #define MIPS_COND_X	(0x1 << 5)
 #define MIPS_COND_K	(0x1 << 6)
 
+/* ABI specific return values */
+#ifdef CONFIG_32BIT /* O32 */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define r_err	MIPS_R_V1
+#define r_val	MIPS_R_V0
+#else /* CONFIG_CPU_LITTLE_ENDIAN */
+#define r_err	MIPS_R_V0
+#define r_val	MIPS_R_V1
+#endif
+#else /* N64 */
+#define r_err	MIPS_R_V0
+#define r_val	MIPS_R_V0
+#endif
+
+#define r_ret	MIPS_R_V0
+
+/*
+ * Use 2 scratch registers to avoid pipeline interlocks.
+ * There is no overhead during epilogue and prologue since
+ * any of the $s0-$s6 registers will only be preserved if
+ * they are going to actually be used.
+ */
+#define r_off		MIPS_R_S2
+#define r_A		MIPS_R_S3
+#define r_X		MIPS_R_S4
+#define r_skb		MIPS_R_S5
+#define r_M		MIPS_R_S6
+#define r_s0		MIPS_R_T4 /* scratch reg 1 */
+#define r_s1		MIPS_R_T5 /* scratch reg 2 */
+#define r_tmp_imm	MIPS_R_T6 /* No need to preserve this */
+#define r_tmp		MIPS_R_T7 /* No need to preserve this */
+#define r_zero		MIPS_R_ZERO
+#define r_sp		MIPS_R_SP
+#define r_ra		MIPS_R_RA
+
 #endif /* BPF_JIT_MIPS_OP_H */
-- 
2.4.2
