Return-Path: <SRS0=t3K6=UI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D890FC28EBD
	for <linux-mips@archiver.kernel.org>; Sun,  9 Jun 2019 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7770208E4
	for <linux-mips@archiver.kernel.org>; Sun,  9 Jun 2019 12:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfFIMbk (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:31:40 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35979 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFIMbk (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 9 Jun 2019 08:31:40 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 457DD40009;
        Sun,  9 Jun 2019 12:31:30 +0000 (UTC)
Date:   Sun, 9 Jun 2019 14:31:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com,
        UNGLinuxDriver@microchip.com, ebiggers@google.com,
        chandan@linux.vnet.ibm.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Ocelot: configs: Move ocelot.config from generic
Message-ID: <20190609123130.GA25472@piout.net>
References: <1560082846-6320-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560082846-6320-1-git-send-email-horatiu.vultur@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On 09/06/2019 14:20:46+0200, Horatiu Vultur wrote:
> Move board-ocelot.config from configs/generic to configs. This allows to
> enable or disable more configuration options for ocelot board.
> Therefore enable the following options:
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_XZ=y
> CONFIG_NET_SCHED=y
> CONFIG_NET_SCH_INGRESS=y
> CONFIG_NET_CLS_MATCHALL=y
> CONFIG_NET_CLS_FLOWER=y
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=y
> CONFIG_NET_ACT_GACT=y
> CONFIG_BRIDGE_VLAN_FILTERING=y
> 

It is up to the MIPS maintainers to choose but I think the current trend
is to avoid adding more configs and keep everything too board specific
out of tree. However, the config is already there and I'm not sure we
can get something like multi_v7 that would enable as many features as
possible anyway.

> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  arch/mips/Makefile                            |   3 -
>  arch/mips/configs/generic/board-ocelot.config |  51 ----------
>  arch/mips/configs/ocelot_defconfig            | 140 ++++++++++++++++++++++++++

Maybe this could use a more generic name, as ultimately you'd want to
also support other mscc platforms.

>  3 files changed, 140 insertions(+), 54 deletions(-)
>  delete mode 100644 arch/mips/configs/generic/board-ocelot.config
>  create mode 100644 arch/mips/configs/ocelot_defconfig
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 8f4486c..984c09c 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -549,9 +549,6 @@ generic_defconfig:
>  # now that the boards have been converted to use the generic kernel they are
>  # wrappers around the generic rules above.
>  #
> -legacy_defconfigs		+= ocelot_defconfig
> -ocelot_defconfig-y		:= 32r2el_defconfig BOARDS=ocelot
> -
>  legacy_defconfigs		+= sead3_defconfig
>  sead3_defconfig-y		:= 32r2el_defconfig BOARDS=sead-3
>  
> diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
> deleted file mode 100644
> index 1134fbb..0000000
> --- a/arch/mips/configs/generic/board-ocelot.config
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -# require CONFIG_CPU_MIPS32_R2=y
> -
> -CONFIG_LEGACY_BOARD_OCELOT=y
> -CONFIG_FIT_IMAGE_FDT_OCELOT=y
> -
> -CONFIG_BRIDGE=y
> -CONFIG_GENERIC_PHY=y
> -
> -CONFIG_MTD=y
> -CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_M25P80=y
> -CONFIG_MTD_RAW_NAND=y
> -CONFIG_MTD_NAND_PLATFORM=y
> -CONFIG_MTD_SPI_NOR=y
> -CONFIG_MTD_UBI=y
> -
> -CONFIG_BLK_DEV_LOOP=y
> -CONFIG_BLK_DEV_RAM=y
> -
> -CONFIG_SERIAL_8250=y
> -CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_OF_PLATFORM=y
> -
> -CONFIG_NETDEVICES=y
> -CONFIG_NET_SWITCHDEV=y
> -CONFIG_NET_DSA=y
> -CONFIG_MSCC_OCELOT_SWITCH=y
> -CONFIG_MSCC_OCELOT_SWITCH_OCELOT=y
> -CONFIG_MDIO_MSCC_MIIM=y
> -CONFIG_MICROSEMI_PHY=y
> -
> -CONFIG_I2C=y
> -CONFIG_I2C_CHARDEV=y
> -CONFIG_I2C_MUX=y
> -CONFIG_I2C_DESIGNWARE_PLATFORM=y
> -
> -CONFIG_SPI=y
> -CONFIG_SPI_BITBANG=y
> -CONFIG_SPI_DESIGNWARE=y
> -CONFIG_SPI_DW_MMIO=y
> -CONFIG_SPI_SPIDEV=y
> -
> -CONFIG_PINCTRL_OCELOT=y
> -
> -CONFIG_GPIO_SYSFS=y
> -
> -CONFIG_POWER_RESET=y
> -CONFIG_POWER_RESET_OCELOT_RESET=y
> -
> -CONFIG_MAGIC_SYSRQ=y
> diff --git a/arch/mips/configs/ocelot_defconfig b/arch/mips/configs/ocelot_defconfig
> new file mode 100644
> index 0000000..016dffe
> --- /dev/null
> +++ b/arch/mips/configs/ocelot_defconfig
> @@ -0,0 +1,140 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_MEMCG=y
> +CONFIG_MEMCG_SWAP=y
> +CONFIG_BLK_CGROUP=y
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_RT_GROUP_SCHED=y
> +CONFIG_CGROUP_PIDS=y
> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_NAMESPACES=y
> +CONFIG_USER_NS=y
> +CONFIG_SCHED_AUTOGROUP=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_USERFAULTFD=y
> +CONFIG_EMBEDDED=y
> +# CONFIG_SLUB_DEBUG is not set
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_LEGACY_BOARD_OCELOT=y

Do you need to keep the legacy support, is this still used with redboot?

> +CONFIG_FIT_IMAGE_FDT_OCELOT=y
> +CONFIG_CPU_LITTLE_ENDIAN=y
> +CONFIG_CPU_MIPS32_R2=y
> +CONFIG_MIPS_CPS=y
> +CONFIG_HIGHMEM=y
> +CONFIG_NR_CPUS=16
> +CONFIG_MIPS_O32_FP64_SUPPORT=y
> +CONFIG_JUMP_LABEL=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_TRIM_UNUSED_KSYMS=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_NETFILTER=y
> +CONFIG_BRIDGE=y
> +CONFIG_BRIDGE_VLAN_FILTERING=y
> +CONFIG_NET_DSA=y
> +CONFIG_VLAN_8021Q=y
> +CONFIG_NET_SCHED=y
> +CONFIG_NET_SCH_INGRESS=y
> +CONFIG_NET_CLS_FLOWER=y
> +CONFIG_NET_CLS_MATCHALL=y
> +CONFIG_NET_CLS_ACT=y
> +CONFIG_NET_ACT_POLICE=y
> +CONFIG_NET_ACT_GACT=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_MTD=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_M25P80=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_MTD_NAND_PLATFORM=y
> +CONFIG_MTD_SPI_NOR=y
> +CONFIG_MTD_UBI=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_COUNT=2
> +CONFIG_BLK_DEV_RAM_SIZE=16000
> +CONFIG_SCSI=y
> +CONFIG_NETDEVICES=y
> +CONFIG_MSCC_OCELOT_SWITCH=y
> +CONFIG_MSCC_OCELOT_SWITCH_OCELOT=y
> +CONFIG_MDIO_MSCC_MIIM=y
> +CONFIG_MICROSEMI_PHY=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_HW_RANDOM=y
> +CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_DESIGNWARE_PLATFORM=y
> +CONFIG_SPI=y
> +CONFIG_SPI_BITBANG=y
> +CONFIG_SPI_DESIGNWARE=y
> +CONFIG_SPI_DW_MMIO=y
> +CONFIG_SPI_SPIDEV=y
> +CONFIG_PINCTRL_OCELOT=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_POWER_RESET=y
> +CONFIG_POWER_RESET_OCELOT_RESET=y
> +# CONFIG_HWMON is not set
> +CONFIG_HID_A4TECH=y
> +CONFIG_HID_APPLE=y
> +CONFIG_HID_BELKIN=y
> +CONFIG_HID_CHERRY=y
> +CONFIG_HID_CHICONY=y
> +CONFIG_HID_CYPRESS=y
> +CONFIG_HID_EZKEY=y
> +CONFIG_HID_KENSINGTON=y
> +CONFIG_HID_LOGITECH=y
> +CONFIG_HID_MICROSOFT=y
> +CONFIG_HID_MONTEREY=y
> +# CONFIG_MIPS_PLATFORM_DEVICES is not set
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_GENERIC_PHY=y
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_FS_ENCRYPTION=y
> +CONFIG_FANOTIFY=y
> +CONFIG_FUSE_FS=y
> +CONFIG_CUSE=y
> +CONFIG_OVERLAY_FS=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_SQUASHFS=y
> +CONFIG_SQUASHFS_XZ=y
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V3_ACL=y
> +CONFIG_NFS_V4=y
> +CONFIG_NFS_V4_1=y
> +CONFIG_NFS_V4_2=y
> +CONFIG_ROOT_NFS=y
> +# CONFIG_XZ_DEC_X86 is not set
> +# CONFIG_XZ_DEC_POWERPC is not set
> +# CONFIG_XZ_DEC_IA64 is not set
> +# CONFIG_XZ_DEC_ARM is not set
> +# CONFIG_XZ_DEC_ARMTHUMB is not set
> +# CONFIG_XZ_DEC_SPARC is not set
> +CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_DEBUG_INFO_REDUCED=y
> +CONFIG_DEBUG_FS=y
> +CONFIG_MAGIC_SYSRQ=y
> +# CONFIG_SCHED_DEBUG is not set
> +# CONFIG_FTRACE is not set
> +CONFIG_CMDLINE_BOOL=y
> +CONFIG_CMDLINE="earlycon"

I don't think earlycon works (while earlyprintk does).

> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
