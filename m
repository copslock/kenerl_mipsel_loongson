Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 16:51:57 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40728 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdLHPrzPVVXP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 16:47:55 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id EC60920956; Fri,  8 Dec 2017 16:47:44 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 5C01220960;
        Fri,  8 Dec 2017 16:47:27 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 12/13] MIPS: defconfigs: add a defconfig for Microsemi SoCs
Date:   Fri,  8 Dec 2017 16:46:17 +0100
Message-Id: <20171208154618.20105-13-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Add a defconfg that reaches userspace for Microsemi Ocelot.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/mips/configs/mscc_defconfig | 84 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/mips/configs/mscc_defconfig

diff --git a/arch/mips/configs/mscc_defconfig b/arch/mips/configs/mscc_defconfig
new file mode 100644
index 000000000000..58cf09b1ae82
--- /dev/null
+++ b/arch/mips/configs/mscc_defconfig
@@ -0,0 +1,84 @@
+CONFIG_MSCC_OCELOT=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_MIPS_ELF_APPENDED_DTB=y
+CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
+# CONFIG_SWAP is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_SHMEM is not set
+CONFIG_EMBEDDED=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=y
+# CONFIG_NF_CT_PROTO_DCCP is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CT_PROTO_UDPLITE is not set
+CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
+CONFIG_NETFILTER_XT_MATCH_LIMIT=y
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP6_NF_IPTABLES=y
+CONFIG_IP6_NF_FILTER=y
+CONFIG_VLAN_8021Q=y
+CONFIG_NET_SWITCHDEV=y
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_NETDEVICES=y
+CONFIG_TUN=y
+CONFIG_MICROSEMI_PHY=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_N_GSM=y
+CONFIG_DEVKMEM=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_SPI=y
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_SPIDEV=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_OCELOT_RESET=y
+CONFIG_SENSORS_TMP401=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_UIO=y
+CONFIG_UIO_PDRV_GENIRQ=y
+CONFIG_OVERLAY_FS=y
+CONFIG_JFFS2_FS=y
+CONFIG_UBIFS_FS=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0
+# CONFIG_EARLY_PRINTK is not set
+# CONFIG_CRYPTO_HW is not set
-- 
2.15.1
