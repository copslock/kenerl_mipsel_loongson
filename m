Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2012 14:18:58 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42272 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823127Ab2J1NSWWwMrS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2012 14:18:22 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so1441548bkw.36
        for <multiple recipients>; Sun, 28 Oct 2012 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Idat+4NbW4b2XYXmfPF3/YDOMnf1yfoXPOcLKc4ekTU=;
        b=eUq0UbFWqj8kNUtkeIp6dNt7Du713vjuVxILDnpMKWjPOZP/syysm2pBLHNRfeGi+R
         b7uL4QAuexU7KANiefcBb7XRyB+F2WBn57mZEN8Y4VFwKiEjU+2UCmcUdzvyCHSlZCrr
         pwxxnYjq0JmrOezkr0KUGe5o6aeG3kUk1PWKN3HD8JD9Nfu+H0GO6/hzSVsR2g3ipa8p
         F0yJmefZv49nyv/Sp4cT2F6GOXNbWegbTHaPUtxywFQArXCyB/YWhaJSk+g1nitBmhg/
         XfSNyPyhsP79+Nc9d51PQm2Oo+Z9TViI6E/Tlez9gZkDdQaVpXipiJvtXqIcr2+8HrMh
         spRg==
Received: by 10.204.11.194 with SMTP id u2mr8370871bku.41.1351430297035;
        Sun, 28 Oct 2012 06:18:17 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id j24sm2575695bkv.0.2012.10.28.06.18.15
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Oct 2012 06:18:16 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/3] MIPS: BCM63XX: add softreset register description for BCM6358
Date:   Sun, 28 Oct 2012 14:17:53 +0100
Message-Id: <1351430275-14509-2-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com>
References: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The softreset register description for BCM6358 was missing, so add it.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 12963d0..e84e602 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -191,6 +191,7 @@
 /* Soft Reset register */
 #define PERF_SOFTRESET_REG		0x28
 #define PERF_SOFTRESET_6328_REG		0x10
+#define PERF_SOFTRESET_6358_REG		0x34
 #define PERF_SOFTRESET_6368_REG		0x10
 
 #define SOFTRESET_6328_SPI_MASK		(1 << 0)
@@ -244,6 +245,15 @@
 				  SOFTRESET_6348_ACLC_MASK |		\
 				  SOFTRESET_6348_ADSLMIPSPLL_MASK)
 
+#define SOFTRESET_6358_SPI_MASK		(1 << 0)
+#define SOFTRESET_6358_ENET_MASK	(1 << 2)
+#define SOFTRESET_6358_MPI_MASK		(1 << 3)
+#define SOFTRESET_6358_EPHY_MASK	(1 << 6)
+#define SOFTRESET_6358_SAR_MASK		(1 << 7)
+#define SOFTRESET_6358_USBH_MASK	(1 << 12)
+#define SOFTRESET_6358_PCM_MASK		(1 << 13)
+#define SOFTRESET_6358_ADSL_MASK	(1 << 14)
+
 #define SOFTRESET_6368_SPI_MASK		(1 << 0)
 #define SOFTRESET_6368_MPI_MASK		(1 << 3)
 #define SOFTRESET_6368_EPHY_MASK	(1 << 6)
-- 
1.7.2.5
