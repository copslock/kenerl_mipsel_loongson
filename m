Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2015 17:35:06 +0100 (CET)
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:58560 "EHLO
        exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012226AbbAXQeTl2y3q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jan 2015 17:34:19 +0100
Received: from mail-wi0-f181.google.com ([209.85.212.181]) (using TLSv1) by exprod5ob113.postini.com ([64.18.4.12]) with SMTP
        ID DSNKVMPJiZOxfdAte2zHzQIfx4UNbs0t5S2X@postini.com; Sat, 24 Jan 2015 08:34:18 PST
Received: by mail-wi0-f181.google.com with SMTP id fb4so2648462wid.2
        for <linux-mips@linux-mips.org>; Sat, 24 Jan 2015 08:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=26Nndy/iAGl/PB62k/xuEpw/g2dZ2GBsiPA/O+awCUA=;
        b=IPQDROC1agyNh/PL84/UGc8Xp432472qAbEi3UIknPgiCutYVbCZdiWwpEESFUgigw
         JrV/0l55l/UbRF4qWTMYmtVFkN74255IuNpKN5E0sHeCV8zK+jakB1XhiZOnHrRa3CDs
         sFtj5dOFnfwzRUQF0cYyrem0b5lqlCC4z9zPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=26Nndy/iAGl/PB62k/xuEpw/g2dZ2GBsiPA/O+awCUA=;
        b=eIxJ2YFUgYLJUXfjI6nCBdK9dctWGnZJX6E/AjAIIDU0bb/zjUaOzkW7E0Vsrn5G/0
         9AoYDxShH0DGiDoU7b+35PTWW6HI1zEQOzjfE2Rupsuaza9d6MykCX12U6oEMAtc/gcp
         9iULGQtMydWQeZROv/CYgmXILa2r2Qk+GzGzf7pa4YXZ56qUTiz2sZqHk17tPVgk6+Z3
         mBrivxcJyy1x9FaKc2d+qZNxzPRbtTo+v5jM21PCoO2gAJYF0LjIsMBjFx8k7DJmbcvG
         paJ7/HXE/uatdm3pA6kMPWtDToGarcYqGNP7UgCrEZJbMEUdusJexZhtslB5OsTlR6SG
         enlQ==
X-Gm-Message-State: ALoCoQkdxE+CDGickBoLNZMJ2WWiTw9l85PvTEq3s/HwAJX19EHnUJKMF/hzqEM2ruOt/16/bCNNBo+v9W1vpBQ08JAfs+Dga3RwUquXrL1SDo4NOj+hsKLdUVMX2hS74qu8XPjrZsZGUo2I+zh+laCz/Ae8v6rIHQ==
X-Received: by 10.180.37.77 with SMTP id w13mr8022969wij.66.1422117256427;
        Sat, 24 Jan 2015 08:34:16 -0800 (PST)
X-Received: by 10.180.37.77 with SMTP id w13mr8022953wij.66.1422117256349;
        Sat, 24 Jan 2015 08:34:16 -0800 (PST)
Received: from localhost ([195.238.92.132])
        by mx.google.com with ESMTPSA id ep9sm6466648wid.3.2015.01.24.08.34.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 24 Jan 2015 08:34:15 -0800 (PST)
From:   Semen Protsenko <semen.protsenko@globallogic.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Russell King <linux@arm.linux.org.uk>
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        linux-am33-list@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: [PATCH 4/4] defconfigs: remove CONFIG_MTD_DEBUG*
Date:   Sat, 24 Jan 2015 18:33:33 +0200
Message-Id: <1422117213-3130-5-git-send-email-semen.protsenko@globallogic.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
Return-Path: <semen.protsenko@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: semen.protsenko@globallogic.com
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

CONFIG_MTD_DEBUG and CONFIG_MTD_DEBUG_VERBOSE were removed from
drivers/mtd/Kconfig by commit:
87ed114bb22b "mtd: remove CONFIG_MTD_DEBUG"

This patch finishes job by getting rid of CONFIG_MTD_DEBUG* in all
defconfig files.

This patch is harmless for all modified defconfig files.

Signed-off-by: Semen Protsenko <semen.protsenko@globallogic.com>
---
 arch/arm/configs/badge4_defconfig       |    1 -
 arch/arm/configs/hackkit_defconfig      |    2 --
 arch/arm/configs/lart_defconfig         |    2 --
 arch/arm/configs/omap1_defconfig        |    2 --
 arch/blackfin/configs/DNP5370_defconfig |    2 --
 arch/mn10300/configs/asb2303_defconfig  |    1 -
 arch/mn10300/configs/asb2364_defconfig  |    1 -
 arch/sh/configs/edosk7760_defconfig     |    1 -
 arch/sh/configs/titan_defconfig         |    1 -
 9 files changed, 13 deletions(-)

diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index e8913b0..9d11ff7 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -29,7 +29,6 @@ CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIVHCI=m
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index ab2acf1..f469536 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -20,8 +20,6 @@ CONFIG_INET=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=3
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index 191c0b3..ff61d33 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -29,8 +29,6 @@ CONFIG_IRDA_CACHE_LAST_LSAP=y
 CONFIG_IRDA_DEBUG=y
 CONFIG_SA1100_FIR=m
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=1
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_LART=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index a234203..f10b269 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -92,8 +92,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
 # CONFIG_PROC_EVENTS is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=3
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
diff --git a/arch/blackfin/configs/DNP5370_defconfig b/arch/blackfin/configs/DNP5370_defconfig
index 8860059..18e97c1 100644
--- a/arch/blackfin/configs/DNP5370_defconfig
+++ b/arch/blackfin/configs/DNP5370_defconfig
@@ -34,8 +34,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_LLC2=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=1
 CONFIG_MTD_BLOCK=y
 CONFIG_NFTL=y
 CONFIG_NFTL_RW=y
diff --git a/arch/mn10300/configs/asb2303_defconfig b/arch/mn10300/configs/asb2303_defconfig
index 4f0f31f..b6364ea 100644
--- a/arch/mn10300/configs/asb2303_defconfig
+++ b/arch/mn10300/configs/asb2303_defconfig
@@ -33,7 +33,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
 CONFIG_MTD_CFI=y
diff --git a/arch/mn10300/configs/asb2364_defconfig b/arch/mn10300/configs/asb2364_defconfig
index f5ccb76..b43179f 100644
--- a/arch/mn10300/configs/asb2364_defconfig
+++ b/arch/mn10300/configs/asb2364_defconfig
@@ -50,7 +50,6 @@ CONFIG_IPV6=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
 CONFIG_MTD_CFI=y
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index e98e847..758b489 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -38,7 +38,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEBUG_DRIVER=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index cbb3166..2417a09 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -153,7 +153,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_FW_LOADER=m
 CONFIG_CONNECTOR=m
 CONFIG_MTD=m
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_BLOCK=m
 CONFIG_FTL=m
 CONFIG_NFTL=m
-- 
1.7.9.5
