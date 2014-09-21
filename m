Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:48:04 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44989 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009384AbaIUArBJ00Jh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:47:01 +0200
Received: by mail-pa0-f51.google.com with SMTP id eu11so629745pac.10
        for <multiple recipients>; Sat, 20 Sep 2014 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hrRCktwHdBmTmdgwf8IVG7O/S6FmccEixvIqHIYMnSg=;
        b=b5GQYCO/NENaq7lrPqxh0oeWmDwH+JSyhHoLQYUmB6G4Z7Mr+3rEzp5VMsfwadHAjL
         wKCgd3YWfPlJ0C52xQVBTrLiN0wRL3SGvhQryRxEq1VU8nhWV3zLJhJcLkd9qiUsF0v9
         L9pYzM4RTjfujfeSLMCCgrxzSj1Weoy8xX86Q78EE2Vq9xQqUPCM7u/AjIMTZX3Io9m+
         ev6yklZsgv7egfz+6WatVYN93R8618C2A4F4nA0S5De/VJHaSrjhX9BYjSRLcGYF+E6A
         oBKPsE9xCrQQjR8RlVbPEAUTiDmWPIkuLcI20oVBf4RVxC+uoZ3X+sF73OwbwfvOMCUq
         X7Rg==
X-Received: by 10.68.69.41 with SMTP id b9mr10601849pbu.109.1411260413912;
        Sat, 20 Sep 2014 17:46:53 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id hq5sm4906536pbc.21.2014.09.20.17.46.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:46:53 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 04/11] next: mips: Fix loongson3_defconfig
Date:   Sat, 20 Sep 2014 17:46:19 -0700
Message-Id: <1411260386-6800-5-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Commit 5d6be6a5d486 ('scsi_netlink : Make SCSI_NETLINK dependent on NET instead
of selecting NET') changes 'select NET' to 'depends NET'. As a result, many
configurations which do not explicitly select CONFIG_NET are no longer valid
and need to be updated.

The command sequence to create the new configuration is as follows.

- Run "make ARCH=mips <configuration>" on upstream kernel
- Copy resulting .config to next-20140919
- Run "make ARCH=mips olddefconfig" in next-20140919
- Run "make ARCH=mips savedefconfig"
- Copy resulting defconfig file to arch/mips/configs/<configuration>
- Build the image with the resulting configuration

Fixes: 5d6be6a5d486 ('scsi_netlink : Make SCSI_NETLINK dependent on NET instead of selecting NET')
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/configs/loongson3_defconfig | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 4cb787f..5a73d17 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -1,12 +1,7 @@
 CONFIG_MACH_LOONGSON=y
-CONFIG_SWIOTLB=y
 CONFIG_LOONGSON_MACH3X=y
-CONFIG_CPU_LOONGSON3=y
-CONFIG_64BIT=y
-CONFIG_PAGE_SIZE_16KB=y
 CONFIG_KSM=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=4
 CONFIG_HZ_256=y
 CONFIG_PREEMPT=y
 CONFIG_KEXEC=y
@@ -42,12 +37,9 @@ CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
-CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IOSCHED_DEADLINE=m
 CONFIG_CFQ_GROUP_IOSCHED=y
-CONFIG_PCI=y
-CONFIG_HT_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_HOTPLUG_PCI_PCIE=y
 # CONFIG_PCIEAER is not set
@@ -59,6 +51,7 @@ CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_PM_RUNTIME=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=y
@@ -95,7 +88,6 @@ CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -124,7 +116,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_CHR_DEV_SCH=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SPI_ATTRS=m
@@ -165,7 +156,6 @@ CONFIG_TUN=m
 # CONFIG_NET_VENDOR_AMD is not set
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CHELSIO is not set
@@ -242,6 +232,7 @@ CONFIG_HW_RANDOM=y
 CONFIG_RAW_DRIVER=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
+CONFIG_SPI=y
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM93=m
 CONFIG_SENSORS_W83627HF=m
@@ -251,7 +242,6 @@ CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
-CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB_RADEON=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
-- 
1.9.1
