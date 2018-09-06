Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 23:26:27 +0200 (CEST)
Received: from mail-qk1-x742.google.com ([IPv6:2607:f8b0:4864:20::742]:41082
        "EHLO mail-qk1-x742.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994648AbeIFV0WEJwfw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 23:26:22 +0200
Received: by mail-qk1-x742.google.com with SMTP id h138-v6so8381210qke.8;
        Thu, 06 Sep 2018 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pkHd1QVrja72x8i2r6nyawI8JYSsxZn8FWEVKubLqL4=;
        b=Dbc7evkMbmNwz8XP6BE1epQLqboRXkkds8CiMuZLyHiILGsmvLLVLPBGeW8gb4JopH
         fF1xcloNobJQk7rzH67yEvV5QDAed5G0CgGxQjIkNJUpqjuplYDYka8AsUxjzwK2mkRx
         JTfUaKluaYH8VFXEvSJ8SISusGM8z9ISe56MgSNmei3iv5JRfI7HnUR3+fFXMzXUx5+E
         VAX871moE3l/u708VEIzgBBu1QJC2FDNPguRfd6b/uhMqJYZan2MBstB7X9acCncKTGP
         BzYbX9I8xJ21hSQhKdAWa77TNKPBYWQSHRxtquFjbCwN2SGhlXSFY0f6uhMXNN12bpJZ
         ubIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pkHd1QVrja72x8i2r6nyawI8JYSsxZn8FWEVKubLqL4=;
        b=q9i+MjShMU0mEwF2TPXI/we6m7pW79L/jbK5E9YVU9/fShprf+utj3eKG3mecV0Drn
         6sxzKwv5aqy0D4KMgDb+lwNda0I24MWIYqn7ORn1E4i6tc41DM/zZ2AhSTtfhCELBSWI
         4YBIovYWaoO9DPDHENQ9aFz41uDV5IZGBvaqM+InJ2P1p+tSzyfh+Lx7Ej25j0k+xSoM
         DiI4UNbW/PQ0UvkSfPtHjgFrttWZ4Up8R8kcVK3sgH5eJTIxX9EsyrQrE5QvFn8FSdyM
         +Jx+kHp3LqBW7CYJh6u54Zkz/s3otPw7XAfooaEA7KR+lzUV1l0dlSvYzxAEjTE+f89+
         HElA==
X-Gm-Message-State: APzg51Ba8v+7DIA+w3nVw9wBJBxDSbpyi3AGSJn+rPHu+2YJPU3v3857
        bmJEucDcs36hscb+dxYdQkc=
X-Google-Smtp-Source: ANB0VdZSqOC7Q1hzJTrGQt2QhYGqPagVqPH4nj0enz2yRfmrfPDAl+sWSmKx2CSM4MnylO0/yd0nFQ==
X-Received: by 2002:a37:e118:: with SMTP id c24-v6mr3600512qkm.68.1536269174339;
        Thu, 06 Sep 2018 14:26:14 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v31-v6sm176633qta.96.2018.09.06.14.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:26:13 -0700 (PDT)
Subject: Re: [PATCH v5 12/12] ARM: add dma remap for BrcmSTB PCIe
To:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stefan Agner <stefan@agner.ch>, Eric Anholt <eric@anholt.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Dirk Hohndel (VMware)" <dirk@hohndel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-13-git-send-email-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c33a5065-1bf3-e6aa-2183-826c945bfe8e@gmail.com>
Date:   Thu, 6 Sep 2018 14:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536266581-7308-13-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 09/06/2018 01:43 PM, Jim Quinlan wrote:
> The BrcmSTB PCIe controller needs to remap DMA accesses to it because
> of the requirements of its interface with the SOC memory controllers.
> In the ARM64 and MIPs architectures, this is accomplished by
> CONFIG_ARCH_HAS_PHYS_TO_DMA=y and then defining the functions
> __dma_to_phys() and __phys_to_dma() accordingly.
> 
> Doing so for the ARM architecture is not as easy as ARM64 and MIPS;
> the two functions are already defined as static inline functions.
> Howevery, the behavior of these functions may be changed by redefining
> the sub-functions that these two functions invoke.

So we talked extensively about this before privately but I think we need
to have a better way rather than depart from MULTI_V7 because that will
really prevent us from getting any build coverage if anything, and,
there could conceptually be another ARMv7 platform that has the same
requirements.

Your prior submissions were calling set_dma_ops() for the children
devices created by the PCIe root complex driver during enumeration which
had the nice advantage of scaling well across platforms, also came with
no cost to the other devices (e.g: non-PCIe), and was a nice
"subscriber/provider" model in that, if, and only if you had a PCIe root
complex, would you be overriding a given device's dma_ops. AFAIR
Christoph did not like that, so here we are now.

So maybe a solution somewhere in between is to allow the ARM machine to
provide custom pfn_to_dma(), dma_to_pfn() and whatnot, and those, can
potentially be resolved via the PCIe root complex driver through
explicit call? I am thinking about something like this, not that I think
this is any better than overriding a given devices' dma_ops, but maybe
that will fly...:

diff --git a/arch/arm/include/asm/dma-mapping.h
b/arch/arm/include/asm/dma-mapping.h
index 8436f6ade57d..507d3060c899 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -31,8 +31,15 @@ static inline const struct dma_map_ops
*get_arch_dma_ops(struct bus_type *bus)
  * addresses. They must not be used by drivers.
  */
 #ifndef __arch_pfn_to_dma
+dma_addr_t (*mach_pfn_to_dma)(struct device *dev, unsigned long pfn);
+unsigned long (*mach_dma_to_pfn)(struct device *dev, dma_addr_t addr);
+void *(*mach_dma_to_virt)(struct device *dev, dma_addr_t addr);
+dma_addr_t *(*mach_virt_to_dma)(struct device *dev, void *addr);
+
 static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
+       if (mach_pfn_to_dma)
+               return (dma_addr_t)mach_pfn_to_dma(dev, pfn);
        if (dev)
                pfn -= dev->dma_pfn_offset;
        return (dma_addr_t)__pfn_to_bus(pfn);
@@ -42,6 +49,8 @@ static inline unsigned long dma_to_pfn(struct device
*dev, dma_addr_t addr)
 {
        unsigned long pfn = __bus_to_pfn(addr);

+       if (mach_dma_to_pfn)
+               return mach_dma_to_pfn(dev, addr);
        if (dev)
                pfn += dev->dma_pfn_offset;

@@ -50,6 +59,9 @@ static inline unsigned long dma_to_pfn(struct device
*dev, dma_addr_t addr)

 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
+       if (mach_dma_to_virt)
+               return mach_dma_to_virt(dev, addr);
+
        if (dev) {
                unsigned long pfn = dma_to_pfn(dev, addr);

@@ -61,6 +73,8 @@ static inline void *dma_to_virt(struct device *dev,
dma_addr_t addr)

 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
+       if (mach_virt_to_dma)
+               mach_virt_to_dma(dev, addr);
        if (dev)
                return pfn_to_dma(dev, virt_to_pfn(addr));

diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/mach-bcm/brcmstb.c
index 5f127d5f1045..d78a892604c0 100644
--- a/arch/arm/mach-bcm/brcmstb.c
+++ b/arch/arm/mach-bcm/brcmstb.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
+#include <linux/dma-mapping.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +40,16 @@ static void __init brcmstb_init_irq(void)
        irqchip_init();
 }

+static void __init brcmstb_init_late(void)
+{
+#if IS_ENABLED(CONFIG_PCIE_BRCMSTB)
+       mach_pfn_to_dma = brcm_phys_to_dma;
+       mach_dma_to_pfn = brcm_dma_to_phys;
+       mach_dma_to_virt = brcm_dma_to_virt;
+       mach_virt_to_dma = brcm_virt_to_dma;
+#endif
+}
+
 static const char *const brcmstb_match[] __initconst = {
        "brcm,bcm7445",
        "brcm,brcmstb",
@@ -48,4 +59,5 @@ static const char *const brcmstb_match[] __initconst = {
 DT_MACHINE_START(BRCMSTB, "Broadcom STB (Flattened Device Tree)")
        .dt_compat      = brcmstb_match,
        .init_irq       = brcmstb_init_irq,
+       .init_late      = brcmstb_init_late,
 MACHINE_END




> 	__arch_pfn_to_dma()
> 	__arch_dma_to_pfn()
> 	__arch_dma_to_virt()
> 	__arch_virt_to_dma()
> 
> as these are the functions invoked by __dma_to_phys() and
> __phys_to_dma().  Unfortunately, the only apparent approach to do this
> is to declare and define the four sub-functions in
> arch/arm/mach-bcm/include/mach/memory.h, and in doing so we must move
> out of ARCH_MULTIPLATFORM and create brcmstb_defconfig, as we were
> previously using multi_v7_defconfig.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  arch/arm/Kconfig                            |  33 +++++
>  arch/arm/configs/brcmstb_defconfig          | 204 ++++++++++++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig         |   3 -
>  arch/arm/mach-bcm/Kconfig                   |  21 +--
>  arch/arm/mach-bcm/Makefile.boot             |   0
>  arch/arm/mach-bcm/include/mach/irqs.h       |   3 +
>  arch/arm/mach-bcm/include/mach/memory.h     |  47 +++++++
>  arch/arm/mach-bcm/include/mach/uncompress.h |   8 ++
>  8 files changed, 296 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/configs/brcmstb_defconfig
>  create mode 100644 arch/arm/mach-bcm/Makefile.boot
>  create mode 100644 arch/arm/mach-bcm/include/mach/irqs.h
>  create mode 100644 arch/arm/mach-bcm/include/mach/memory.h
>  create mode 100644 arch/arm/mach-bcm/include/mach/uncompress.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a..913765b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -637,6 +637,39 @@ config ARCH_OMAP1
>  	help
>  	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
>  
> +config ARCH_BRCMSTB
> +	bool "Broadcom BCM7XXX based boards"
> +	select ARM_HAS_SG_CHAIN
> +	select ARM_PATCH_PHYS_VIRT
> +	select TIMER_OF
> +	select COMMON_CLK
> +	select GENERIC_CLOCKEVENTS
> +	select MULTI_IRQ_HANDLER
> +	select MIGHT_HAVE_PCI
> +	select PCI_DOMAINS if PCI
> +	select USE_OF
> +
> +	select CPU_V7
> +	select ARCH_BCM
> +	select HAVE_SMP
> +	select AUTO_ZRELADDR
> +	select ARM_GIC
> +	select ARM_GIC_V3
> +	select HAVE_ARM_ARCH_TIMER
> +	select SPARSE_IRQ
> +	select BRCMSTB_L2_IRQ
> +	select BCM7120_L2_IRQ
> +	select ARCH_HAS_HOLES_MEMORYMODEL
> +	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
> +	select ZONE_DMA if ARM_LPAE
> +	select NEED_MACH_MEMORY_H
> +	help
> +	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
> +	  chipset.
> +
> +	  This enables support for Broadcom ARM-based set-top box chipsets,
> +	  including the 7445 family of chips.
> +
>  endchoice
>  
>  menu "Multiple platform selection"
> diff --git a/arch/arm/configs/brcmstb_defconfig b/arch/arm/configs/brcmstb_defconfig
> new file mode 100644
> index 0000000..572fcf32
> --- /dev/null
> +++ b/arch/arm/configs/brcmstb_defconfig
> @@ -0,0 +1,204 @@
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_IRQ_TIME_ACCOUNTING=y
> +CONFIG_LOG_BUF_SHIFT=16
> +CONFIG_CGROUPS=y
> +CONFIG_RELAY=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_INITRAMFS_SOURCE="romfs"
> +CONFIG_EMBEDDED=y
> +CONFIG_PERF_EVENTS=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_FORCE_LOAD=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_MODVERSIONS=y
> +CONFIG_PARTITION_ADVANCED=y
> +CONFIG_ARCH_BRCMSTB=y
> +CONFIG_ARM_LPAE=y
> +CONFIG_ARM_THUMBEE=y
> +CONFIG_ARM_ERRATA_430973=y
> +CONFIG_ARM_ERRATA_720789=y
> +CONFIG_ARM_ERRATA_754322=y
> +CONFIG_ARM_ERRATA_754327=y
> +CONFIG_ARM_ERRATA_764369=y
> +CONFIG_ARM_ERRATA_775420=y
> +CONFIG_ARM_ERRATA_798181=y
> +CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
> +CONFIG_PCI_MSI=y
> +CONFIG_SMP=y
> +CONFIG_MCPM=y
> +CONFIG_NR_CPUS=16
> +CONFIG_ARM_PSCI=y
> +CONFIG_HZ_1000=y
> +CONFIG_HIGHMEM=y
> +CONFIG_CMA=y
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_EFI=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> +CONFIG_CPU_IDLE=y
> +CONFIG_VFP=y
> +CONFIG_PM_DEBUG=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_MULTICAST=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +CONFIG_IP_PNP_RARP=y
> +CONFIG_IP_MROUTE=y
> +CONFIG_IP_PIMSM_V1=y
> +CONFIG_IP_PIMSM_V2=y
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +CONFIG_INET_UDP_DIAG=y
> +CONFIG_TCP_CONG_ADVANCED=y
> +CONFIG_TCP_CONG_BIC=y
> +# CONFIG_TCP_CONG_WESTWOOD is not set
> +# CONFIG_TCP_CONG_HTCP is not set
> +# CONFIG_IPV6 is not set
> +CONFIG_BRIDGE=y
> +CONFIG_NET_DSA=y
> +CONFIG_CFG80211=y
> +CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_DMA_CMA=y
> +CONFIG_CMA_ALIGNMENT=9
> +CONFIG_MTD=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_CFI=y
> +CONFIG_MTD_JEDECPROBE=y
> +CONFIG_MTD_CFI_INTELEXT=y
> +CONFIG_MTD_CFI_AMDSTD=y
> +CONFIG_MTD_CFI_STAA=y
> +CONFIG_MTD_ROM=y
> +CONFIG_MTD_ABSENT=y
> +CONFIG_MTD_PHYSMAP_OF=y
> +CONFIG_MTD_M25P80=y
> +CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_BRCMNAND=y
> +CONFIG_MTD_SPI_NOR=y
> +# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
> +CONFIG_MTD_UBI=y
> +CONFIG_MTD_UBI_GLUEBI=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_SIZE=8192
> +CONFIG_EEPROM_93CX6=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_BLK_DEV_SR=y
> +CONFIG_CHR_DEV_SG=y
> +CONFIG_ATA=y
> +CONFIG_SATA_AHCI_PLATFORM=y
> +CONFIG_AHCI_BRCM=y
> +CONFIG_NETDEVICES=y
> +CONFIG_NET_DSA_BCM_SF2=y
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_CADENCE is not set
> +CONFIG_BCMGENET=y
> +CONFIG_SYSTEMPORT=y
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +# CONFIG_NET_VENDOR_MELLANOX is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_MICROCHIP is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +# CONFIG_NET_VENDOR_STMICRO is not set
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
> +CONFIG_USB_PEGASUS=y
> +CONFIG_USB_USBNET=y
> +# CONFIG_USB_NET_NET1080 is not set
> +# CONFIG_USB_NET_CDC_SUBSET is not set
> +# CONFIG_USB_NET_ZAURUS is not set
> +CONFIG_INPUT_EVDEV=y
> +CONFIG_MOUSE_PS2_ELANTECH=y
> +CONFIG_INPUT_MISC=y
> +CONFIG_INPUT_UINPUT=y
> +# CONFIG_SERIO_SERPORT is not set
> +CONFIG_VT_HW_CONSOLE_BINDING=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_HW_RANDOM=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_SPI=y
> +CONFIG_SPI_BITBANG=y
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_POWER_RESET=y
> +# CONFIG_HWMON is not set
> +CONFIG_MFD_SYSCON=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_USB_SUPPORT=y
> +CONFIG_USB_GSPCA=y
> +CONFIG_DRM=y
> +CONFIG_SOUND=m
> +CONFIG_SND=m
> +CONFIG_SND_SOC=m
> +CONFIG_USB=y
> +CONFIG_USB_MON=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_MASS_STORAGE=y
> +CONFIG_MMC=y
> +CONFIG_MMC_BLOCK_MINORS=16
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_RTC_CLASS=y
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_IIO=y
> +CONFIG_INA2XX_ADC=y
> +CONFIG_RESET_CONTROLLER=y
> +CONFIG_PHY_BRCM_SATA=y
> +CONFIG_EXT4_FS=y
> +CONFIG_JBD2_DEBUG=y
> +CONFIG_FUSE_FS=y
> +CONFIG_CUSE=y
> +CONFIG_ISO9660_FS=y
> +CONFIG_JOLIET=y
> +CONFIG_ZISOFS=y
> +CONFIG_UDF_FS=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_JFFS2_FS=y
> +CONFIG_UBIFS_FS=y
> +CONFIG_CRAMFS=y
> +CONFIG_SQUASHFS=y
> +CONFIG_SQUASHFS_LZO=y
> +CONFIG_SQUASHFS_XZ=y
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V3_ACL=y
> +CONFIG_NFS_V4=y
> +CONFIG_NFS_V4_1=y
> +CONFIG_NFS_V4_2=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_DEBUG_INFO_REDUCED=y
> +CONFIG_MAGIC_SYSRQ=y
> +# CONFIG_CRYPTO_HW is not set
> +CONFIG_CRC_CCITT=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index fc33444..33c91f8 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -17,7 +17,6 @@ CONFIG_ARCH_AT91=y
>  CONFIG_SOC_SAMA5D2=y
>  CONFIG_SOC_SAMA5D3=y
>  CONFIG_SOC_SAMA5D4=y
> -CONFIG_ARCH_BCM=y
>  CONFIG_ARCH_BCM_CYGNUS=y
>  CONFIG_ARCH_BCM_HR2=y
>  CONFIG_ARCH_BCM_NSP=y
> @@ -26,7 +25,6 @@ CONFIG_ARCH_BCM_281XX=y
>  CONFIG_ARCH_BCM_21664=y
>  CONFIG_ARCH_BCM2835=y
>  CONFIG_ARCH_BCM_63XX=y
> -CONFIG_ARCH_BRCMSTB=y
>  CONFIG_ARCH_BERLIN=y
>  CONFIG_MACH_BERLIN_BG2=y
>  CONFIG_MACH_BERLIN_BG2CD=y
> @@ -229,7 +227,6 @@ CONFIG_B53_MMAP_DRIVER=m
>  CONFIG_B53_SRAB_DRIVER=m
>  CONFIG_NET_DSA_BCM_SF2=m
>  CONFIG_SUN4I_EMAC=y
> -CONFIG_BCMGENET=m
>  CONFIG_BGMAC_BCMA=y
>  CONFIG_SYSTEMPORT=m
>  CONFIG_MACB=y
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 25aac6e..2c3ad42 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  menuconfig ARCH_BCM
>  	bool "Broadcom SoC Support"
> -	depends on ARCH_MULTI_V6_V7
> +	depends on ARCH_BRCMSTB
>  	help
>  	  This enables support for Broadcom ARM based SoC chips
>  
> @@ -203,23 +203,4 @@ config ARCH_BCM_63XX
>  	  It currently supports the 'BCM63XX' ARM-based family, which includes
>  	  the BCM63138 variant.
>  
> -config ARCH_BRCMSTB
> -	bool "Broadcom BCM7XXX based boards"
> -	depends on ARCH_MULTI_V7
> -	select ARM_GIC
> -	select ARM_ERRATA_798181 if SMP
> -	select HAVE_ARM_ARCH_TIMER
> -	select BRCMSTB_L2_IRQ
> -	select BCM7120_L2_IRQ
> -	select ARCH_HAS_HOLES_MEMORYMODEL
> -	select ZONE_DMA if ARM_LPAE
> -	select SOC_BRCMSTB
> -	select SOC_BUS
> -	help
> -	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
> -	  chipset.
> -
> -	  This enables support for Broadcom ARM-based set-top box chipsets,
> -	  including the 7445 family of chips.
> -
>  endif
> diff --git a/arch/arm/mach-bcm/Makefile.boot b/arch/arm/mach-bcm/Makefile.boot
> new file mode 100644
> index 0000000..e69de29
> diff --git a/arch/arm/mach-bcm/include/mach/irqs.h b/arch/arm/mach-bcm/include/mach/irqs.h
> new file mode 100644
> index 0000000..f1f3f22
> --- /dev/null
> +++ b/arch/arm/mach-bcm/include/mach/irqs.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define NR_IRQS NR_IRQS_LEGACY
> diff --git a/arch/arm/mach-bcm/include/mach/memory.h b/arch/arm/mach-bcm/include/mach/memory.h
> new file mode 100644
> index 0000000..a90a216
> --- /dev/null
> +++ b/arch/arm/mach-bcm/include/mach/memory.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_ARCH_MEMORY_H__
> +#define __ASM_ARCH_MEMORY_H__
> +#ifndef __ASSEMBLY__
> +
> +struct device;
> +
> +#include <soc/brcmstb/common.h>
> +
> +#ifdef CONFIG_PCIE_BRCMSTB
> +#define __arch_pfn_to_dma(dev, pfn)					\
> +	({								\
> +		if (dev)						\
> +			pfn -= dev->dma_pfn_offset;			\
> +		(dma_addr_t)brcm_phys_to_dma(dev, __pfn_to_phys(pfn));	\
> +	})
> +
> +#define  __arch_dma_to_pfn(dev, addr)					\
> +	({								\
> +		unsigned long pfn = __phys_to_pfn(brcm_dma_to_phys(dev, addr));\
> +		if (dev)						\
> +			pfn += dev->dma_pfn_offset;			\
> +		pfn;							\
> +	})
> +
> +#define __arch_dma_to_virt(dev, addr)					\
> +	({								\
> +		void *v;						\
> +		if (dev) {						\
> +			unsigned long pfn = dma_to_pfn(dev, addr);	\
> +			v = phys_to_virt(__pfn_to_phys(pfn));		\
> +		} else {						\
> +			v = (void *)__bus_to_virt((unsigned long)addr);	\
> +		}							\
> +		v;							\
> +	})
> +
> +#define __arch_virt_to_dma(dev, addr)					\
> +	({								\
> +		(dev) ? pfn_to_dma(dev, virt_to_pfn(addr))		\
> +		      : (dma_addr_t)__virt_to_bus((unsigned long)(addr));\
> +	})
> +
> +#endif /* CONFIG_PCIE_BRCMSTB */
> +#endif /* __ASSEMBLY__ */
> +#endif /* __ASM_ARCH_MEMORY_H__ */
> diff --git a/arch/arm/mach-bcm/include/mach/uncompress.h b/arch/arm/mach-bcm/include/mach/uncompress.h
> new file mode 100644
> index 0000000..b297333
> --- /dev/null
> +++ b/arch/arm/mach-bcm/include/mach/uncompress.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifdef CONFIG_DEBUG_UNCOMPRESS
> +void putc(int c);
> +#else
> +static inline void putc(int c) {}
> +#endif
> +static inline void flush(void) {}
> +static inline void arch_decomp_setup(void) {}
> 


-- 
Florian
