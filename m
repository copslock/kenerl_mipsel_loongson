Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:56:42 +0100 (CET)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34875 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012406AbcBIU4Jy0eSb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:56:09 +0100
Received: by mail-pf0-f178.google.com with SMTP id c10so66655190pfc.2;
        Tue, 09 Feb 2016 12:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gGpyyCJStnEWaWADbAq0nNNW/9NWucufxGrMAzA3hcA=;
        b=V2lWb1/snzbdpa+oCeLGySTGcAG5mckzrY4039yMyvXWPcH5VF5Oq+FTZHrv8w18sW
         1zAYT65hPfmDhNjwxBDkkpA0Drxfww5es/JR26TU23QpUPsy34whHaCcajnMCovRmMG0
         gKg7u14JpCX0GIk8KqFbN8Jdxi9zVL7kFavpT0kxKywTJ9VCKgDY7dBHgrZJnqlIahbo
         /VAbSMgpGLAnXVk1wr1PPeaKo7bIjdk8sBKJEPdvzau3jzh7IGcSLi/tVuyvfhl9zqtH
         kxJmpSaagZWLBk8Z7u+MOLSr0Yr5fVOX+O37hs127uDyO30DnG2rFDJCEyTWsZ0feCQO
         z3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gGpyyCJStnEWaWADbAq0nNNW/9NWucufxGrMAzA3hcA=;
        b=ZvRkKE7OPnjTU7YyPK6DA9p9y3/9pyz9SrbVpWMoE6irVruaMClH7+zlqxn1hRiCj4
         whKMVkUfAWdNir68Y7QA5nVLWndCdpt7EZoUnO2kWVWDqtobtTai1NKSWllC4m15Zeqv
         w1T9+ZAnpgFDLsYzsbrYXf/2ZX5SDGB+LWUsOan3VZ35BtTZSlG4RpIysARnJSy6LsBG
         0yaMEtL/78J1R+19lYpX7StroZ3cC8yyeB2QL+mu7z0MVM5YXLGbUmu2Cj66cIUJB7h0
         qijihxxKMZ6prLNKd43mZlPQD8vDNpdbJnn2ERzT9lVSbhx3PUiVmJsg3t4zM6Csh6H5
         4iAg==
X-Gm-Message-State: AG10YOTHqchPhr963rbhFCfjZsgYUoeCXg/lXvMhzeW1iNvzfdNch7iD8UuptQB5RItBuw==
X-Received: by 10.98.64.83 with SMTP id n80mr53257229pfa.149.1455051364221;
        Tue, 09 Feb 2016 12:56:04 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id n4sm52684059pfi.3.2016.02.09.12.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 12:56:03 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/6] MIPS: BMIPS: Add early CPU initialization code
Date:   Tue,  9 Feb 2016 12:55:50 -0800
Message-Id: <1455051354-6225-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Port the stblinux-3.3 code to perform a bunch of CPU-specific initialization,
make it compatible with run-time detection of the CPU, and unroll the
brcmstb-specific macros: BDEV_RB(), BDEV_UNSET.

The "pref 30" disabling is done as a quirk. This is a preliminary change to
allow the use of the "rotr" instruction gated by cpu_has_rixi.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bmips/setup.c       |  1 +
 arch/mips/include/asm/bmips.h |  1 +
 arch/mips/kernel/smp-bmips.c  | 87 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 9c8f15daf5e9..de31559f6f72 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -127,6 +127,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
 
 void __init prom_init(void)
 {
+	bmips_cpu_setup();
 	register_bmips_smp_ops();
 }
 
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 6d25ad33ec78..a92aee7b977a 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -88,6 +88,7 @@ extern unsigned long bmips_tp1_irqs;
 
 extern void bmips_ebase_setup(void);
 extern asmlinkage void plat_wired_tlb_setup(void);
+extern void bmips_cpu_setup(void);
 
 static inline unsigned long bmips_read_zscm_reg(unsigned int offset)
 {
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 78cf8c2f1de0..6835cb13ea9e 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -565,3 +565,90 @@ asmlinkage void __weak plat_wired_tlb_setup(void)
 	 * once the wired entries are present.
 	 */
 }
+
+void __init bmips_cpu_setup(void)
+{
+	void __iomem __maybe_unused *cbr = BMIPS_GET_CBR();
+	u32 __maybe_unused cfg;
+
+	switch (current_cpu_type()) {
+	case CPU_BMIPS3300:
+		/* Set BIU to async mode */
+		set_c0_brcm_bus_pll(BIT(22));
+		__sync();
+
+		/* put the BIU back in sync mode */
+		clear_c0_brcm_bus_pll(BIT(22));
+
+		/* clear BHTD to enable branch history table */
+		clear_c0_brcm_reset(BIT(16));
+
+		/* Flush and enable RAC */
+		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0x100, BMIPS_RAC_CONFIG);
+		__raw_readl(cbr + BMIPS_RAC_CONFIG);
+
+		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0xf, BMIPS_RAC_CONFIG);
+		__raw_readl(cbr + BMIPS_RAC_CONFIG);
+
+		cfg = __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
+		__raw_writel(cfg | 0x0fff0000, cbr + BMIPS_RAC_ADDRESS_RANGE);
+		__raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
+		break;
+
+	case CPU_BMIPS4380:
+		/* CBG workaround for early BMIPS4380 CPUs */
+		switch (read_c0_prid()) {
+		case 0x2a040:
+		case 0x2a042:
+		case 0x2a044:
+		case 0x2a060:
+			cfg = __raw_readl(cbr + BMIPS_L2_CONFIG);
+			__raw_writel(cfg & ~0x07000000, cbr + BMIPS_L2_CONFIG);
+			__raw_readl(cbr + BMIPS_L2_CONFIG);
+		}
+
+		/* clear BHTD to enable branch history table */
+		clear_c0_brcm_config_0(BIT(21));
+
+		/* XI/ROTR enable */
+		set_c0_brcm_config_0(BIT(23));
+		set_c0_brcm_cmt_ctrl(BIT(15));
+		break;
+
+	case CPU_BMIPS5000:
+		/* enable RDHWR, BRDHWR */
+		set_c0_brcm_config(BIT(17) | BIT(21));
+
+		/* Disable JTB */
+		__asm__ __volatile__(
+		"	.set	noreorder\n"
+		"	li	$8, 0x5a455048\n"
+		"	.word	0x4088b00f\n"	/* mtc0	t0, $22, 15 */
+		"	.word	0x4008b008\n"	/* mfc0	t0, $22, 8 */
+		"	li	$9, 0x00008000\n"
+		"	or	$8, $8, $9\n"
+		"	.word	0x4088b008\n"	/* mtc0	t0, $22, 8 */
+		"	sync\n"
+		"	li	$8, 0x0\n"
+		"	.word	0x4088b00f\n"	/* mtc0	t0, $22, 15 */
+		"	.set	reorder\n"
+		: : : "$8", "$9");
+
+		/* XI enable */
+		set_c0_brcm_config(BIT(27));
+
+		/* enable MIPS32R2 ROR instruction for XI TLB handlers */
+		__asm__ __volatile__(
+		"	li	$8, 0x5a455048\n"
+		"	.word	0x4088b00f\n"	/* mtc0 $8, $22, 15 */
+		"	nop; nop; nop\n"
+		"	.word	0x4008b008\n"	/* mfc0 $8, $22, 8 */
+		"	lui	$9, 0x0100\n"
+		"	or	$8, $9\n"
+		"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
+		: : : "$8", "$9");
+		break;
+	}
+}
-- 
2.1.0
