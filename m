Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 23:01:30 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34434 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012356AbcBMV6llPeEi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:41 +0100
Received: by mail-lb0-f172.google.com with SMTP id ap4so3910177lbd.1;
        Sat, 13 Feb 2016 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=slUCfMP7NpBQWr35gVDkdaKiw+mtGklm5DjKtZ2nqAY=;
        b=Tk6TJ9rVl6+RULflhcs/Z/sTEd/FXKPDd+dw1qLq3zZQZgxxJkww83U49JZvnbwwJF
         0BiVfroZ+eCvXkU6MZ8zUUIaVr3farUAfw9iEQx3UZ9jUKUV6hL8CrXs4Un0i3Ay+Xzk
         ydLKaxBnnxPsC8lvwXGm+6eX+672mklYrVR7s9MGbNTX85QfO19nNPCc7omdfFmf6u1+
         iIKCYJz1e/z+gb+ZdcuzCTdNHw2REIHfORwwzlDtzzxWIrNfd4HJnGpf5ELegu+jewbc
         wx0TauQFKCs5lcrJbtTs38S/nenqE/s66sTvTyr+pSNiLjEtuaEXwT0kHkQv38ApGehv
         jKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=slUCfMP7NpBQWr35gVDkdaKiw+mtGklm5DjKtZ2nqAY=;
        b=Ds56XvojEtKelBHn3p+A6/0UubF90dxvRcFe6p3Mor8da2TAKufuCvVRquP0AUm4On
         IeIgaq9SKhtb5fmTy4xl9tzlsB17dFLGipLWlM8hL1pEcyR8gfuh3MC6iwKkdzZb7QRw
         3lOHTLATN50MY+M5a7cjoHsVweKc9xEiI8Tbf39xN3zVd0mYVBl8s6YwnZ+muBS+O4RR
         b8QOVt00Hfk5VTEiUJvGx3FDn1V41cpF0eklE6hA2UMGYksFifa1za/QX8hoCv6hHA2a
         cEBbDHKordnHCTSWRqEytJUBlyaiuPXZqbGJu2GMUiS5v674WwA8E6Kp52FxgV8KEZhC
         d+JA==
X-Gm-Message-State: AG10YOQQFyJF/uupoJtAF7Y4hg5ykML0xdNuVmEUtp31gXEGwlsLK2Nj/CIH3OXzbB8dkA==
X-Received: by 10.112.89.36 with SMTP id bl4mr3521741lbb.37.1455400716407;
        Sat, 13 Feb 2016 13:58:36 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:35 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [RFC 10/10] WIP: MIPS: ath79: add tl-wr1043nd{,no-dt}_defconfig
Date:   Sun, 14 Feb 2016 00:58:17 +0300
Message-Id: <1455400697-29898-11-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52042
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

This commit adds defconfig files for testing linux kernel
on TP-LINK WE1043ND router. Two configurations are proposed:
one with device tree support and another one legacy platform
configuration.

This patchseries relies on additonal patches by Alban Bedel:

  * MIPS: OF: Rework the appended DTB handling to keep the PROM arguments
        https://github.com/AlbanBedel/linux/commit/3e1bb5db49a9da1d5d9c90d345fd114f00596c19

  * MIPS: ath79: Add support for DTB passed using the UHI boot protocol
        https://github.com/AlbanBedel/linux/commit/b0229b82f84c3e054308eb481d0f4a782fc8ac41

  * MIPS: ath79: Remove the builtin DTB support
        https://github.com/AlbanBedel/linux/commit/0b8843b069e525db690c253e03b7a15bc1d1f0df

  * MIPS: ath79: Add the TL-WR1043ND as legacy device for testing
        https://github.com/AlbanBedel/linux/commit/5386bf83c03bfc41fc6a9394e1424544806e36f7

Here is a small instruction:

1. download rootfs.mipsI.cpio image into your linux kernel
   source root dir.

    $ wget https://github.com/frantony/linux/raw/c95a5953e3dd96ad304de515f79acb555e0bc24e/rootfs.mipsI.cpio

2. you have to disable fw_getenv() function because
devicetree-enabled kernel will hangs if started from u-boot:

    > --- a/arch/mips/fw/lib/cmdline.c
    > +++ b/arch/mips/fw/lib/cmdline.c
    > @@ -51,6 +51,8 @@ char *fw_getenv(char *envname)
    >  {
    >         char *result = NULL;
    >
    > +       return result;
    > +

3. configure linux kernel and build vmlinux*.bin linux kernel image

  3.1 with devicetree support

    $ make ARCH=mips tl-wr1043nd_defconfig
    $ make ARCH=mips CROSS_COMPILE=<your cross compiler> vmlinux.bin qca/ar9132_tl_wr1043nd_v1.dtb
    $ cat arch/mips/boot/vmlinux.bin \
          arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb \
          > vmlinux_dtb.bin

  3.2 without devicetree support

    $ make ARCH=mips tl-wr1043nd-no-dt_defconfig
    $ make ARCH=mips CROSS_COMPILE=<your cross compiler> vmlinux.bin

4. put the vmlinux_dtb.bin and vmlinux.bin into the root directory of your tftp-server

5. connect to u-boot console

6. use u-boot to download vmlinux_dtb.bin into RAM of your board and run it:

  6.1 with devicetree support

   uboot> setenv serverip 192.168.1.2; setenv ipaddr 192.168.1.22
   uboot> tftpboot 0x80060000 vmlinux_dtb.bin; go 0x80060000

  6.2 without devicetree support

   uboot> setenv serverip 192.168.1.2; setenv ipaddr 192.168.1.22
   uboot> tftpboot 0x80060000 vmlinux.bin; go 0x80060000

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/configs/tl-wr1043nd-no-dt_defconfig | 100 ++++++++++++++++++++++++++
 arch/mips/configs/tl-wr1043nd_defconfig       |  98 +++++++++++++++++++++++++
 2 files changed, 198 insertions(+)

diff --git a/arch/mips/configs/tl-wr1043nd-no-dt_defconfig b/arch/mips/configs/tl-wr1043nd-no-dt_defconfig
new file mode 100644
index 0000000..f316305b
--- /dev/null
+++ b/arch/mips/configs/tl-wr1043nd-no-dt_defconfig
@@ -0,0 +1,100 @@
+CONFIG_ATH79=y
+CONFIG_ATH79_MACH_TL_WR1043ND=y
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
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_GPIO_POLLED=y
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
+# CONFIG_PHY_ATH79_USB is not set
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
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="init=/bin/sh machtype=TL-WR1043ND console=ttyS0,115200 root=/dev/ram"
+CONFIG_CMDLINE_OVERRIDE=y
+CONFIG_DEBUG_ZBOOT=y
+CONFIG_CRC_ITU_T=y
diff --git a/arch/mips/configs/tl-wr1043nd_defconfig b/arch/mips/configs/tl-wr1043nd_defconfig
new file mode 100644
index 0000000..785379f
--- /dev/null
+++ b/arch/mips/configs/tl-wr1043nd_defconfig
@@ -0,0 +1,98 @@
+CONFIG_ATH79=y
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
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_GPIO_POLLED=y
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
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="init=/bin/sh machtype=DTB console=ttyS0,115200 root=/dev/ram"
+CONFIG_CMDLINE_OVERRIDE=y
+CONFIG_DEBUG_ZBOOT=y
+CONFIG_CRC_ITU_T=y
-- 
2.7.0
