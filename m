Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2010 15:25:57 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:58879 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491195Ab0EPNZd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 May 2010 15:25:33 +0200
Received: by mail-wy0-f177.google.com with SMTP id 28so200085wyf.36
        for <multiple recipients>; Sun, 16 May 2010 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=2mNYuLU5SHyxIc3YhSmJoTGbZXmCqDW9VzBH9Ljj4ks=;
        b=iDjJwqmpTJKZMLcqpI0OpMACxl2t6+adiOrid+FbWZ+UZQAtLjGDzQA2vVEAzLUcUf
         65fJRoFpCbLlTv5xX7mQfR3Sr+YiXtMY5CULz9Wp/YIFQwwzEzlN9KzoMsi50TT1PDVF
         a4lm5tx55TQgVr8r2F6w7U8Q3cGqN6Qcq/dmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=KVaDQTTAYu2fHfx9z7te+o4kiSKhxi6hgLlhWjFRbOm0ShVrK5bAbRGq1vtrA0mT4q
         CyD9U32Kz5MUp+JFCbnlQFoTdrLjgPazeoqAo5mr52hAlMQGIbWUIGLqxdbpAD0av3D/
         s4qdaHr1LEtPMEHbiqAWECv/dJNkGQDsFNDQc=
Received: by 10.227.143.211 with SMTP id w19mr3519198wbu.182.1274016333303;
        Sun, 16 May 2010 06:25:33 -0700 (PDT)
Received: from lenovo.localnet (208.59.76-86.rev.gaoland.net [86.76.59.208])
        by mx.google.com with ESMTPS id p29sm19431359wbe.16.2010.05.16.06.25.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 06:25:32 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/2] AR7: fix typo in ar7.h
Date:   Sun, 16 May 2010 15:25:30 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.33-2-686; KDE/4.3.4; i686; ; )
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201005161525.30464.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This fixes a typo on the AR7_RESET_PERIPHERAL define.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-ar7/ar7.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
index f1cf389..483ffea 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -50,7 +50,7 @@
 #define UR8_REGS_WDT	(AR7_REGS_BASE + 0x0b00)
 #define UR8_REGS_UART1	(AR7_REGS_BASE + 0x0f00)
 
-#define AR7_RESET_PEREPHERIAL	0x0
+#define AR7_RESET_PERIPHERAL	0x0
 #define AR7_RESET_SOFTWARE	0x4
 #define AR7_RESET_STATUS	0x8
 
@@ -128,7 +128,7 @@ static inline int ar7_has_high_cpmac(void)
 static inline void ar7_device_enable(u32 bit)
 {
 	void *reset_reg =
-		(void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PEREPHERIAL);
+		(void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PERIPHERAL);
 	writel(readl(reset_reg) | (1 << bit), reset_reg);
 	msleep(20);
 }
@@ -136,7 +136,7 @@ static inline void ar7_device_enable(u32 bit)
 static inline void ar7_device_disable(u32 bit)
 {
 	void *reset_reg =
-		(void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PEREPHERIAL);
+		(void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PERIPHERAL);
 	writel(readl(reset_reg) & ~(1 << bit), reset_reg);
 	msleep(20);
 }
-- 
1.7.1
