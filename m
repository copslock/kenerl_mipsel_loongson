Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Feb 2016 12:41:35 +0100 (CET)
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35691 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007424AbcBULldnD4I5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Feb 2016 12:41:33 +0100
Received: by mail-wm0-f42.google.com with SMTP id c200so133894947wme.0;
        Sun, 21 Feb 2016 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=dxZLh7EEBEGcGk1e/CwSCiXh5TdcVG/YwW0LRzasG9M=;
        b=PRKfiqZnsVsTirM4BPoE6Al32OPtHrjIuh04Lm3jfV0Fvhxyr1bqTVcVWJbCPtz4D9
         FgMrm0+rNjURrzXa82PJH1IvH5uR89zWm7aNiw3Ig4Y9oYuw1ktrTZNSTZ2IrBxyJHE2
         +ACRTXHfcrZh84Tf3ql8QyDyVZektd4S7yF6klbL0AG611NnZ2e53n/IzQP5Leo54iKc
         jtSUVbJdPob/KfbvGa+EjMxDjiDHumeIrgzSN0Syd0G4DqeZXEuK8W1mA69URYp9Wxf7
         x+HQq3BbXXjSmtFl5faF2zaEUp3+kaE5WobjumZJqYcQ46T2NWT1gZFV6izT2E7OI0RU
         zSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=dxZLh7EEBEGcGk1e/CwSCiXh5TdcVG/YwW0LRzasG9M=;
        b=Xk3CthwCnd6Lf+9XbHGZzeKpA3LVBGoEVOQNSB56GnuRsa0LMNLvZi59M6ambkaBG+
         J7KpHKMsotlcCmjQvL0Z1ngLw0iBIhOeXPM+lXTayqOgZdQ3cl9BvyHDJIa4XLlYaSr8
         mf9ZZ+3ZWd0Ek5MZw55hPbnkv5+d47gJlNiMvQLCEK7LbS4Xk38nA4S1OmXbGy6+KqVs
         ysFPcJK2n0hoyLSvV8kWUdgCb6wnXuQYlTGKwV5kDDAh0xF4JyWD8x+It6KA4imbzdM2
         t7OO9KTG4zUEgCjvsDZa7cdJGtaebGVZVu8M3lh1NGkS1jzXKvUvsBwGVWASXFU34I6i
         bNKg==
X-Gm-Message-State: AG10YOTUN1HzU/EM34faiDJUe5N+ZSpa7ohmbtMaZtb5a+NjrVTnU52VAWpEgunTgQAp0Q==
X-Received: by 10.194.78.175 with SMTP id c15mr22804556wjx.16.1456054888542;
        Sun, 21 Feb 2016 03:41:28 -0800 (PST)
Received: from skynet.lan (140.Red-83-35-232.dynamicIP.rima-tde.net. [83.35.232.140])
        by smtp.gmail.com with ESMTPSA id e9sm19644726wja.25.2016.02.21.03.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Feb 2016 03:41:27 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 1/2] bmips: add BCM6358 support
Date:   Sun, 21 Feb 2016 12:41:20 +0100
Message-Id: <1456054881-26787-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

BCM6358 has a shared TLB which conflicts with current SMP support, so it must
be disabled for now.
BCM6358 uses >= 0xfffe0000 addresses for internal registers, which need to be
remapped (by using a simplified version of BRCM63xx ioremap.h).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: Use a different approach for remapping internal registers

 arch/mips/bmips/setup.c                    | 29 +++++++++++++++++------
 arch/mips/include/asm/mach-bmips/ioremap.h | 37 ++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bmips/ioremap.h

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3553528..f834a86 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -18,6 +18,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 #include <asm/addrspace.h>
 #include <asm/bmips.h>
 #include <asm/bootinfo.h>
@@ -35,9 +36,12 @@
 
 static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
 
+phys_addr_t bmips_internal_registers;
+
 struct bmips_quirk {
-	const char		*compatible;
-	void			(*quirk_fn)(void);
+	const char *compatible;
+	void (*quirk_fn)(void);
+	const phys_addr_t regs;
 };
 
 static void kbase_setup(void)
@@ -95,17 +99,27 @@ static void bcm6328_quirks(void)
 		bcm63xx_fixup_cpu1();
 }
 
+static void bcm6358_quirks(void)
+{
+	/*
+	 * BCM6358 needs special handling for its shared TLB, so
+	 * disable SMP for now
+	 */
+	bmips_smp_enabled = 0;
+}
+
 static void bcm6368_quirks(void)
 {
 	bcm63xx_fixup_cpu1();
 }
 
 static const struct bmips_quirk bmips_quirk_list[] = {
-	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
-	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
-	{ "brcm,bcm6328",		&bcm6328_quirks			},
-	{ "brcm,bcm6368",		&bcm6368_quirks			},
-	{ "brcm,bcm63168",		&bcm6368_quirks			},
+	{ "brcm,bcm3384-viper", &bcm3384_viper_quirks, 0 },
+	{ "brcm,bcm33843-viper", &bcm3384_viper_quirks, 0 },
+	{ "brcm,bcm6328", &bcm6328_quirks, 0 },
+	{ "brcm,bcm6358", &bcm6358_quirks, 0xfffe0000 },
+	{ "brcm,bcm6368", &bcm6368_quirks, 0 },
+	{ "brcm,bcm63168", &bcm6368_quirks, 0 },
 	{ },
 };
 
@@ -162,6 +176,7 @@ void __init plat_mem_setup(void)
 	for (q = bmips_quirk_list; q->quirk_fn; q++) {
 		if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
 					     q->compatible)) {
+			bmips_internal_registers = q->regs;
 			q->quirk_fn();
 		}
 	}
diff --git a/arch/mips/include/asm/mach-bmips/ioremap.h b/arch/mips/include/asm/mach-bmips/ioremap.h
new file mode 100644
index 0000000..5ffca94
--- /dev/null
+++ b/arch/mips/include/asm/mach-bmips/ioremap.h
@@ -0,0 +1,37 @@
+#ifndef __ASM_MACH_BMIPS_IOREMAP_H
+#define __ASM_MACH_BMIPS_IOREMAP_H
+
+#include <linux/types.h>
+
+extern phys_addr_t bmips_internal_registers;
+
+static inline phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr,
+					     phys_addr_t size)
+{
+	return phys_addr;
+}
+
+static inline int is_bmips_internal_registers(phys_addr_t offset)
+{
+	if (bmips_internal_registers != 0 && offset >= bmips_internal_registers)
+		return 1;
+	else
+		return 0;
+}
+
+static inline void __iomem *plat_ioremap(phys_addr_t offset,
+					 unsigned long size,
+					 unsigned long flags)
+{
+	if (is_bmips_internal_registers(offset))
+		return (void __iomem *) offset;
+
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return is_bmips_internal_registers((unsigned long) addr);
+}
+
+#endif /* __ASM_MACH_BMIPS_IOREMAP_H */
-- 
1.9.1
