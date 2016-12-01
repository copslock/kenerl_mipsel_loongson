Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2016 07:27:00 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:59329 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992212AbcLAG0pjCO7c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Dec 2016 07:26:45 +0100
Subject: Re: [PATCH 2/2] lantiq: activate more drivers in default
 configuration
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
References: <20161130225808.11620-1-hauke@hauke-m.de>
 <20161130225808.11620-2-hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org
From:   John Crispin <john@phrozen.org>
Message-ID: <8264f937-2cfb-cf8c-d485-eb9d8ae95412@phrozen.org>
Date:   Thu, 1 Dec 2016 07:26:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161130225808.11620-2-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 30/11/2016 23:58, Hauke Mehrtens wrote:
> This activates the following functionalities:
> * SMP support (used on xRX200)
> * PCI support
> * NAND driver
> * PHY driver
> * UART
> * Watchdog
> * USB 2.0 controller
> 
> These driver are driving different IP cores found on the supported SoCs.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <john@phrozen.org>

> ---
>  arch/mips/configs/xway_defconfig | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
> index 0ccb642..4365108b 100644
> --- a/arch/mips/configs/xway_defconfig
> +++ b/arch/mips/configs/xway_defconfig
> @@ -1,7 +1,11 @@
>  CONFIG_LANTIQ=y
> +CONFIG_PCI_LANTIQ=y
>  CONFIG_XRX200_PHY_FW=y
>  CONFIG_CPU_MIPS32_R2=y
> +CONFIG_MIPS_MT_SMP=y
> +CONFIG_MIPS_VPE_LOADER=y
>  # CONFIG_COMPACTION is not set
> +CONFIG_NR_CPUS=2
>  CONFIG_HZ_100=y
>  # CONFIG_SECCOMP is not set
>  # CONFIG_LOCALVERSION_AUTO is not set
> @@ -22,8 +26,8 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=y
>  # CONFIG_IOSCHED_CFQ is not set
> +CONFIG_PCI=y
>  # CONFIG_COREDUMP is not set
> -# CONFIG_SUSPEND is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> @@ -81,6 +85,8 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_PHYSMAP_OF=y
>  CONFIG_MTD_LANTIQ=y
> +CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_XWAY=y
>  CONFIG_EEPROM_93CX6=m
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
> @@ -88,6 +94,7 @@ CONFIG_NETDEVICES=y
>  CONFIG_LANTIQ_ETOP=y
>  # CONFIG_NET_VENDOR_WIZNET is not set
>  CONFIG_PHYLIB=y
> +CONFIG_INTEL_XWAY_PHY=y
>  CONFIG_PPP=m
>  CONFIG_PPP_FILTER=y
>  CONFIG_PPP_MULTILINK=y
> @@ -108,17 +115,21 @@ CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_RUNTIME_UARTS=2
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_LANTIQ=y
>  CONFIG_SPI=y
>  CONFIG_GPIO_MM_LANTIQ=y
>  CONFIG_GPIO_STP_XWAY=y
>  # CONFIG_HWMON is not set
>  CONFIG_WATCHDOG=y
> +CONFIG_LANTIQ_WDT=y
>  # CONFIG_HID is not set
>  # CONFIG_USB_HID is not set
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_STORAGE_DEBUG=y
> +CONFIG_USB_DWC2=y
> +CONFIG_USB_DWC2_PCI=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_TRIGGERS=y
> 
