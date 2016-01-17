Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jan 2016 12:27:59 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36062 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008349AbcAQL161DIe2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jan 2016 12:27:58 +0100
Received: by mail-wm0-f67.google.com with SMTP id l65so11178618wmf.3;
        Sun, 17 Jan 2016 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=mC81frfSicRqEEYZbr3FFI5RyqKki+FMHTZtwlXntrQ=;
        b=Spmom4qYq6xhVxEdM/vanbVa3979z1eAMV5SOrOw/ZCApwUXFDBrs47u0Y21fqMHZb
         ULPpj6g3ZZkvlQVxwmLQTHNDObIhxwN7OXos8w36hY4FV6asosHjPzS709r4zWOAQ0D5
         3u5n1Q8XG8levuOfosg4CWWzb9CDVLyUJ2HeG+9X2GmNmDCxMXMgtclpWS07Y4pkvd6J
         1/JsvAZYUpK9wv7jK7ZYSSTNaFP33GMGSZzeN2PFBj+/ek2wHsDUdRuQdJMymWkaPDrS
         KzK++fuW29k5bfAMRut6/5TUo8JecTrwjEMG1l7y/nQrFPd1NZnUtzdpjPbVDxOPdpZ5
         xyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=mC81frfSicRqEEYZbr3FFI5RyqKki+FMHTZtwlXntrQ=;
        b=BXZKIbQxcmXSYOcZNzYoqcX/vRvzSXMHIQNbjY9JIB+PC5bzaKEljwa8CvOEnny3eq
         aftGV+OJnCOEUqpuQlCtpZgJG1mxLnR9IWQhwMfPpH6Qt1oTyKy512hWnptCdkbdX2xT
         R0anlgQ2xoMbCkRMLzWA5pbIEnMvC1034DcFsMRiLCJrCeKGFWUxSyBfLriww4aTIC2r
         ZNIIRNFsxlSbWkEfDQqkKviiuiLj/bwQxn8om6Fe3rO2WPEBOuYRGfoi3OK5ur+I7PLE
         6mHdFTETUmFzjUssWvLNko1bnnE64abnOgB7HcppFaUfX5yZ8Z91OCq7WKdEMw9B4n8B
         Id0A==
X-Gm-Message-State: ALoCoQmAFKlz1Hx69dU9RdtgwsfJCprCyRD45XHjFix+M7t3aSDtRlIS405Fygz1iFGSwFc7IqeTx+OXvdBtY+2zGzkAzxCW8A==
X-Received: by 10.194.123.8 with SMTP id lw8mr18763658wjb.72.1453030073201;
        Sun, 17 Jan 2016 03:27:53 -0800 (PST)
Received: from skynet.lan (140.Red-83-35-232.dynamicIP.rima-tde.net. [83.35.232.140])
        by smtp.gmail.com with ESMTPSA id fx8sm10617166wjb.13.2016.01.17.03.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 03:27:51 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] bmips: add BCM6358 support
Date:   Sun, 17 Jan 2016 12:28:20 +0100
Message-Id: <1453030101-14794-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51176
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
BCM6358 uses >= 0xfff00000 addresses for internal registers, which need to be
remapped (by using a simplified version of BRCM63xx ioremap.h).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
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
index 0000000..b1a75f8
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
+	if (offset >= 0xfff00000)
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
1.9.1
