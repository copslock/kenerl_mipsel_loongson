Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:09:22 +0200 (CEST)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35822 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024739AbcDDIJUwZKL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 10:09:20 +0200
Received: by mail-lb0-f196.google.com with SMTP id gk8so18369103lbc.2;
        Mon, 04 Apr 2016 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAkJxl4xHg51Algcmspxfe40faLq9EZWtDcv+wfaogE=;
        b=dhtt+4qrn/7siKW8gvWlnOstyfGZRiksQfEDGZyEBvThVdne3A3K/KSnJKp3k296Sz
         Fut0Jj/l1CEagO3ydwB3z95tell6KQC7ddsRWNNPje5CX+gaxF4pphCLH9zl2qsJ1qVc
         NVH9QQ9vkLC2m7v7fhjP53af7IEeDFUAzRDkrHnP7oENtxnAx+m6Dj6OCETnnWnU+Dpo
         TCH4qszhBlWkt2w31Vn4fc+kwWMl6Qz6UiQvwnkfxoJBQCbVtfY2MglvBp5BInfGEavD
         F2hcYrO8Sl+E8Tq4//stKe3pkEUgImpC4nf5nPca9lQNu3Iyf7WlrYKOhUgh02+dHWu1
         /62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAkJxl4xHg51Algcmspxfe40faLq9EZWtDcv+wfaogE=;
        b=c4oNEKfZ13JwaBc3b/aQhF/ywRh8VLkVrjsVtksUDrcqom0Mub3+tGg2ZNHJvjrmNj
         FVTuck1EOrCAbGvGf+Tc02oTA+RzivBpF8pANUM5pLCdVQUaFjB2pejU1X5+EJqgM+S5
         uvj3FB+mcIcqGH57SSTOBCVKoQrlHEItgNVdi5lLQm7/Kt7C/EcTvJYTKVKVQhN+biNc
         087qhJ7qw/SpXEEz8rKliLZR2PUYmtrnZHyzwcFt5c/+08js59dDOaNPvZIOsdNVB/UV
         cBDzdBD10sMIPol4dEKmNzLzgB68rGrTvZ0pA6GggLcSmcbUkEFSlCqB/Qg/BsP8IGSF
         ZrhA==
X-Gm-Message-State: AD7BkJI67ymacY4TUF6GyClSvlLrwJU2oxaV+8XU5/QBUGJ8stec3Gnxtgw6/wWExb2ORw==
X-Received: by 10.28.12.80 with SMTP id 77mr10982561wmm.19.1459757355409;
        Mon, 04 Apr 2016 01:09:15 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id k125sm12462455wmb.14.2016.04.04.01.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 01:09:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, jogo@openwrt.org,
        cernekee@gmail.com, robh@kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 1/2] bmips: add BCM6358 support
Date:   Mon,  4 Apr 2016 10:09:12 +0200
Message-Id: <1459757353-14683-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459677376-10449-1-git-send-email-noltari@gmail.com>
References: <1459677376-10449-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52862
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
However, 0xfff80000 is a better address, since it also covers BCM3368, leaving
the possibility to add it in the future.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v4: no changes, resend
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
