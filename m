Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 12:44:13 +0200 (CEST)
Received: from smtpbg303.qq.com ([184.105.206.26]:53125 "EHLO smtpbg303.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993612AbdFAKoEXfozy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Jun 2017 12:44:04 +0200
X-QQ-mid: Xesmtp20t1496313809t9nz70ayf
Received: from localhost.localdomain (unknown [113.87.163.71])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 01 Jun 2017 18:41:56 +0800 (CST)
X-QQ-SSF: B0000000000000000M104F00000000U
X-QQ-FEAT: cbPjiZhc9zlbNdcBPa1caCSVX3lolSlfcUpbM3KrWaM26Z79p+brvBByvlbT6
        IGXuX4IT8Qs9US1lNuvVKzNBym3ayRpOzZWUuk68IYfphhIwwvWiDcm3TwVqPPXtvsoOvZh
        JSZplRt/gaUSlUCHg5CPL78E0dkyNvnzKc/XVj7GACSEOOezY0WBfRsfL7dMa8Cq7+3WcpS
        LKYU5RFdTh+YjSujgpO7+gVCBRHxqajvkSIqBJzwJUWDqsAtj04r4T7SkpYmtZm5TYiAZtx
        FQe4oY1sQjCn7XNnwgAVxsN7qInzHnDsiprA==
X-QQ-GoodBg: 0
From:   =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= 
        <Yeking@Red54.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        keguang.zhang@gmail.com, gnaygnil@gmail.com, zhoubb@lemote.com,
        zhangfx@lemote.com, chenhc@lemote.com, wuzhangjin@gmail.com,
        sergei.shtylyov@cogentembedded.com, james.hogan@imgtec.com,
        john@phrozen.org, Steven.Hill@imgtec.com, aurelien@aurel32.net,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= 
        <Yeking@Red54.com>
Subject: [PATCH] MIPS: Loongson: Set Loongson32 to MIPS32R1
Date:   Thu,  1 Jun 2017 18:41:34 +0800
Message-Id: <20170601104134.11585-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
X-QQ-FName: 8ACBDC5ED04A42D49B0607F2215A59E0
X-QQ-LocalIP: 10.198.131.167
Return-Path: <Yeking@Red54.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yeking@Red54.com
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

LS232 (Loonson 2-issue 32-bit, also called GS232 (Godson 2-issue 32-bit))
is the CPU core (microarchitecture) of Loongson 1A/1B/1C.

According to "LS232 用户手册 (LS232 User Manual)", LS232 implements the
MIPS32 Release 1 instruction set, and part of the MIPS32 Release 2
instruction set.

In the manual, LS232 implements all of the MIPS32R2 instruction set
except the FPU instructions, and LS232 also implements 5 FPU
instructions of the MIPS32R2 instruction set: CEIL.L.fmt, CVT.L.fmt,
FLOOR.L.fmt, TRUNC.L.fmt, and ROUND.L.fmt.

But a bug of the DI instruction has been found during tests, the DI
instruction can not disable interrupts in arch_local_irq_disable() with
CONFIG_PREEMPT_NONE=y and CFLAGS='-mno-branch-likely' in some cases.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/mips/Kconfig             | 8 +++++---
 arch/mips/loongson32/Platform | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0b15978..6258786 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1421,7 +1421,8 @@ config CPU_LOONGSON1B
 	select LEDS_GPIO_REGISTER
 	help
 	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
-	  release 2 instruction set.
+	  Release 1 instruction set and part of the MIPS32 Release 2
+	  instruction set.
 
 config CPU_LOONGSON1C
 	bool "Loongson 1C"
@@ -1430,7 +1431,8 @@ config CPU_LOONGSON1C
 	select LEDS_GPIO_REGISTER
 	help
 	  The Loongson 1C is a 32-bit SoC, which implements the MIPS32
-	  release 2 instruction set.
+	  Release 1 instruction set and part of the MIPS32 Release 2
+	  instruction set.
 
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
@@ -1837,7 +1839,7 @@ config CPU_LOONGSON2
 config CPU_LOONGSON1
 	bool
 	select CPU_MIPS32
-	select CPU_MIPSR2
+	select CPU_MIPSR1
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index ffe01c6..efd4a00 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -1,6 +1,6 @@
 cflags-$(CONFIG_CPU_LOONGSON1)	+= \
-	$(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
-	-Wa,-mips32r2 -Wa,--trap
+	$(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
+	-Wa,-mips32 -Wa,--trap
 
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
-- 
2.10.2
