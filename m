Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 07:33:38 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:35144
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZGdc3vbHI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 07:33:32 +0100
Received: by mail-pf0-x242.google.com with SMTP id j124so18445947pfc.2;
        Mon, 25 Dec 2017 22:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P39i4IZrOIWsCeSTY6owOcZRuwJ5VV1s4kcL9xZstOU=;
        b=l/bFr4i4xF7PCcWw01cy598nYV2jecbPWukbazJVmAlNPVQIlE7x0fyZeu6bsHB4PW
         DDp7XX1SiZ/bIv6ix8EppLFSpNANG63IM0HUT4kP2Xf9BU3Yct09G2ku6/3ZsAVStj0t
         21BMVL4N4N9cXLEB/xIgDd8Wt/JFPL1yQO7xrU5bvS6PkhlklreX1gMz7HaTP3eA5/gG
         7gnAJWgrs4vq/yVsurfHV+PPkeKzAHtiPjjbecyT/IJGxCTsz7aBE/ZwW8JflIgf3up8
         IIQ8SPT6NFE1BDSlp8a0WGA1LwHRgLeai6NaFspNGKS3EUQv2NXvbI1cdReZ1Tg79a3p
         mUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P39i4IZrOIWsCeSTY6owOcZRuwJ5VV1s4kcL9xZstOU=;
        b=exrShkbMLFpnTZE+tRHrUWmDbCTEDOaV+L8K08sAkR+pW0pXIwJmZenOsSZEsnnSfd
         wosLhKfbGgfheXMCWnQCsRPu9z6e9BcR15KGsP60nB3CsS649X/gFzrFjyaoxE3JJ/d8
         HzY+/H7m+Xya6vx6JGQt4pTh+tgtwrOiXNlkzTMJeMYwDPQDXWXTRTN3FYYXl10A+mN/
         WRyntk3LIz/XRdVr0pfXyDC6d4i1o2FwQzNVS99p8HQz6A982FBIScVCLNdJwaae5uCC
         nhULUT41BCj1kWYUqjSVSyNDEGkCamCEiJvkRlFY7ltyNLnAUzhKuCS4faopQlCJhW0j
         fzWA==
X-Gm-Message-State: AKGB3mLEat/fL6HzxWrpBhLwoqoYI4JUVB5BTkZ6VtxKlVitawWA6W1g
        Rv8Cl6bMnbKtMck7MfCyREQ=
X-Google-Smtp-Source: ACJfBoufRoy+c2zUZwhRmbgub3r64rBX1eySBgtHCFizVJkgedyTy8UqgJD5sMcg+MCmvXmpF+B2oA==
X-Received: by 10.99.102.1 with SMTP id a1mr4861091pgc.357.1514270005735;
        Mon, 25 Dec 2017 22:33:25 -0800 (PST)
Received: from localhost.localdomain ([103.16.68.147])
        by smtp.gmail.com with ESMTPSA id h69sm59911895pfk.166.2017.12.25.22.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Dec 2017 22:33:25 -0800 (PST)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk,
        kaloz@openwrt.org, khalasa@piap.pl, aaro.koskinen@iki.fi,
        tony@atomide.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com,
        gregory.clement@free-electrons.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, marek.vasut@gmail.com,
        slapin@ossfans.org, jic23@cam.ac.uk, kgene@kernel.org,
        krzk@kernel.org, ralf@linux-mips.org, ysato@users.sourceforge.jp,
        dalias@libc.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/11 v2] MIPS: Alchemy: constify gpio_led
Date:   Tue, 26 Dec 2017 12:03:08 +0530
Message-Id: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arvind.yadav.cs@gmail.com
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

gpio_led are not supposed to change at runtime.
struct gpio_led_platform_data working with const gpio_led
provided by <linux/leds.h>. So mark the non-const structs
as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
              The GPIO LED driver can be built as a module, it can
              be loaded after the init sections have gone away.
              So removed '__initconst'.

 arch/mips/alchemy/board-gpr.c  | 2 +-
 arch/mips/alchemy/board-mtx1.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index 328d697..4e79dbd 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -190,7 +190,7 @@ static struct platform_device gpr_mtd_device = {
 /*
  * LEDs
  */
-static struct gpio_led gpr_gpio_leds[] = {
+static const struct gpio_led gpr_gpio_leds[] = {
 	{	/* green */
 		.name			= "gpr:green",
 		.gpio			= 4,
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 85bb756..aab55aa 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -145,7 +145,7 @@ static struct platform_device mtx1_wdt = {
 	.resource = mtx1_wdt_res,
 };
 
-static struct gpio_led default_leds[] = {
+static const struct gpio_led default_leds[] = {
 	{
 		.name	= "mtx1:green",
 		.gpio = 211,
-- 
2.7.4
