Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 05:46:30 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:39756 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeFTDqW30FwM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 05:46:22 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx26.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 20 Jun 2018 03:46:18 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 20:46:16 -0700
Received: from pburton-laptop.ba.imgtec.org (10.20.78.225) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Tue, 19 Jun 2018 20:46:16 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2] MIPS: Wire up io_pgetevents syscall
Date:   Tue, 19 Jun 2018 20:46:15 -0700
Message-ID: <20180620034615.17579-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615083543.GA7603@jamesdev>
References: <20180615083543.GA7603@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529466378-853316-12155-20586-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194213
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,jhogan@kernel.org,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Wire up the io_pgetevents syscall that was introduced by commit
7a074e96dee6 ("aio: implement io_pgetevents").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---
This will conflict with the rseq patches, but is trivial to fixup.

Changes in v2:
- Use compat_sys_io_pgetevents for o32 & n32 on MIPS64 kernels.

 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index bb05e9916a5f..41a01e29c4ff 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -388,17 +388,18 @@
 #define __NR_pkey_alloc			(__NR_Linux + 364)
 #define __NR_pkey_free			(__NR_Linux + 365)
 #define __NR_statx			(__NR_Linux + 366)
+#define __NR_io_pgetevents		(__NR_Linux + 367)
 
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		366
+#define __NR_Linux_syscalls		367
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		366
+#define __NR_O32_Linux_syscalls		367
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -733,16 +734,17 @@
 #define __NR_pkey_alloc			(__NR_Linux + 324)
 #define __NR_pkey_free			(__NR_Linux + 325)
 #define __NR_statx			(__NR_Linux + 326)
+#define __NR_io_pgetevents		(__NR_Linux + 327)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		326
+#define __NR_Linux_syscalls		327
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		326
+#define __NR_64_Linux_syscalls		327
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1081,15 +1083,16 @@
 #define __NR_pkey_alloc			(__NR_Linux + 328)
 #define __NR_pkey_free			(__NR_Linux + 329)
 #define __NR_statx			(__NR_Linux + 330)
+#define __NR_io_pgetevents		(__NR_Linux + 331)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		330
+#define __NR_Linux_syscalls		331
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		330
+#define __NR_N32_Linux_syscalls		331
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a9a7d78803cd..7010fedee283 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -590,3 +590,4 @@ EXPORT(sys_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 4365 */
 	PTR	sys_statx
+	PTR	sys_io_pgetevents
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 65d5aeeb9bdb..c6602079c46f 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -439,4 +439,5 @@ EXPORT(sys_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 5325 */
 	PTR	sys_statx
+	PTR	sys_io_pgetevents
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index cbf190ef9e8a..4959b103f7a9 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -434,4 +434,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free
 	PTR	sys_statx			/* 6330 */
+	PTR	compat_sys_io_pgetevents
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 9ebe3e2403b1..433c7da31dbf 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -583,4 +583,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 4365 */
 	PTR	sys_statx
+	PTR	compat_sys_io_pgetevents
 	.size	sys32_call_table,.-sys32_call_table
-- 
2.17.1
