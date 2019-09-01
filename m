Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98082C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8EF22CF7
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 07:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfIAH4p (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 03:56:45 -0400
Received: from SMTPBG366.QQ.COM ([14.215.154.251]:38087 "EHLO SMTPBG366.QQ.COM"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfIAH4p (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 1 Sep 2019 03:56:45 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Sep 2019 03:56:24 EDT
X-QQ-mid: bizesmtp26t1567324108tlvr7mch
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp10.qq.com (ESMTP) with 
        id ; Sun, 01 Sep 2019 15:48:19 +0800 (CST)
X-QQ-SSF: 01100000002000O0ZG52B00A0000000
X-QQ-FEAT: OS3dB3SBrL+Q0akJulzRkWQOryG7XlaKtTetBvzF84o12PjMcHD9giq4yvHho
        3sJxKlHY61fTyhOLOfuoC/9PXP2FiwvigOa2aWU8inweywJq9owyI9eM3lhxBeiwR+elwb2
        JrhSWhI5gh0fxJvtRx5NJu2wa2T/Yxt7P+XaofOZIiSov8xlxjcjRv9D9FSae7+xchA2ckd
        aFqi2h4qD8nZld2vSaTkWI+gtTAOdLsoDyNxB0xRBLXydzuCksBJ8ZxKUc1MkLB7IdRlk/W
        reE+MO4Gk7YKUCbq8oaaK5gb4Emujn29hImtmlFajAVT/sQ9pmpf/q7O0EgBdpw2dwwSqlI
        XxvRw2zpQVP5p+VLLo=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] MIPS: Loongson: Add CFUCFG&CSR support
Date:   Sun,  1 Sep 2019 15:49:51 +0800
Message-Id: <1567324193-7340-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgweb:qybgweb5
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Loongson-3A R4+ (Loongson-3A4000 and newer) has CPUCFG (CPU config) and
CSR (Control and Status Register) extensions. This patch add read/write
functionalities for them.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../include/asm/mach-loongson64/loongson_regs.h    | 227 +++++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-loongson64/loongson_regs.h

diff --git a/arch/mips/include/asm/mach-loongson64/loongson_regs.h b/arch/mips/include/asm/mach-loongson64/loongson_regs.h
new file mode 100644
index 0000000..6e3569a
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/loongson_regs.h
@@ -0,0 +1,227 @@
+/*
+ * Read/Write Loongson Extension Registers
+ */
+
+#ifndef _LOONGSON_REGS_H_
+#define _LOONGSON_REGS_H_
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+#include <asm/mipsregs.h>
+#include <asm/cpu.h>
+
+static inline bool cpu_has_cfg(void)
+{
+	return ((read_c0_prid() & PRID_IMP_MASK) == PRID_IMP_LOONGSON_64G);
+}
+
+static inline u32 read_cpucfg(u32 reg)
+{
+	u32 __res;
+
+	__asm__ __volatile__(
+		"parse_r __res,%0\n\t"
+		"parse_r reg,%1\n\t"
+		".insn \n\t"
+		".word (0xc8080118 | (reg << 21) | (__res << 11))\n\t"
+		:"=r"(__res)
+		:"r"(reg)
+		:
+		);
+	return __res;
+}
+
+/* Bit Domains for CFG registers */
+#define LOONGSON_CFG0	0x0
+#define LOONGSON_CFG0_PRID GENMASK(31, 0)
+
+#define LOONGSON_CFG1 0x1
+#define LOONGSON_CFG1_FP	BIT(0)
+#define LOONGSON_CFG1_FPREV	GENMASK(3, 1)
+#define LOONGSON_CFG1_MMI	BIT(4)
+#define LOONGSON_CFG1_MSA1	BIT(5)
+#define LOONGSON_CFG1_MSA2	BIT(6)
+#define LOONGSON_CFG1_CGP	BIT(7)
+#define LOONGSON_CFG1_WRP	BIT(8)
+#define LOONGSON_CFG1_LSX1	BIT(9)
+#define LOONGSON_CFG1_LSX2	BIT(10)
+#define LOONGSON_CFG1_LASX	BIT(11)
+#define LOONGSON_CFG1_R6FXP	BIT(12)
+#define LOONGSON_CFG1_R6CRCP	BIT(13)
+#define LOONGSON_CFG1_R6FPP	BIT(14)
+#define LOONGSON_CFG1_CNT64	BIT(15)
+#define LOONGSON_CFG1_LSLDR0	BIT(16)
+#define LOONGSON_CFG1_LSPREF	BIT(17)
+#define LOONGSON_CFG1_LSPREFX	BIT(18)
+#define LOONGSON_CFG1_LSSYNCI	BIT(19)
+#define LOONGSON_CFG1_LSUCA	BIT(20)
+#define LOONGSON_CFG1_LLSYNC	BIT(21)
+#define LOONGSON_CFG1_TGTSYNC	BIT(22)
+#define LOONGSON_CFG1_LLEXC	BIT(23)
+#define LOONGSON_CFG1_SCRAND	BIT(24)
+#define LOONGSON_CFG1_MUALP	BIT(25)
+#define LOONGSON_CFG1_KMUALEN	BIT(26)
+#define LOONGSON_CFG1_ITLBT	BIT(27)
+#define LOONGSON_CFG1_LSUPERF	BIT(28)
+#define LOONGSON_CFG1_SFBP	BIT(29)
+#define LOONGSON_CFG1_CDMAP	BIT(30)
+
+#define LOONGSON_CFG2 0x2
+#define LOONGSON_CFG2_LEXT1	BIT(0)
+#define LOONGSON_CFG2_LEXT2	BIT(1)
+#define LOONGSON_CFG2_LEXT3	BIT(2)
+#define LOONGSON_CFG2_LSPW	BIT(3)
+#define LOONGSON_CFG2_LBT1	BIT(4)
+#define LOONGSON_CFG2_LBT2	BIT(5)
+#define LOONGSON_CFG2_LBT3	BIT(6)
+#define LOONGSON_CFG2_LBTMMU	BIT(7)
+#define LOONGSON_CFG2_LPMP	BIT(8)
+#define LOONGSON_CFG2_LPMPREV	GENMASK(11, 9)
+#define LOONGSON_CFG2_LAMO	BIT(12)
+#define LOONGSON_CFG2_LPIXU	BIT(13)
+#define LOONGSON_CFG2_LPIXUN	BIT(14)
+#define LOONGSON_CFG2_LZVP	BIT(15)
+#define LOONGSON_CFG2_LZVREV	GENMASK(18, 16)
+#define LOONGSON_CFG2_LGFTP	BIT(19)
+#define LOONGSON_CFG2_LGFTPREV	GENMASK(22, 20)
+#define LOONGSON_CFG2_LLFTP	BIT(23)
+#define LOONGSON_CFG2_LLFTPREV	GENMASK(24, 26)
+#define LOONGSON_CFG2_LCSRP	BIT(27)
+#define LOONGSON_CFG2_LDISBLIKELY	BIT(28)
+
+#define LOONGSON_CFG3 0x3
+#define LOONGSON_CFG3_LCAMP	BIT(0)
+#define LOONGSON_CFG3_LCAMREV	GENMASK(3, 1)
+#define LOONGSON_CFG3_LCAMNUM	GENMASK(11, 4)
+#define LOONGSON_CFG3_LCAMKW	GENMASK(19, 12)
+#define LOONGSON_CFG3_LCAMVW	GENMASK(27, 20)
+
+#define LOONGSON_CFG4 0x4
+#define LOONGSON_CFG4_CCFREQ	GENMASK(31, 0)
+
+#define LOONGSON_CFG5 0x5
+#define LOONGSON_CFG5_CFM	GENMASK(15, 0)
+#define LOONGSON_CFG5_CFD	GENMASK(31, 16)
+
+#define LOONGSON_CFG6 0x6
+
+#define LOONGSON_CFG7 0x7
+#define LOONGSON_CFG7_GCCAEQRP	BIT(0)
+#define LOONGSON_CFG7_UCAWINP	BIT(1)
+
+static inline bool cpu_has_csr(void)
+{
+	if (cpu_has_cfg())
+		return (read_cpucfg(LOONGSON_CFG2) & LOONGSON_CFG2_LCSRP);
+
+	return false;
+}
+
+static inline u32 csr_readl(u32 reg)
+{
+	u32 __res;
+
+	/* RDCSR reg, val */
+	__asm__ __volatile__(
+		"parse_r __res,%0\n\t"
+		"parse_r reg,%1\n\t"
+		".insn \n\t"
+		".word (0xc8000118 | (reg << 21) | (__res << 11))\n\t"
+		:"=r"(__res)
+		:"r"(reg)
+		:
+		);
+	return __res;
+}
+
+static inline u64 csr_readq(u32 reg)
+{
+	u64 __res;
+
+	/* DWRCSR reg, val */
+	__asm__ __volatile__(
+		"parse_r __res,%0\n\t"
+		"parse_r reg,%1\n\t"
+		".insn \n\t"
+		".word (0xc8020118 | (reg << 21) | (__res << 11))\n\t"
+		:"=r"(__res)
+		:"r"(reg)
+		:
+		);
+	return __res;
+}
+
+static inline void csr_writel(u32 val, u32 reg)
+{
+	/* WRCSR reg, val */
+	__asm__ __volatile__(
+		"parse_r reg,%0\n\t"
+		"parse_r val,%1\n\t"
+		".insn \n\t"
+		".word (0xc8010118 | (reg << 21) | (val << 11))\n\t"
+		:
+		:"r"(reg),"r"(val)
+		:
+		);
+}
+
+static inline void csr_writeq(u64 val, u32 reg)
+{
+	/* DWRCSR reg, val */
+	__asm__ __volatile__(
+		"parse_r reg,%0\n\t"
+		"parse_r val,%1\n\t"
+		".insn \n\t"
+		".word (0xc8030118 | (reg << 21) | (val << 11))\n\t"
+		:
+		:"r"(reg),"r"(val)
+		:
+		);
+}
+
+/* Public CSR Register can also be accessed with regular addresses */
+#define CSR_PUBLIC_MMIO_BASE 0x1fe00000
+
+#define MMIO_CSR(x)		(void *)TO_UNCAC(CSR_PUBLIC_MMIO_BASE + x)
+
+#define LOONGSON_CSR_FEATURES	0x8
+#define LOONGSON_CSRF_TEMP	BIT(0)
+#define LOONGSON_CSRF_NODECNT	BIT(1)
+#define LOONGSON_CSRF_MSI	BIT(2)
+#define LOONGSON_CSRF_EXTIOI	BIT(3)
+#define LOONGSON_CSRF_IPI	BIT(4)
+#define LOONGSON_CSRF_FREQ	BIT(5)
+
+#define LOONGSON_CSR_VENDOR	0x10 /* Vendor name string, should be "Loongson" */
+#define LOONGSON_CSR_CPUNAME	0x20 /* Processor name string */
+#define LOONGSON_CSR_NODECNT	0x408
+#define LOONGSON_CSR_CPUTEMP	0x428
+
+/* PerCore CSR, only accessable by local cores */
+#define LOONGSON_CSR_IPI_STATUS	0x1000
+#define LOONGSON_CSR_IPI_EN	0x1004
+#define LOONGSON_CSR_IPI_SET	0x1008
+#define LOONGSON_CSR_IPI_CLEAR	0x100c
+#define LOONGSON_CSR_IPI_SEND	0x1040
+#define CSR_IPI_SEND_IP_SHIFT	0
+#define CSR_IPI_SEND_CPU_SHIFT	16
+#define CSR_IPI_SEND_BLOCK	BIT(31)
+
+static inline u64 drdtime(void)
+{
+	int rID = 0;
+	u64 val = 0;
+
+	__asm__ __volatile__(
+		"parse_r rID,%0\n\t"
+		"parse_r val,%1\n\t"
+		".insn \n\t"
+		".word (0xc8090118 | (rID << 21) | (val << 11))\n\t"
+		:"=r"(rID),"=r"(val)
+		:
+		);
+	return val;
+}
+
+#endif
-- 
2.7.0

