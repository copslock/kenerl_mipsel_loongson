Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:13:09 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:37661 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008621AbaLLWIrRHvCQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:47 +0100
Received: by mail-pd0-f175.google.com with SMTP id g10so5969941pdj.20
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/bHq3DzB/TNL5wfbfg5glvJhJqp0s9ax6XR4orH2hEg=;
        b=bPb3Up2y5RqsJwVZzagkOAoo4/MZebfDx7Rt8XziWQHGXqnrTvatUICtIWR5mRxbI3
         Nc45fw+ryXmk3TWdtBTjpmDnHMWQWRzlcN4luOB4wvu9tVYQ9UdmcPIS+mAOlyzt6Prz
         o35MyPTBpp7lGM6pU0dp60TvElphP/1X0Vn0JcT/+RteSAGqniykBzDC81vXzJUZH4DT
         jDbGPlvGPLk6YHGP/C7s3gZ8G2FXxy2Re1IXPhMenfaC/PGEReyM6cTSBmWRxCzeLYJE
         9sP4XxZq4JCnZszuHpGrqKJ5S1xtrvC/sKdQglj0MjDutnH3JzgdZbFg61pxdpCYqeNN
         tPZQ==
X-Received: by 10.68.211.104 with SMTP id nb8mr30396618pbc.29.1418422121591;
        Fri, 12 Dec 2014 14:08:41 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:41 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 17/23] MIPS: BMIPS: Add quirks for several Broadcom platforms
Date:   Fri, 12 Dec 2014 14:07:08 -0800
Message-Id: <1418422034-17099-18-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

A couple of chips require special handling in order to make SMP secondary
boot and/or exception vectors work correctly.  Take care of these in
setup.c.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/bmips/setup.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index ac402ed..fae800e 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -8,9 +8,12 @@
  */
 
 #include <linux/init.h>
+#include <linux/bitops.h>
 #include <linux/bootmem.h>
 #include <linux/clk-provider.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
@@ -18,9 +21,92 @@
 #include <asm/addrspace.h>
 #include <asm/bmips.h>
 #include <asm/bootinfo.h>
+#include <asm/cpu-type.h>
+#include <asm/mipsregs.h>
 #include <asm/prom.h>
 #include <asm/smp-ops.h>
 #include <asm/time.h>
+#include <asm/traps.h>
+
+#define RELO_NORMAL_VEC		BIT(18)
+
+#define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
+#define BCM6328_TP1_DISABLED	BIT(9)
+
+static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
+
+struct bmips_quirk {
+	const char		*compatible;
+	void			(*quirk_fn)(void);
+};
+
+static void kbase_setup(void)
+{
+	__raw_writel(kbase | RELO_NORMAL_VEC,
+		     BMIPS_GET_CBR() + BMIPS_RELO_VECTOR_CONTROL_1);
+	ebase = kbase;
+}
+
+static void bcm3384_viper_quirks(void)
+{
+	/*
+	 * Some experimental CM boxes are set up to let CM own the Viper TP0
+	 * and let Linux own TP1.  This requires moving the kernel
+	 * load address to a non-conflicting region (e.g. via
+	 * CONFIG_PHYSICAL_START) and supplying an alternate DTB.
+	 * If we detect this condition, we need to move the MIPS exception
+	 * vectors up to an area that we own.
+	 *
+	 * This is distinct from the OTHER special case mentioned in
+	 * smp-bmips.c (boot on TP1, but enable SMP, then TP0 becomes our
+	 * logical CPU#1).  For the Viper TP1 case, SMP is off limits.
+	 *
+	 * Also note that many BMIPS435x CPUs do not have a
+	 * BMIPS_RELO_VECTOR_CONTROL_1 register, so it isn't safe to just
+	 * write VMLINUX_LOAD_ADDRESS into that register on every SoC.
+	 */
+	board_ebase_setup = &kbase_setup;
+	bmips_smp_enabled = 0;
+}
+
+static void bcm63xx_fixup_cpu1(void)
+{
+	/*
+	 * The bootloader has set up the CPU1 reset vector at
+	 * 0xa000_0200.
+	 * This conflicts with the special interrupt vector (IV).
+	 * The bootloader has also set up CPU1 to respond to the wrong
+	 * IPI interrupt.
+	 * Here we will start up CPU1 in the background and ask it to
+	 * reconfigure itself then go back to sleep.
+	 */
+	memcpy((void *)0xa0000200, &bmips_smp_movevec, 0x20);
+	__sync();
+	set_c0_cause(C_SW0);
+	cpumask_set_cpu(1, &bmips_booted_mask);
+}
+
+static void bcm6328_quirks(void)
+{
+	/* Check CPU1 status in OTP (it is usually disabled) */
+	if (__raw_readl(REG_BCM6328_OTP) & BCM6328_TP1_DISABLED)
+		bmips_smp_enabled = 0;
+	else
+		bcm63xx_fixup_cpu1();
+}
+
+static void bcm6368_quirks(void)
+{
+	bcm63xx_fixup_cpu1();
+}
+
+static const struct bmips_quirk bmips_quirk_list[] = {
+	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
+	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
+	{ "brcm,bcm6328",		&bcm6328_quirks			},
+	{ "brcm,bcm6368",		&bcm6368_quirks			},
+	{ },
+};
 
 void __init prom_init(void)
 {
@@ -53,7 +139,8 @@ void __init plat_time_init(void)
 
 void __init plat_mem_setup(void)
 {
-	void *dtb = __dtb_start;
+	void *dtb;
+	const struct bmips_quirk *q;
 
 	set_io_port_base(0);
 	ioport_resource.start = 0;
@@ -62,10 +149,20 @@ void __init plat_mem_setup(void)
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
+	else if (__dtb_start != __dtb_end)
+		dtb = (void *)__dtb_start;
+	else
+		panic("no dtb found");
 
 	__dt_setup_arch(dtb);
-
 	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+
+	for (q = bmips_quirk_list; q->quirk_fn; q++) {
+		if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
+					     q->compatible)) {
+			q->quirk_fn();
+		}
+	}
 }
 
 void __init device_tree_init(void)
-- 
2.1.1
