Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 14:53:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11087 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009575AbbJNMwnphm5C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2015 14:52:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A4DE67CEC1FE4;
        Wed, 14 Oct 2015 13:52:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 14 Oct 2015 13:52:37 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 14 Oct 2015 13:52:37 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>
CC:     <linux-mips@linux-mips.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH 5/5] MIPS: Add xilfpga defconfig
Date:   Wed, 14 Oct 2015 13:51:57 +0100
Message-ID: <1444827117-10939-6-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/mips/configs/xilfpga_defconfig | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/mips/configs/xilfpga_defconfig

diff --git a/arch/mips/configs/xilfpga_defconfig b/arch/mips/configs/xilfpga_defconfig
new file mode 100644
index 0000000..94bb9b8
--- /dev/null
+++ b/arch/mips/configs/xilfpga_defconfig
@@ -0,0 +1,59 @@
+CONFIG_MACH_XILFPGA=y
+# CONFIG_COMPACTION is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+# CONFIG_USELIB is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+# CONFIG_BLOCK is not set
+# CONFIG_SUSPEND is not set
+# CONFIG_UEVENT_HELPER is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_XILINX=y
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_SYSCTL is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_PANIC_ON_OOPS=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_LOCK_ALLOC=y
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,115200 clk_ignore_unused earlyprintk=serial,ttyS0,115200"
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRC16=y
+CONFIG_LIBCRC32C=y
-- 
1.9.1
