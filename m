Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 11:56:26 +0200 (CEST)
Received: from mail-lb0-f193.google.com ([209.85.217.193]:34175 "EHLO
        mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006514AbcDCJ4X40fNd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 11:56:23 +0200
Received: by mail-lb0-f193.google.com with SMTP id vk4so16409038lbb.1;
        Sun, 03 Apr 2016 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PAfrgp/y7FdK2qitmU5FgDV+8fN5sZmrSE9KBPjt6w=;
        b=DCBtJiLs9OgMvkU6bjs0kgfb6kEeUMGFWhvNFFDkIT1Mo7/ycH8tOFll1MIVnFp7rI
         MvgXfVhKl2TbhSlVvyb0CRI345ebEH3Y16hgGk4w2ufHA7+4v1/5UeUGcnUN3OcSVNy0
         ALKqy1Sl1oMG2QowuCdSC+rjfgE06EvluNkEygBdgfasKpUi4AxxXVyekEZwDXs9KtPo
         2ygIVqzrtVoJrnj0E2lE6GX8ivo2kbwlOPjaT2VdRtgwzYVpbHCfdkzqwtfaF8TmpxGR
         NKBu5tbxxYUt5k+ksQjRuMz6RSBB2C8PXX/8Pp5vUn3moqNgHWUsQRDg9bI9LQRCWp3D
         YnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PAfrgp/y7FdK2qitmU5FgDV+8fN5sZmrSE9KBPjt6w=;
        b=XB+pxphxSBk5aq8jLjAdxhX14GNUIhI1MDAus72qdtohjENN+Xv2gmXMUlnouG8tFB
         UCt2auUGrFbHYqy+JfLOgLXw2pepaK/GABJWYzZBqwTCwp0R/uy8VR/52LoUY7GNZbYt
         1L57uu+bIFcfwhfc3bg2Uzkti2fHadyNnIC5cIkwnN3FeklchVJAVfcww0nThFi0OSXu
         P3GJcF1/Iou++LN0vX+LhpT91D+nBXGlfNCA0kNmCJr9liNdHqBLAYE4MConErlUopQm
         zak3MOQbIxh1nXfKtd/Nx6v/lpoG0YnnkBCjKpmc0tttBkdtUKU8QiJbJT6rfSnDR3kc
         oc1Q==
X-Gm-Message-State: AD7BkJICMOq7DLVTxqKHSp4R3kuiU3vAW/5A4T2t0m/K0FZPZHOqNI8HMPJf/vvMJb5Wfw==
X-Received: by 10.28.214.11 with SMTP id n11mr6573678wmg.31.1459677378415;
        Sun, 03 Apr 2016 02:56:18 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id w202sm6645124wmw.18.2016.04.03.02.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 02:56:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, jogo@openwrt.org,
        cernekee@gmail.com, robh@kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 1/2] bmips: add BCM6358 support
Date:   Sun,  3 Apr 2016 11:56:15 +0200
Message-Id: <1459677376-10449-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456054881-26787-1-git-send-email-noltari@gmail.com>
References: <1456054881-26787-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52839
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
However, 0xfff80000 is a better address since it also covers BCM3368, leaving
the possibility to add it in the future.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: Use a hardcoded constant for is_bmips_internal_registers (BCM3368 base
  address)
 v2: Use a different approach for remapping internal registers

 arch/mips/bmips/setup.c                    | 10 +++++++++
 arch/mips/include/asm/mach-bmips/ioremap.h | 33 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-bmips/ioremap.h

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3553528..38b5bd5 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -95,6 +95,15 @@ static void bcm6328_quirks(void)
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
@@ -104,6 +113,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
+	{ "brcm,bcm6358",		&bcm6358_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
 	{ "brcm,bcm63168",		&bcm6368_quirks			},
 	{ },
diff --git a/arch/mips/include/asm/mach-bmips/ioremap.h b/arch/mips/include/asm/mach-bmips/ioremap.h
new file mode 100644
index 0000000..29c7a7b
--- /dev/null
+++ b/arch/mips/include/asm/mach-bmips/ioremap.h
@@ -0,0 +1,33 @@
+#ifndef __ASM_MACH_BMIPS_IOREMAP_H
+#define __ASM_MACH_BMIPS_IOREMAP_H
+
+#include <linux/types.h>
+
+static inline phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr, phys_addr_t size)
+{
+	return phys_addr;
+}
+
+static inline int is_bmips_internal_registers(phys_addr_t offset)
+{
+	if (offset >= 0xfff80000)
+		return 1;
+
+	return 0;
+}
+
+static inline void __iomem *plat_ioremap(phys_addr_t offset, unsigned long size,
+					 unsigned long flags)
+{
+	if (is_bmips_internal_registers(offset))
+		return (void __iomem *)offset;
+
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return is_bmips_internal_registers((unsigned long)addr);
+}
+
+#endif /* __ASM_MACH_BMIPS_IOREMAP_H */
-- 
2.1.4
