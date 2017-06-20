Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 10:58:31 +0200 (CEST)
Received: from smtpbg327.qq.com ([14.17.43.158]:59722 "EHLO smtpbg327.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992127AbdFTI52bBgx2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 10:57:28 +0200
X-QQ-mid: bizesmtp2t1497949007t5fhzadsy
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 20 Jun 2017 16:56:46 +0800 (CST)
X-QQ-SSF: 01100000008000F0FIF1000A0000000
X-QQ-FEAT: uPKj8ga2w7GC7blcksfoo3GIR+JD7gX3gUi4CewFSd8gCjl+XYCXOsbrTkldm
        hyB9DKpHXBHizWaOd/Lj1fHfb+0+tYbRniSUDDiIcca+dBc0wx4SDcZrnQl/G8OGDYat688
        v5R4rXNS//Ds3Mk1gnm5u+c1JckGvyvqxlqpl2i9jBQ7SegqHlJa3Ny6Ts6noOXijll3/RU
        IGRTweQ6+TPVFZ7QM4EPgyEfSootbIkVqKnNQxbL2VvVx468z8h+cW/+4JfGMfnTuj2973p
        XNC384oBh2j0gEwvbo6Zqgjjm103S4vpkk4V+kkrNZoXPEA5uVbMximWI=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6?= <Yeking@Red54.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v8 4/9] MIPS: Loongson: Add Loongson-1A Kconfig options
Date:   Tue, 20 Jun 2017 16:57:02 +0800
Message-Id: <1497949027-10988-5-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1497949027-10988-1-git-send-email-zhoubb@lemote.com>
References: <1497949027-10988-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Added Kconfig options include: Loongson-1A CPU and machine definition,
CPU cache features, 32-bit kernel and early printk support.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig            | 12 ++++++++++++
 arch/mips/loongson32/Kconfig | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9891a12..6a4373a8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1424,6 +1424,15 @@ config CPU_LOONGSON2F
 	  have a similar programming interface with FPGA northbridge used in
 	  Loongson2E.
 
+config CPU_LOONGSON1A
+	bool "Loongson 1A"
+	depends on SYS_HAS_CPU_LOONGSON1A
+	select CPU_LOONGSON1
+	select LEDS_GPIO_REGISTER
+	help
+	  The Loongson 1A is a 32-bit SoC, which implements the MIPS32
+	  release 2 instruction set.
+
 config CPU_LOONGSON1B
 	bool "Loongson 1B"
 	depends on SYS_HAS_CPU_LOONGSON1B
@@ -1891,6 +1900,9 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON1A
+	bool
+
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 3c0c2f2..6e0f6ec 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -1,8 +1,28 @@
 if MACH_LOONGSON32
 
+config ZONE_DMA
+	prompt "Zone DMA"
+	bool
+
 choice
 	prompt "Machine Type"
 
+config LOONGSON1_LS1A
+	bool "Loongson LS1A board"
+	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
+	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
+	select SYS_HAS_CPU_LOONGSON1A
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select IRQ_MIPS_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_MIPS16
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select COMMON_CLK
+
 config LOONGSON1_LS1B
 	bool "Loongson LS1B board"
 	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
-- 
2.9.4
