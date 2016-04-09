Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Apr 2016 12:56:56 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34924 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006865AbcDIK4y06ddn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Apr 2016 12:56:54 +0200
Received: by mail-wm0-f67.google.com with SMTP id a140so9822971wma.2;
        Sat, 09 Apr 2016 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kREuCY968NvtnvILXxqBh85ZuX7yl57rFBj5Y47LTs4=;
        b=Gwz1VfEHv+9buIHyhgcX35+hu2qE2cqYYIJ2rjHTlfupuNK9Mr5rwc38HXJIImP/Gb
         NAezC1+0XZipQEDW/E8eNdIrb8qwYN4s3nQvS70+ZqtGOmO6LWcrrmSyod1AQVobfZop
         AELILtTZQX0cNB9BMaRdMmWlwyyMfUM4knqngpVnK4wqyDCLLa2dctoHhVZhImLbvFcJ
         syZxErf/zRlnJKJvkPbzGhYT/Rp95HFpqg5lWPWxmTjeEify1ImsRmNFeovQEAfwgJ3h
         E0LSNQyjHArdasPmtPDcsxSCFzBSEHuGQVagO3tr1kS0vhboLKKpqKxoJeuh7C0tMW6u
         Sl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kREuCY968NvtnvILXxqBh85ZuX7yl57rFBj5Y47LTs4=;
        b=UaJ4+SCXPBfLZiMyMpdTuSDcgj+/ABJAgEUiyMHwagFJOeTo2yz2e/6QQX3B8ihZSZ
         Tct4Ol4t2YSrI7aMg27ZKgRorxJzkgBdZ6jZKhco7k3xbi5FjbAiXuYzku5sptXqfWBo
         uVDodb4NfiuStQjoNlaBM3SqzEBriuDE1TkciIeifqLgRHa87goxJK1JkU4mh33+jHk/
         nbN8dkmqxkcGvTLM5X39V2XdIyLmZ0KQ0mXp36mTtQpj26mAJnGOtrx0tuy6gTDcJm1A
         eL4m27y1Ib4t15ZPLXPrPsYKTtL4yCC6UKkE0qgbZ4VL/9A/E/eO6tAXBwTmi+HT0ZAj
         eGaw==
X-Gm-Message-State: AD7BkJL8IDTUYjK0bupyiDM6xuhQk+CskIAJ2q1KbNcmG/EQ15qBCxqCgAY68TlDfI3qPA==
X-Received: by 10.194.81.103 with SMTP id z7mr13994075wjx.25.1460199409137;
        Sat, 09 Apr 2016 03:56:49 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id da5sm17677480wjb.25.2016.04.09.03.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 03:56:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] bmips: add BCM6358 support
Date:   Sat,  9 Apr 2016 12:56:47 +0200
Message-Id: <1460199408-18738-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459757353-14683-1-git-send-email-noltari@gmail.com>
References: <1459757353-14683-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52939
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
 v5: no changes, resend
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
