Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 02:04:05 +0200 (CEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:33374 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993523AbcHMAD5eAHCf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 02:03:57 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-167-73-nat.elisa-mobile.fi [85.76.167.73])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 49482699CC;
        Sat, 13 Aug 2016 03:03:56 +0300 (EEST)
Date:   Sat, 13 Aug 2016 03:03:55 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: OCTEON: Changes to support readq()/writeq() usage.
Message-ID: <20160813000355.GD10648@raspberrypi.musicnaut.iki.fi>
References: <5780652D.2030604@cavium.com>
 <20160812213801.GC10648@raspberrypi.musicnaut.iki.fi>
 <57AE4F63.4010506@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57AE4F63.4010506@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Fri, Aug 12, 2016 at 03:36:19PM -0700, David Daney wrote:
> On 08/12/2016 02:38 PM, Aaro Koskinen wrote:
> >On Fri, Jul 08, 2016 at 09:45:01PM -0500, Steven J. Hill wrote:
> >>Update OCTEON port mangling code to support readq() and
> >>writeq() functions to allow driver code to be more portable.
> >>Updates also for word and long function pairs. We also
> >>remove SWAP_IO_SPACE for OCTEON platforms as the function
> >>macros are redundant with the new mangling code.
> >>
> >>Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> >>Acked-by: David Daney <david.daney@cavium.com>
> >
> >[...]
> >
> >>+static inline bool __should_swizzle_bits(volatile void *a)
> >>+{
> >>+	extern const bool octeon_should_swizzle_table[];
> >>+
> >>+	unsigned long did = ((unsigned long)a >> 40) & 0xff;
> >>+	return octeon_should_swizzle_table[did];
> >>+}
> >
> >v4.8-rc1 OCTEON build is now broken with GCC 6.1 when support for 32-bit
> >ABIs is enabled:
> 
> I don't get it.  The kernel is always 64-bit, so unsigned long will have a
> width of 64.

VDSO code is built with -mabi=32 when CONFIG_MIPS32_O32 is enabled
(see arch/mips/vdso/Makefile).

> What kernel config are you using?

See below. AFAIK, you cannot disable VDSO?

...

CONFIG_CAVIUM_OCTEON_SOC=y
CONFIG_CAVIUM_CN63XXP1=y
CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=2
# CONFIG_COMPACTION is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_HZ_100=y
CONFIG_MIPS_ELF_APPENDED_DTB=y
CONFIG_LOCALVERSION="-octeon"
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_SCHED_AUTOGROUP=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_EMBEDDED=y
# CONFIG_PERF_EVENTS is not set
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_PCI=y
CONFIG_PCI_MSI=y
CONFIG_MIPS32_O32=y
CONFIG_MIPS32_N32=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
CONFIG_CFG80211=y
CONFIG_MAC80211=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
# CONFIG_FW_LOADER is not set
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_SLRAM=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_NETDEVICES=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_TOSHIBA is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_AT803X_PHY=m
CONFIG_BROADCOM_PHY=m
CONFIG_PPP=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_ASYNC=y
# CONFIG_ATH9K_BTCOEX_SUPPORT is not set
CONFIG_ATH9K=y
# CONFIG_ATH9K_PCOEM is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_INPUT is not set
# CONFIG_SERIO is not set
# CONFIG_VT is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_RUNTIME_UARTS=2
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_HW_RANDOM is not set
CONFIG_I2C=y
CONFIG_I2C_OCTEON=y
CONFIG_SPI=y
CONFIG_SPI_OCTEON=y
CONFIG_GPIO_SYSFS=y
# CONFIG_HWMON is not set
CONFIG_WATCHDOG=y
# CONFIG_VGA_ARB is not set
CONFIG_USB=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_ACM=y
CONFIG_USB_STORAGE=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_OPTION=y
CONFIG_LEDS_GPIO=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_STAGING=y
CONFIG_OCTEON_ETHERNET=y
CONFIG_OCTEON_USB=y
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_EXT4_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_KCORE=y
CONFIG_TMPFS=y
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_INFO=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOCKUP_DETECTOR=y
# CONFIG_SCHED_DEBUG is not set
# CONFIG_FTRACE is not set
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_MD5_OCTEON=y
# CONFIG_CRYPTO_HW is not set

A.
