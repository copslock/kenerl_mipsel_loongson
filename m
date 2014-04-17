Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 09:23:25 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38501 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834702AbaDQHXB24CIc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2014 09:23:01 +0200
Received: by mail-pd0-f180.google.com with SMTP id v10so69280pde.11
        for <multiple recipients>; Thu, 17 Apr 2014 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MkfiHWpMwY0wrVxwyOJJHJ39meIk2AZ/5hHAoQe4N6o=;
        b=Ik1oTxSwEfxY5Nwlw1gwzxnPd7c8h2TlEAg0KySj4YARwebgM7TzGjFJND9PPgmI4F
         o5P/vkn6Ur5FwFgFXB/PQ1igaFkreIjKGsoqX5Hl/o5FXltjTYvCCj/N81yI2M0Y/JUC
         ykeM5VLGhlwfGasRZ3tzSrrvvbqro6S2nKlZqy5zcOCV+SlUYMiJiCk45MdckH1we8XW
         Lcu+BGDeW+r6ymYOoeK4RfXE4ic7U4nrdR89BKMCIxvnooCW/5AZvAoAurUS9OJDueVa
         tiH4J/2APxa6LUa5l8IubRM6iTbNHYqDuBvhfa6/nTDZx850Wylvy1Wbnwd8RSvU4/62
         WdoQ==
X-Received: by 10.68.189.68 with SMTP id gg4mr13778203pbc.42.1397719374894;
        Thu, 17 Apr 2014 00:22:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-154-223-43.socal.res.rr.com. [98.154.223.43])
        by mx.google.com with ESMTPSA id yx3sm51572778pbb.6.2014.04.17.00.22.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Apr 2014 00:22:54 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marex@denx.de>, <linux-mtd@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3/5] mips: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
Date:   Thu, 17 Apr 2014 00:21:47 -0700
Message-Id: <1397719309-2022-4-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39848
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
dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
relevant defconfigs.

At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
This change is based on l2-mtd.git/spinor, which is based on 3.15-rc1:

  git://git.infradead.org/l2-mtd.git +spinor

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
