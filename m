Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 20:24:58 +0200 (CEST)
Received: from a23-79-238-179.deploy.static.akamaitechnologies.com ([23.79.238.179]:28320
        "EHLO prod-mail-xrelay05.akamai.com" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012025AbbHZSYeJgqPw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 20:24:34 +0200
Received: from prod-mail-xrelay05.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 62D3147411;
        Wed, 26 Aug 2015 18:24:28 +0000 (GMT)
Received: from prod-mail-relay11.akamai.com (prod-mail-relay11.akamai.com [172.27.118.250])
        by prod-mail-xrelay05.akamai.com (Postfix) with ESMTP id 3810647CBC;
        Wed, 26 Aug 2015 18:24:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1440613468; bh=17uNkZUI05zpnO+Xamy5detHDNDyDqUk7SmlYh2gCVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqNq6r+p/i5AzdedikHC1lgE1HH6FUqXel3caBcpE/XHwr+cfFmipcD6R5XYsjBrf
         1QTuY/QwoSX1CuoiT7U4oIaT9CehdQ38EmnO8wa0McMfK9uruVZb7VTd3A1e44UTya
         o++7kHKcZuilAR+IRWkziBoEo6wk5hYSgc5UbU38=
Received: from bos-lp6ds.kendall.corp.akamai.com (bos-lp6ds.kendall.corp.akamai.com [172.28.12.119])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 2FB1A2044;
        Wed, 26 Aug 2015 18:24:28 +0000 (GMT)
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric B Munson <emunson@akamai.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/6] mips: Add entry for new mlock2 syscall
Date:   Wed, 26 Aug 2015 14:24:25 -0400
Message-Id: <1440613465-30393-7-git-send-email-emunson@akamai.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1440613465-30393-1-git-send-email-emunson@akamai.com>
References: <1440613465-30393-1-git-send-email-emunson@akamai.com>
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
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

A previous commit introduced the new mlock2 syscall, add entries for the
MIPS architecture.

Signed-off-by: Eric B Munson <emunson@akamai.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index c03088f..d0bdfaa 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -377,16 +377,17 @@
 #define __NR_memfd_create		(__NR_Linux + 354)
 #define __NR_bpf			(__NR_Linux + 355)
 #define __NR_execveat			(__NR_Linux + 356)
+#define __NR_mlock2			(__NR_Linux + 357)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		356
+#define __NR_Linux_syscalls		357
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		356
+#define __NR_O32_Linux_syscalls		357
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -711,16 +712,17 @@
 #define __NR_memfd_create		(__NR_Linux + 314)
 #define __NR_bpf			(__NR_Linux + 315)
 #define __NR_execveat			(__NR_Linux + 316)
+#define __NR_mlock2			(__NR_Linux + 317)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		316
+#define __NR_Linux_syscalls		317
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		316
+#define __NR_64_Linux_syscalls		317
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1049,15 +1051,16 @@
 #define __NR_memfd_create		(__NR_Linux + 318)
 #define __NR_bpf			(__NR_Linux + 319)
 #define __NR_execveat			(__NR_Linux + 320)
+#define __NR_mlock2			(__NR_Linux + 321)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		320
+#define __NR_Linux_syscalls		321
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		320
+#define __NR_N32_Linux_syscalls		321
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 4cc1350..b0b377a 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -599,3 +599,4 @@ EXPORT(sys_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf				/* 4355 */
 	PTR	sys_execveat
+	PTR	sys_mlock2
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index a6f6b76..f12eb03 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -436,4 +436,5 @@ EXPORT(sys_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf				/* 5315 */
 	PTR	sys_execveat
+	PTR	sys_mlock2
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 4b20106..ecdd65a 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -429,4 +429,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf
 	PTR	compat_sys_execveat		/* 6320 */
+	PTR	sys_mlock2
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f543ff4..7a8b2df 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -584,4 +584,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf				/* 4355 */
 	PTR	compat_sys_execveat
+	PTR	sys_mlock2
 	.size	sys32_call_table,.-sys32_call_table
-- 
1.9.1
