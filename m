Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2014 08:51:58 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51148 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854766AbaEAG3ImvXKr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2014 08:29:08 +0200
Received: by mail-pd0-f177.google.com with SMTP id v10so2709036pde.22
        for <multiple recipients>; Wed, 30 Apr 2014 23:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oDcJV2CR7Ye+fY3K84T4lMzWmlV50wC8Z6imt4g5mgY=;
        b=WgpRgK7YwLFi+UbrXRwVZo48mKcsuFYGCMIqMyo2LqrHn3Ge/1tkeMOFYwkZlUynFd
         T0RvtXfxpRJIkrr8p5P9rR6hUp+DWVXGL+agR0Tn4FU2ERbdcwXMDYD0fuaUYf1EwMSn
         s4lhIQI7mXTLQzLkbD3JS5aLrcOyH2xet0m9MAiyBwXFBTicHjtWm7rYCjuAQ79Afc/x
         1XFxvG6bQXE0N0DV2Mcgz+UcYyuZvjH5dGgN/BpM1QH4D8AHxxt3OpsgwviAdmcQiEI5
         DnyetfWm3anjNnM6bvl9l4Nqnu5IOKa7Y30GlTZiENNzj+jCvWU9KPBUDEuv5WOu/h0t
         rklQ==
X-Received: by 10.67.1.202 with SMTP id bi10mr17623532pad.68.1398925669583;
        Wed, 30 Apr 2014 23:27:49 -0700 (PDT)
Received: from norris-Latitude-E6410.globalsuite.net ([12.104.145.50])
        by mx.google.com with ESMTPSA id yq4sm149337568pab.34.2014.04.30.23.27.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 23:27:49 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Huang Shijie <b32955@freescale.com>,
        Marek Vasut <marex@denx.de>, <linux-mtd@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 10/12] mips: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
Date:   Wed, 30 Apr 2014 23:26:45 -0700
Message-Id: <1398925607-7482-11-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

These defconfigs contain the CONFIG_M25P80 symbol, which is now
dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
the new dependency.

At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/configs/ath79_defconfig  | 3 +--
 arch/mips/configs/db1xxx_defconfig | 1 +
 arch/mips/configs/rt305x_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index e3a3836508ec..134879c1310a 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -46,7 +46,6 @@ CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-2
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
@@ -54,7 +53,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_M25P80=y
-# CONFIG_M25PXX_USE_FAST_READ is not set
+CONFIG_MTD_SPI_NOR=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_PACKET_ENGINE is not set
 CONFIG_ATH_COMMON=m
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index c99b6eeda90b..a64b30b96a0d 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -113,6 +113,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_AU1550=y
 CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_SCSI_TGT=y
diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index d1741bcf8949..d14ae2fa7d13 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -81,7 +81,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
@@ -89,6 +88,7 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_EEPROM_93CX6=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
1.8.3.2
