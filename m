Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:18:48 +0100 (CET)
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36851 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011318AbcBIIOoyN7Z5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:44 +0100
Received: by mail-lf0-f41.google.com with SMTP id 78so110701192lfy.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJfz7wiwV0EHhlyqkXMt46uMhaGfaOXCXYjvvRaGZHw=;
        b=gLO7QDDxb6e/Dhe65yZn6YP+rhzT0X2rfSJph02hcB6JVQbsmZ4/DPUCAf7gItw3jx
         34M9UtsSZa+7x3QiSVZWR0W+tDPkM3SAoQ21dxy6ZMW13J48FP5qL+3b3RaTmqVLA9k7
         KxybgG6aHqJptYHo2QYI9uGmxvild/nHlbEXqIOj1OpnHN7oko3OJmCBiO4Cu91f/a1p
         2tz90gu7U3NwJj8E9PXc8r5MBOveHWJbkjT9FXRioH9n7QXDc40NtHafeTSklkVeGzJF
         Gx6e2NfHH0IrTvP019wtYyAp4w8aOpfh76YZpYUXJ6GP663uH93JYTb9PpDqhROLP9s1
         BV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PJfz7wiwV0EHhlyqkXMt46uMhaGfaOXCXYjvvRaGZHw=;
        b=V6164ikaMA+cPCjbI4hCTZXRY+EFgZMWkgP7yWKtwfrLj43i6vmC2R99VdSK/zjK/+
         OydObvgJtyhVOB7wCU1IGyJbUswV1VsXmKJb4i4GS8SIOk6vvMeG5Q6bKH9ezWvIOONV
         H9fDK7Sul7F+1C7TUQZozHPMAhiQFQ+nFDwAVHQKtQMVnhsgfhVt8WuPthoSODXg7Cxu
         S9qX+lLM0oNpZh7wfGlLDeDXjR3YrQKp2jCnZuqA4+T6qz39ZysefpbTeK0fquACLWKu
         Yk9/m1xDnod8bnHL8CgstAcRgltBRg4u4XCWwl3CVDOTVkoNSrnh4CWkngmB0K0MArhr
         iJog==
X-Gm-Message-State: AG10YOQq1kRjvWt2+oMNCog154QSA2EKUcAHeKgMivTZW+1XsKSMj7brMu6mOmA9XwGQgQ==
X-Received: by 10.25.155.72 with SMTP id d69mr2313795lfe.134.1455005679640;
        Tue, 09 Feb 2016 00:14:39 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:39 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>
Subject: [RFC v5 15/15] WIP: MIPS: ath79: add AR9331 devicetree defconfig
Date:   Tue,  9 Feb 2016 11:14:01 +0300
Message-Id: <1455005641-7079-16-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51891
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

This commit adds defconfig file for AR9331 kernel
with device tree support.

The boards with u-boot_mod-like bootloader are supported:

  * TP-LINK MR3020;
  * Dragino 2;
  * Onion Omega;
  * DPTechnics DPT-Module.

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
    >  {
    >         char *result = NULL;
    >
    > +       return result;
    > +

3. configure linux kernel and build vmlinux.bin linux kernel image

    $ make ARCH=mips ar9331-dt-raw_defconfig
    $ make ARCH=mips CROSS_COMPILE=<your cross compiler> vmlinux.bin

4. prepare vmlinux_dtb.bin image for your board

  4.1 for TP-LINK TL-MR3020

    $ make ARCH=mips qca/tl_mr3020.dtb
    $ cat arch/mips/boot/vmlinux.bin arch/mips/boot/dts/qca/tl_mr3020.dtb > vmlinux_dtb.bin

  4.2 for Dragino 2

    $ make ARCH=mips qca/dragino_ms14.dtb
    $ cat arch/mips/boot/vmlinux.bin arch/mips/boot/dts/qca/dragino_ms14.dtb > vmlinux_dtb.bin

  4.3 for Onion Omega

    $ make ARCH=mips qca/omega.dtb
    $ cat arch/mips/boot/vmlinux.bin arch/mips/boot/dts/qca/omega.dtb > vmlinux_dtb.bin

  4.4 DPTechnics DPT-Module

    $ make ARCH=mips qca/dpt_module.dtb
    $ cat arch/mips/boot/vmlinux.bin arch/mips/boot/dts/qca/dpt_module.dtb > vmlinux_dtb.bin

5. put the vmlinux_dtb.bin into the root directory of your tftp-server

6. connect to u-boot_mod console

7. use u-boot_mod to download vmlinux_dtb.bin into RAM of your board and run it:

   uboot> setenv serverip 192.168.1.2; setenv ipaddr 192.168.1.22
   uboot> tftpboot 0x80060000 vmlinux_dtb.bin; go 0x80060000

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/configs/ar9331-dt-raw_defconfig | 100 ++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/mips/configs/ar9331-dt-raw_defconfig b/arch/mips/configs/ar9331-dt-raw_defconfig
new file mode 100644
index 0000000..5d81969
--- /dev/null
+++ b/arch/mips/configs/ar9331-dt-raw_defconfig
@@ -0,0 +1,100 @@
+CONFIG_ATH79=y
+CONFIG_ATH79_MACH_AP121=y
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
+CONFIG_SERIAL_AR933X=y
+CONFIG_SERIAL_AR933X_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_ATH79=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+# CONFIG_USB_EHCI_ATH79 is not set
+CONFIG_USB_EHCI_HCD_PLATFORM=y
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
+CONFIG_CMDLINE="init=/bin/sh machtype=DTB console=ttyATH0 root=/dev/ram"
+CONFIG_CMDLINE_OVERRIDE=y
+CONFIG_DEBUG_ZBOOT=y
+CONFIG_CRC_ITU_T=y
-- 
2.7.0
