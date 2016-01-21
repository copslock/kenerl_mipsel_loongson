Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:36:52 +0100 (CET)
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36215 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011338AbcAUWeraRPGN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:47 +0100
Received: by mail-lf0-f53.google.com with SMTP id h129so36491458lfh.3
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvOk+PDX65QGn8Gr4SHHpDPc5B3c9hzIv0KhrQMUXJI=;
        b=kRh8qGFFpnMr0sTHlq/ZGyw/z5LYtDt6XNwHLMr0LAFwb5WodQ/ZUIv+AfAJh8iUj2
         1berzocKyvk18V73MOd9AmLp4FVxtHJj+6ZOJmlY73CnWRNN0jyp/w8fUGeeV233kif7
         qwUgUEW8ZGveMFQmuvopNCcYkKGX8bwvGHrGYv3wvSJqBiWSZKM2fMJfga023CCi/Deu
         17n7eK4IKTILPW/3ylfwJIIQnplJmbLVHLDGlKvbS73bXbv42uIPFQa7LqjKQ3jzolSh
         ARsVjeKZs5ggWww9zlrSaR9Gr31VrDKh28egNY3+yBawEhkZI/jEehC+45LYuGZ/lx6U
         RciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvOk+PDX65QGn8Gr4SHHpDPc5B3c9hzIv0KhrQMUXJI=;
        b=jmpsqCz7RNQqEZCakAPAPBc8GtlXB2/LPKYSFyFDYW6v+6U1y/cFCaG694ldO0P18A
         0layGULzdEraAXqNR4HdL0aHLealb/tfMAPOGgt6b2I2v43FBItzcgF9nG+kcC1clt21
         gJKN96f1ikceDqhlUVlxVv9Bsgw6JtNYPfQLsreZwo76SenPzVNL9I31wmW7/Q7B/TGC
         O0Rng/f7cYn7Uzy8VZlb/r0YL+BLqFlmLatUEzsUi8lwaDr55EY0ZYVx1it6/S6sjx4x
         +Nr8EpzAwzVcTHS+2t4Zi3326RAbtO7UGvZKBFtljwxrGA/IyXM4OVUUl2lOPU288a0S
         i+jA==
X-Gm-Message-State: ALoCoQk+SDsrSDdMi6buaN/V5GLmeVhzm18DbckWjOJLDkAQ/h9I1aIA69WSyRJ3gyUuU/qI3XC9mzXdoSPJwh/53r6thFjPdg==
X-Received: by 10.25.23.232 with SMTP id 101mr16920434lfx.68.1453415682035;
        Thu, 21 Jan 2016 14:34:42 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:41 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC v2 7/7] WIP: MIPS: add ar9331 devicetree defconfigs
Date:   Fri, 22 Jan 2016 01:34:24 +0300
Message-Id: <1453415664-20307-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51290
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

This commits add defconfig files
to demonstrate devicetree-enabled linux kernel
runs on TP-LINK MR3020 board with u-boot_mod bootloader
or on Dragino 2 board.

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

3. configure linux kernel, e.g.

  3.1 for MR3020

    $ make ARCH=mips tl-mr3020-dt-raw_defconfig

  3.2 for Dragino 2

    $ make ARCH=mips dragino-ms14-dt-raw_defconfig

4. compile vmlinux.bin kernel image, e.g.

    $ make ARCH=mips CROSS_COMPILE=<your cross compiler> vmlinux.bin

5. put the vmlinux.bin into the root directory of your tftp-server

6. connect to u-boot_mod console

7. use u-boot_mod to download vmlinux.bin into RAM of your board and run it:

   uboot> setenv serverip 192.168.1.2; setenv ipaddr 192.168.1.22
   uboot> tftpboot 0x80060000 vmlinux.bin; go 0x80060000

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/configs/dragino-ms14-dt-raw_defconfig | 85 +++++++++++++++++++++++++
 arch/mips/configs/tl-mr3020-dt-raw_defconfig    | 85 +++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/arch/mips/configs/dragino-ms14-dt-raw_defconfig b/arch/mips/configs/dragino-ms14-dt-raw_defconfig
new file mode 100644
index 0000000..b7c9eff
--- /dev/null
+++ b/arch/mips/configs/dragino-ms14-dt-raw_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ATH79=y
+CONFIG_DTB_DRAGINO_MS14=y
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
