Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:15:23 +0100 (CET)
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34376 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011956AbcBAALHvKdGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:07 +0100
Received: by mail-lf0-f42.google.com with SMTP id j78so16236745lfb.1
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pWtJI40afsm+HdesxcZtiJv3htRjovt/yigkxfbvI1E=;
        b=KsQ3RC78IKrnyg4CLGw+DMLc9jumHSPMzPVhtW/ToKvzQFuUGddGCz1A4M1+2TaNJT
         jILIil9/64u+tJPpEEbaXbgpw8YE2whY5wiKdZ3uAtQA0uqTWUneMY2o3IfCbd1ZtS3p
         aQBa0M/2ERUSvmcN+oepEauPEjGjsDbd7CUzoRVvRiysakfKFszwTfd2LoRL7k0T7eA2
         6HuT+iRr9rPma1vaUm92gaEjE0H/e9gXHqCY16g1Z6BHIud5djJnhsVWXdwaDhqlNfjY
         eF+jUIhBxkz34ivoFcr7JRbNG9gWs3OYhZFVHXvW33fGz97CTC0Jk0utTFBpbrmgdVHY
         JixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pWtJI40afsm+HdesxcZtiJv3htRjovt/yigkxfbvI1E=;
        b=DCnadPro+JyFJTV2uC5rrkGDABpM0YJhOQeDR4boUGVj61h40wj+6fxvsIQFMLyXcL
         CkXbPxu5yWgOiNrWUbf1TWFkgaB+L+H5c9vXuOUx66dgkViK/k8wqOO6T+RQo1D9dvio
         setHKwA8keZ17j/BArvBwAmnTeDD6vVdMW+mrIf49SiCeTLNsAavEO8KAQn/q0sYp+GQ
         RgDqIpXM9v2NPYCF86mIhtS5ItHud9wQzCfWMb1gsmwBN36fPk72pUcBrgkQEayZxr6B
         OP6nFsofO+fcNxbfbnxjZ7GkA+mdXOiUZJ9xo/2gzLkA0HvqQn2QGRfpnZ54M/RCiWf3
         QxYQ==
X-Gm-Message-State: AG10YOSdAtYBMDWtCHDz3f5cKpGiGk60fdVa5uv/YLVLEesM8/k7BNo1SDr+odjN8N6Z0g==
X-Received: by 10.25.145.197 with SMTP id t188mr5958640lfd.55.1454285462551;
        Sun, 31 Jan 2016 16:11:02 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:11:02 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC v4 15/15] WIP: MIPS: ath79: add devicetree defconfigs
Date:   Mon,  1 Feb 2016 03:10:40 +0300
Message-Id: <1454285440-18916-16-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51576
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
to demonstrate devicetree-enabled ath79 linux kernel.
The boards with u-boot_mod-like bootloader are supported:

  * TP-LINK MR3020;
  * Dragino 2;
  * Onion Omega;
  * TP-LINK WR1043ND.

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

  3.1 for TP-LINK TL-MR3020

    $ make ARCH=mips tl-mr3020-dt-raw_defconfig

  3.2 for Dragino 2

    $ make ARCH=mips dragino-ms14-dt-raw_defconfig

  3.3 for Onion Omega

    $ make ARCH=mips onion-omega-dt-raw_defconfig

  3.4 for TP-LINK TL-WR1043ND

    $ make ARCH=mips tl-wr1043nd_defconfig

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
 arch/mips/configs/dragino-ms14-dt-raw_defconfig | 93 ++++++++++++++++++++++++
 arch/mips/configs/onion-omega-dt-raw_defconfig  | 85 ++++++++++++++++++++++
 arch/mips/configs/tl-mr3020-dt-raw_defconfig    | 85 ++++++++++++++++++++++
 arch/mips/configs/tl-wr1043nd_defconfig         | 95 +++++++++++++++++++++++++
 4 files changed, 358 insertions(+)

diff --git a/arch/mips/configs/dragino-ms14-dt-raw_defconfig b/arch/mips/configs/dragino-ms14-dt-raw_defconfig
new file mode 100644
index 0000000..1c9c0ac
--- /dev/null
+++ b/arch/mips/configs/dragino-ms14-dt-raw_defconfig
@@ -0,0 +1,93 @@
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
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEBUG=y
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
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
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
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PHY_SIMPLE_PDEV=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_VFAT_FS=y
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
diff --git a/arch/mips/configs/onion-omega-dt-raw_defconfig b/arch/mips/configs/onion-omega-dt-raw_defconfig
new file mode 100644
index 0000000..39acb97
--- /dev/null
+++ b/arch/mips/configs/onion-omega-dt-raw_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ATH79=y
+CONFIG_DTB_ONION_OMEGA=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_RAW_APPENDED_DTB=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEBUG=y
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
index 0000000..f7394fc
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
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEBUG=y
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
diff --git a/arch/mips/configs/tl-wr1043nd_defconfig b/arch/mips/configs/tl-wr1043nd_defconfig
new file mode 100644
index 0000000..b6cdc3e
--- /dev/null
+++ b/arch/mips/configs/tl-wr1043nd_defconfig
@@ -0,0 +1,95 @@
+CONFIG_ATH79=y
+CONFIG_DTB_TL_WR1043ND_V1=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_RAW_APPENDED_DTB=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEBUG=y
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
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_NETDEVICES=y
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_ATH79=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PHY_SIMPLE_PDEV=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_VFAT_FS=y
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
+CONFIG_CMDLINE="init=/bin/sh machtype=DTB console=ttyS0,115200 root=/dev/ram"
+CONFIG_CMDLINE_OVERRIDE=y
+CONFIG_DEBUG_ZBOOT=y
+CONFIG_CRC_ITU_T=y
-- 
2.7.0
