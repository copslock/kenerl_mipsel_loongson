Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 11:11:50 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:40361 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007185AbbCFKLofOwkL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Mar 2015 11:11:44 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t26A6abG027749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Mar 2015 05:06:37 -0500
Received: from shalem.localdomain (vpn1-6-14.ams2.redhat.com [10.36.6.14])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t26A6VwR025993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 6 Mar 2015 05:06:33 -0500
Message-ID: <54F97C27.508@redhat.com>
Date:   Fri, 06 Mar 2015 11:06:31 +0100
From:   Hans de Goede <hdegoede@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Aleksey Makarov <aleksey.makarov@auriga.com>,
        linux-ide@vger.kernel.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] SATA: OCTEON: support SATA on OCTEON platform
References: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com>
In-Reply-To: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <hdegoede@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hdegoede@redhat.com
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

On 05-03-15 15:58, Aleksey Makarov wrote:
> The OCTEON SATA controller is currently found on cn71XX devices.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> ---
>
> Version 2:
> https://lkml.kernel.org/g/<1422038495-5204-1-git-send-email-aleksey.makarov@auriga.com>
>
> Changes in v3:
> - Rebased to v4.0-rc2
> - Cosmetic changes
>
> Changes in v2:
> - The driver was rewritten as a driver for the UCTL SATA controller glue.
>    It allowed to get rid of the most changes in ahci_platform.c
> - Documentation for the device tree bindings was fixed.
>
>   .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>   .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  28 ++++
>   drivers/ata/Kconfig                                |   9 ++
>   drivers/ata/Makefile                               |   1 +
>   drivers/ata/ahci_platform.c                        |   1 +
>   drivers/ata/sata_octeon.c                          | 157 +++++++++++++++++++++
>   6 files changed, 197 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>   create mode 100644 drivers/ata/sata_octeon.c
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index c2340ee..3d84dca 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -11,6 +11,7 @@ Required properties:
>   - compatible        : compatible string, one of:
>     - "allwinner,sun4i-a10-ahci"
>     - "hisilicon,hisi-ahci"
> +  - "cavium,octeon-7130-ahci"
>     - "ibm,476gtr-ahci"
>     - "marvell,armada-380-ahci"
>     - "snps,dwc-ahci"
> diff --git a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
> new file mode 100644
> index 0000000..59e86a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
> @@ -0,0 +1,28 @@
> +* UCTL SATA controller glue
> +
> +Properties:
> +- compatible: "cavium,octeon-7130-sata-uctl"
> +
> +  Compatibility with the cn7130 SOC.
> +
> +- reg: The base address of the UCTL register bank.
> +
> +- #address-cells, #size-cells, and ranges must be present and hold
> +	suitable values to map all child nodes.
> +
> +Example:
> +
> +	uctl@118006c000000 {
> +		compatible = "cavium,octeon-7130-sata-uctl";
> +		reg = <0x11800 0x6c000000 0x0 0x100>;
> +		ranges; /* Direct mapping */
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		sata: sata@16c0000000000 {
> +			compatible = "cavium,octeon-7130-ahci";
> +			reg = <0x16c00 0x00000000 0x0 0x200>;
> +			interrupt-parent = <&cibsata>;
> +			interrupts = <2 4>; /* Bit: 2, level */
> +		};
> +	};

Sorry for jumping into this discussion a bit late, but this nonsense
nesting of what clearly are 2 related but different hw blocks,
both living at completely different register addresses is unacceptable,
this is not a proper operating system dependent hw description as
devicetree is supposed to be. This is an ugly hack to ensure a
certain init ordering, and requiring manual instantiation of
the platform device for the nested dt-node.

NACK.

The proper solution for this would be to have a single sata node,
with 2 register ranges, the first one for the actual ahci block,
and the second range for the uctl glue, and then write your
own ahci_octeon.c platform driver (you can start with a copy of
ahci_platform.c) which can do the uctl poking in its probe function
before calling ahci_platform_get_resources,
ahci_platform_enable_resources and ahci_platform_init_host.

Minus the standard boilerplate ahci_platform.c is only 60 lines,
it is THAT small because we've put all the common ahci-platform
code into libahci_platform.c exactly so that it is trivial to
create new ahci-platform drivers for special cases like this,
so that we do not need to do these kind of ugly hacks.

Actually libahciplatform was specifically written to remove a couple
of very similar hacks with platform device drivers instantiating
more platform devices from the kernel ...

Regards,

Hans






> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 5f60155..55ad870 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -188,6 +188,15 @@ config SATA_SIL24
>
>   	  If unsure, say N.
>
> +config SATA_OCTEON
> +	tristate "Cavium Octeon Soc Serial ATA"
> +	depends on SATA_AHCI_PLATFORM && CAVIUM_OCTEON_SOC
> +	default y
> +	help
> +	  This option enables support for Cavium Octeon SoC Serial ATA.
> +
> +	  If unsure, say N.
> +
>   config ATA_SFF
>   	bool "ATA SFF support (for legacy IDE and PATA)"
>   	default y
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index ae41107..4a0e5e3 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o libahci.o libahci_platform.o
>   obj-$(CONFIG_AHCI_ST)		+= ahci_st.o libahci.o libahci_platform.o
>   obj-$(CONFIG_AHCI_TEGRA)	+= ahci_tegra.o libahci.o libahci_platform.o
>   obj-$(CONFIG_AHCI_XGENE)	+= ahci_xgene.o libahci.o libahci_platform.o
> +obj-$(CONFIG_SATA_OCTEON)	+= sata_octeon.o
>
>   # SFF w/ custom DMA
>   obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 78d6ae0..2c26cde 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -74,6 +74,7 @@ static const struct of_device_id ahci_of_match[] = {
>   	{ .compatible = "ibm,476gtr-ahci", },
>   	{ .compatible = "snps,dwc-ahci", },
>   	{ .compatible = "hisilicon,hisi-ahci", },
> +	{ .compatible = "cavium,octeon-7130-ahci", },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, ahci_of_match);
> diff --git a/drivers/ata/sata_octeon.c b/drivers/ata/sata_octeon.c
> new file mode 100644
> index 0000000..338ea86
> --- /dev/null
> +++ b/drivers/ata/sata_octeon.c
> @@ -0,0 +1,157 @@
> +/*
> + * SATA glue for Cavium Octeon III SOCs.
> + *
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2010-2015 Cavium Networks
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/octeon/octeon.h>
> +#include <asm/bitfield.h>
> +
> +/**
> + * cvmx_sata_uctl_shim_cfg
> + * from cvmx-sata-defs.h
> + *
> + * Accessible by: only when A_CLKDIV_EN
> + * Reset by: IOI reset (srst_n) or SATA_UCTL_CTL[SATA_UCTL_RST]
> + * This register allows configuration of various shim (UCTL) features.
> + * Fields XS_NCB_OOB_* are captured when there are no outstanding OOB errors
> + * indicated in INTSTAT and a new OOB error arrives.
> + * Fields XS_BAD_DMA_* are captured when there are no outstanding DMA errors
> + * indicated in INTSTAT and a new DMA error arrives.
> + */
> +union cvmx_sata_uctl_shim_cfg {
> +	uint64_t u64;
> +	struct cvmx_sata_uctl_shim_cfg_s {
> +	/*
> +	 * Read/write error log for out-of-bound UAHC register access.
> +	 * 0 = read, 1 = write.
> +	 */
> +	__BITFIELD_FIELD(uint64_t xs_ncb_oob_wrn               : 1,
> +	__BITFIELD_FIELD(uint64_t reserved_57_62               : 6,
> +	/*
> +	 * SRCID error log for out-of-bound UAHC register access.
> +	 * The IOI outbound SRCID for the OOB error.
> +	 */
> +	__BITFIELD_FIELD(uint64_t xs_ncb_oob_osrc              : 9,
> +	/*
> +	 * Read/write error log for bad DMA access from UAHC.
> +	 * 0 = read error log, 1 = write error log.
> +	 */
> +	__BITFIELD_FIELD(uint64_t xm_bad_dma_wrn               : 1,
> +	__BITFIELD_FIELD(uint64_t reserved_44_46               : 3,
> +	/*
> +	 * ErrType error log for bad DMA access from UAHC. Encodes the type of
> +	 * error encountered (error largest encoded value has priority).
> +	 * See SATA_UCTL_XM_BAD_DMA_TYPE_E.
> +	 */
> +	__BITFIELD_FIELD(uint64_t xm_bad_dma_type              : 4,
> +	__BITFIELD_FIELD(uint64_t reserved_13_39               : 27,
> +	/*
> +	 * Selects the IOI read command used by DMA accesses.
> +	 * See SATA_UCTL_DMA_READ_CMD_E.
> +	 */
> +	__BITFIELD_FIELD(uint64_t dma_read_cmd                 : 1,
> +	__BITFIELD_FIELD(uint64_t reserved_10_11               : 2,
> +	/*
> +	 * Selects the endian format for DMA accesses to the L2C.
> +	 * See SATA_UCTL_ENDIAN_MODE_E.
> +	 */
> +	__BITFIELD_FIELD(uint64_t dma_endian_mode              : 2,
> +	__BITFIELD_FIELD(uint64_t reserved_2_7                 : 6,
> +	/*
> +	 * Selects the endian format for IOI CSR accesses to the UAHC.
> +	 * Note that when UAHC CSRs are accessed via RSL, they are returned
> +	 * as big-endian. See SATA_UCTL_ENDIAN_MODE_E.
> +	 */
> +	__BITFIELD_FIELD(uint64_t csr_endian_mode              : 2,
> +		;))))))))))))
> +	} s;
> +};
> +
> +#define CVMX_SATA_UCTL_SHIM_CFG 0xE8
> +
> +static int ahci_octeon_probe(struct platform_device *pdev)
> +{
> +	union cvmx_sata_uctl_shim_cfg shim_cfg;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
> +		return -ENODEV;
> +	}
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	/* set-up endian mode */
> +	shim_cfg.u64 = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
> +#ifdef __BIG_ENDIAN
> +	shim_cfg.s.dma_endian_mode = 1;
> +	shim_cfg.s.csr_endian_mode = 1;
> +#else
> +	shim_cfg.s.dma_endian_mode = 0;
> +	shim_cfg.s.csr_endian_mode = 0;
> +#endif
> +	shim_cfg.s.dma_read_cmd = 1; /* No allocate L2C */
> +	cvmx_write_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG, shim_cfg.u64);
> +
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return ret;
> +
> +	if (!node) {
> +		dev_err(dev, "no device node, failed to add octeon sata\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_platform_populate(node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to add ahci-platform core\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ahci_octeon_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static const struct of_device_id octeon_ahci_match[] = {
> +	{ .compatible = "cavium,octeon-7130-sata-uctl", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, octeon_ahci_match);
> +
> +static struct platform_driver ahci_octeon_driver = {
> +	.probe          = ahci_octeon_probe,
> +	.remove         = ahci_octeon_remove,
> +	.driver         = {
> +		.name   = "octeon-ahci",
> +		.of_match_table = octeon_ahci_match,
> +	},
> +};
> +
> +module_platform_driver(ahci_octeon_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
> +MODULE_DESCRIPTION("Cavium Inc. sata config.");
>
