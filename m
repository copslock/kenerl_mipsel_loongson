Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 00:58:20 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36671 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010229AbcAQX5MbiPGD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 00:57:12 +0100
Received: by mail-lb0-f180.google.com with SMTP id oh2so339170861lbb.3
        for <linux-mips@linux-mips.org>; Sun, 17 Jan 2016 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sw9Xjnpg8E8gZL7uB4a9uHsO0G55PV2WcADZP0X8Zwc=;
        b=K+056jhw5xf44es563Ya+Gke3LljRSeiu4sEoomzoblttLzZ5O0F5op1Rm2eJGlngP
         pyGYqMOpzdGsTiJ4RDiShbgUCwsH2eNPkt38MDZ9ZZ6fJtmuEX1tB7LWEOg9z29gTXEd
         GjuHqS1GcEolyOcfCodREsCLJHRjpvs7wJLfMTPvcYfO7Y1P/5AAw6MiL9xn+2gVJvOV
         fWmPB77Nbx1cvLwQSHyozq2dnFdbvhxkFAha7jZ3CCxkMyQNvx+pCp0mV1RtUCugb0Fa
         xR4rpkJkeBhdlFcOrid6PrxYImDOularJwx8i3tPL8s91+V8X5mkwONvfWZgodZ5PCt/
         tCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sw9Xjnpg8E8gZL7uB4a9uHsO0G55PV2WcADZP0X8Zwc=;
        b=YZLu45rtuM6lWvMDakAd7lS5uTBBpaSYBxQvN7Y3vQr2UfdmIbtBDlAl8jIRDs5FPa
         dUvANzJLt8re0682pspXGJ/BxuQkTIx+oU54t8lMkT11S7UK6gtOVi00ovrEtvO0A4zn
         pFEpVt+8BWDOau1k3YRTOdWTE78sXEOhPlB6AoSdlhXozoE/7TWIn4U78Tjh8Xt5j/Bj
         naY8MkrphoZu+a6TD6/f2OvxK1QTH722BspZzWTsZurDCCVFTTjkeb7PfKiCgHPTgcZQ
         fkt1i9bN0WZqRuL+vDBHY0PejlRckMSYJ3NnF3TW3uz+NRdfyNfB1D3vVWPifWEdQyHM
         6KNw==
X-Gm-Message-State: ALoCoQkjDTxXPU3Qpb1T7+dIcHySQwUSH14GOG/qlFNoPhUd+DJhbmi5KNhFvGZv1kzyMNJZQQ7hBXhss8/NPZnpFUb452S8+Q==
X-Received: by 10.112.201.67 with SMTP id jy3mr7352554lbc.25.1453075027249;
        Sun, 17 Jan 2016 15:57:07 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id xe8sm2783445lbb.41.2016.01.17.15.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 15:57:06 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Yegor Yefremov <yegorslists@googlemail.com>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 4/4] WIP: MIPS: add tl-mr3020-dt-raw_defconfig
Date:   Mon, 18 Jan 2016 02:56:27 +0300
Message-Id: <1453074987-3356-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
References: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

The tl-mr3020-dt-raw_defconfig conf file is used
to demonstrate devicetree-enabled linux kernel
runs on TP-LINK MR3020 board with u-boot_mod bootloader.

Here is a small instruction:

1. download rootfs.mipsI.cpio image into your linux kernel
   source root dir.

    $ wget https://github.com/frantony/linux/raw/c95a5953e3dd96ad304de515f79acb555e0bc24e/rootfs.mipsI.cpio

2. you have to disable fw_getenv() function because
devicetree-enabled kernel will hangs if started
from u-boot_mod:

    > --- a/arch/mips/fw/lib/cmdline.c
    > +++ b/arch/mips/fw/lib/cmdline.c
    > @@ -51,6 +51,8 @@ char *fw_getenv(char *envname)
    > {
    >        char *result = NULL;
    >
    > +       return result;
    > +

2. compile vmlinux.bin kernel image, e.g.

    $ make ARCH=mips tl-mr3020-dt-raw_defconfig
    $ make ARCH=mips CROSS_COMPILE=<your cross compiler> vmlinux.bin

3. put the vmlinux.bin to root directory of your tftp-server

4. connect to u-boot_mod console

5. download vmlinux.bin into RAM and run it:

   uboot> setenv serverip 192.168.1.2; setenv ipaddr 192.168.1.22
   uboot> tftpboot 0x80060000 vmlinux.bin; go 0x80060000

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/configs/tl-mr3020-dt-raw_defconfig | 85 ++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/mips/configs/tl-mr3020-dt-raw_defconfig b/arch/mips/configs/tl-mr3020-dt-raw_defconfig
new file mode 100644
index 0000000..00cf775
--- /dev/null
+++ b/arch/mips/configs/tl-mr3020-dt-raw_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ATH79=y
+CONFIG_DTB_TL_MR3020=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_RAW_APPENDED_DTB=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_DEBUG=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="rootfs.mipsI.cpio"
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_IPV6 is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_NETDEVICES=y
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_AR933X=y
+CONFIG_SERIAL_AR933X_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_ATH79=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_PROC_KCORE=y
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="init=/bin/sh machtype=DTB console=ttyATH0 root=/dev/ram"
+CONFIG_CMDLINE_OVERRIDE=y
+CONFIG_DEBUG_ZBOOT=y
+CONFIG_CRC_ITU_T=y
-- 
2.6.2
