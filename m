Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 16:30:32 +0100 (CET)
Received: from mail-ot0-x242.google.com ([IPv6:2607:f8b0:4003:c0f::242]:35392
        "EHLO mail-ot0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993867AbdBMPaZn2vT4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2017 16:30:25 +0100
Received: by mail-ot0-x242.google.com with SMTP id 65so11926785otq.2;
        Mon, 13 Feb 2017 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Od+vyQVOk2BpPrBoa4zmpitDX/8ZtLPYtRWeINrkiU8=;
        b=l0iEjyym/QkraHK2naSbIWqq8UKnK0fxWLSYyGVq+1c5RmIoLgullGT83d291WHF3v
         8grt7wzdBkPxeFraTZ1TmPufufkZFG8WW3e1OADOpsS35DErDIkCXTCPHal9Vv97pd00
         UkVoFrJxNKofYnAcq0gRU1vSZzIUdqh0mGZPzNPMyHewKxgbCR6skm2Fv46jp5D6P8h0
         y1hpdxehk/6ZrHHK76a0JBfK48Lo1oSCaxMM4H86jSTSa/+J2YF3WzT7/14jGp+/Z6mo
         5z8SDqQE8kH35nfnK8zimvqU+xA+goLKTT4zKsJ3man6uDdBjVW7pn+Y8NcF5alrMXI7
         K4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Od+vyQVOk2BpPrBoa4zmpitDX/8ZtLPYtRWeINrkiU8=;
        b=DyP7tmpdbjb0sSI4zL3N+8NuOpttBPCntLTZaclpoduXV/oYydlFnp/oMW7fM5zUwy
         7ZGJYrAg59CTd72sDJIcYIl2OHGxZr+zdIODpTvBDIlZIUzKbfGHKYRP6cmbEooFHAY8
         td2RdD6DUxmstovsggq1egt39bVJqjZ8blQlpTo+wXRjx+60aLGgwDu3mPjG8GGKvllN
         BhsPdRTVkE78gqX1xm4ppzNOl+VW/2lHN5ZGORJwLhJTvjmlYS/9bHoIasx3PucqJth2
         mWSmwrg1bJ5+6E2h4FhZMde+zMHVNth+HClnpQ+uoRzRLaBEVBca+Rhal0OMThn1fgCO
         Exrg==
X-Gm-Message-State: AMke39mVJr/TVUzJ6KfL2BsKcmrXtfbckFG0CG9aRUzDnjLY1WEKPUx5dTwnBuLP9xm60A==
X-Received: by 10.98.61.207 with SMTP id x76mr26282079pfj.152.1486999819787;
        Mon, 13 Feb 2017 07:30:19 -0800 (PST)
Received: from ubuntu ([180.102.126.129])
        by smtp.gmail.com with ESMTPSA id k78sm21685945pfb.93.2017.02.13.07.30.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 07:30:18 -0800 (PST)
Date:   Mon, 13 Feb 2017 23:30:13 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Yang Ling <gnaygnil@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: loongson1: Add PWM support for Loongson1 board
Message-ID: <20170213153013.GA32049@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

The patch adds PWM support for Loongson1 board.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/configs/loongson1b_defconfig           |  2 ++
 arch/mips/configs/loongson1c_defconfig           |  2 ++
 arch/mips/include/asm/mach-loongson32/platform.h |  1 +
 arch/mips/include/asm/mach-loongson32/regs-pwm.h |  8 ++++----
 arch/mips/loongson32/common/platform.c           | 16 ++++++++++++++++
 arch/mips/loongson32/ls1b/board.c                |  1 +
 arch/mips/loongson32/ls1c/board.c                |  1 +
 7 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index 914c867..0e6f7f6 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -97,6 +97,8 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_LOONGSON1=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_LOONGSON1=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/loongson1c_defconfig
index 68e42ef..1f241af 100644
--- a/arch/mips/configs/loongson1c_defconfig
+++ b/arch/mips/configs/loongson1c_defconfig
@@ -98,6 +98,8 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_LOONGSON1=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_LOONGSON1=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 8f8fa43..f532d93 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -24,6 +24,7 @@
 extern struct platform_device ls1x_gpio0_pdev;
 extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_nand_pdev;
+extern struct platform_device ls1x_pwm_pdev;
 extern struct platform_device ls1x_rtc_pdev;
 extern struct platform_device ls1x_wdt_pdev;
 
diff --git a/arch/mips/include/asm/mach-loongson32/regs-pwm.h b/arch/mips/include/asm/mach-loongson32/regs-pwm.h
index 4119600..210cec8 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-pwm.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-pwm.h
@@ -13,10 +13,10 @@
 #define __ASM_MACH_LOONGSON32_REGS_PWM_H
 
 /* Loongson 1 PWM Timer Register Definitions */
-#define PWM_CNT			0x0
-#define PWM_HRC			0x4
-#define PWM_LRC			0x8
-#define PWM_CTRL		0xc
+#define PWM_CNT(n)		((n << 4) + 0x0)
+#define PWM_HRC(n)		((n << 4) + 0x4)
+#define PWM_LRC(n)		((n << 4) + 0x8)
+#define PWM_CTRL(n)		((n << 4) + 0xc)
 
 /* PWM Control Register Bits */
 #define CNT_RST			BIT(7)
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index a3dabe9..011ae6c 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -372,3 +372,19 @@ struct platform_device ls1x_wdt_pdev = {
 	.num_resources	= ARRAY_SIZE(ls1x_wdt_resources),
 	.resource	= ls1x_wdt_resources,
 };
+
+/* PWM */
+static struct resource ls1x_pwm_resources[] = {
+	{
+		.start	= LS1X_PWM0_BASE,
+		.end	= LS1X_PWM0_BASE + SZ_64 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_pwm_pdev = {
+	.name		= "ls1x-pwm",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_pwm_resources),
+	.resource	= ls1x_pwm_resources,
+};
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 01aceaa..8bf0754 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -71,6 +71,7 @@ struct plat_ls1x_nand ls1x_nand_pdata = {
 	&ls1x_gpio0_pdev,
 	&ls1x_gpio1_pdev,
 	&ls1x_nand_pdev,
+	&ls1x_pwm_pdev,
 	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
 };
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index eb2d913..2d6e3bb 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -12,6 +12,7 @@
 static struct platform_device *ls1c_platform_devices[] __initdata = {
 	&ls1x_uart_pdev,
 	&ls1x_eth0_pdev,
+	&ls1x_pwm_pdev,
 	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
 };
-- 
1.9.1
