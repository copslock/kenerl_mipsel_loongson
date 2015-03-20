Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 14:03:28 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:39340 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008701AbbCTND0iO5EQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 14:03:26 +0100
Received: from [80.240.102.213] (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 20 Mar
 2015 16:03:21 +0300
Message-ID: <550C19CA.800@auriga.com>
Date:   Fri, 20 Mar 2015 15:59:54 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <linux-ide@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        "Vinita Gupta" <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Pawel Moll" <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4] SATA: OCTEON: support SATA on OCTEON platform
References: <1425993989-22770-1-git-send-email-aleksey.makarov@auriga.com> <2705826.IzKxg0MdBH@wuerfel>
In-Reply-To: <2705826.IzKxg0MdBH@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

On 03/10/2015 05:22 PM, Arnd Bergmann wrote:

[...]

>> diff --git a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> new file mode 100644
>> index 0000000..59e86a7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> @@ -0,0 +1,28 @@
>> +* UCTL SATA controller glue
>> +
>> +Properties:
>> +- compatible: "cavium,octeon-7130-sata-uctl"
>> +
>> +  Compatibility with the cn7130 SOC.
>> +
>> +- reg: The base address of the UCTL register bank.
>> +
>> +- #address-cells, #size-cells, and ranges must be present and hold
>> +	suitable values to map all child nodes.
>> +
>> +Example:
>> +
>> +	uctl@118006c000000 {
>> +		compatible = "cavium,octeon-7130-sata-uctl";
>> +		reg = <0x11800 0x6c000000 0x0 0x100>;
>> +		ranges; /* Direct mapping */
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
> 
> What is an uctl? Is that a standard bus device name?

I am going to add a short description of what UCTL is from docs here..

> This is also where you should set the dma-ranges for the bus.

... and mention dma-ranges in the next version of the patch.

>> +
>> +/**
>> + * cvmx_sata_uctl_shim_cfg
>> + * from cvmx-sata-defs.h
>> + *
>> + * Accessible by: only when A_CLKDIV_EN
>> + * Reset by: IOI reset (srst_n) or SATA_UCTL_CTL[SATA_UCTL_RST]
>> + * This register allows configuration of various shim (UCTL) features.
>> + * Fields XS_NCB_OOB_* are captured when there are no outstanding OOB errors
>> + * indicated in INTSTAT and a new OOB error arrives.
>> + * Fields XS_BAD_DMA_* are captured when there are no outstanding DMA errors
>> + * indicated in INTSTAT and a new DMA error arrives.
>> + */
>> +union cvmx_sata_uctl_shim_cfg {
>> +	uint64_t u64;
>> +	struct cvmx_sata_uctl_shim_cfg_s {
>> +	/*
>> +	 * Read/write error log for out-of-bound UAHC register access.
>> +	 * 0 = read, 1 = write.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t xs_ncb_oob_wrn               : 1,
>> +	__BITFIELD_FIELD(uint64_t reserved_57_62               : 6,
>> +	/*
>> +	 * SRCID error log for out-of-bound UAHC register access.
>> +	 * The IOI outbound SRCID for the OOB error.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t xs_ncb_oob_osrc              : 9,
>> +	/*
>> +	 * Read/write error log for bad DMA access from UAHC.
>> +	 * 0 = read error log, 1 = write error log.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t xm_bad_dma_wrn               : 1,
>> +	__BITFIELD_FIELD(uint64_t reserved_44_46               : 3,
>> +	/*
>> +	 * ErrType error log for bad DMA access from UAHC. Encodes the type of
>> +	 * error encountered (error largest encoded value has priority).
>> +	 * See SATA_UCTL_XM_BAD_DMA_TYPE_E.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t xm_bad_dma_type              : 4,
>> +	__BITFIELD_FIELD(uint64_t reserved_13_39               : 27,
>> +	/*
>> +	 * Selects the IOI read command used by DMA accesses.
>> +	 * See SATA_UCTL_DMA_READ_CMD_E.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t dma_read_cmd                 : 1,
>> +	__BITFIELD_FIELD(uint64_t reserved_10_11               : 2,
>> +	/*
>> +	 * Selects the endian format for DMA accesses to the L2C.
>> +	 * See SATA_UCTL_ENDIAN_MODE_E.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t dma_endian_mode              : 2,
>> +	__BITFIELD_FIELD(uint64_t reserved_2_7                 : 6,
>> +	/*
>> +	 * Selects the endian format for IOI CSR accesses to the UAHC.
>> +	 * Note that when UAHC CSRs are accessed via RSL, they are returned
>> +	 * as big-endian. See SATA_UCTL_ENDIAN_MODE_E.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t csr_endian_mode              : 2,
>> +		;))))))))))))
>> +	} s;
>> +};
> 
> Try to avoid bit fields, as you can see here, it gets awfully ugly if you
> want to get endianess right, better just use #defines for the bits within
> the u64 word.

I would prefer not to do that.  I do not think this is much better: 

#define DMA_ENDIAN_MODE  8  /* Selects the endian format for DMA accesses */
#define CSR_ENDIAN_MODE  0  /* Selects the endian format for DMA accesses */ 
#define DMA_READ_CMD    12  /* Do not put the cache block into the L2 cache */

#define SATA_UCTL_ENDIAN_MODE_E_BIG     1
#define SATA_UCTL_ENDIAN_MODE_E_LITTLE  0
#define SATA_UCTL_ENDIAN_MODE_E_MASK    3

	v = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
	v &= ~(SATA_UCTL_ENDIAN_MODE_E_MASK << DMA_ENDIAN_MODE);
	v &= ~(SATA_UCTL_ENDIAN_MODE_E_MASK << CSR_ENDIAN_MODE);
#ifdef __BIG_ENDIAN
	v |= SATA_UCTL_ENDIAN_MODE_E_BIG << DMA_ENDIAN_MODE;
	v |= SATA_UCTL_ENDIAN_MODE_E_BIG << CSR_ENDIAN_MODE;
#else
	v |= SATA_UCTL_ENDIAN_MODE_E_LITTLE << DMA_ENDIAN_MODE;
	v |= SATA_UCTL_ENDIAN_MODE_E_LITTLE << CSR_ENDIAN_MODE;
#endif
	v |= 1 << DMA_READ_CMD;
	cvmx_write_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG, shim_cfg.u64);

On the other hand, using __BITFIELD_FIELD seems to be a common practice for mips sources.
And this particular structure was generated from something by cavium so it is for free.

>> +#define CVMX_SATA_UCTL_SHIM_CFG 0xE8
>> +
>> +static int ahci_octeon_probe(struct platform_device *pdev)
>> +{
>> +	union cvmx_sata_uctl_shim_cfg shim_cfg;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = dev->of_node;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	int ret;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	/* set-up endian mode */
>> +	shim_cfg.u64 = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
>> +#ifdef __BIG_ENDIAN
>> +	shim_cfg.s.dma_endian_mode = 1;
>> +	shim_cfg.s.csr_endian_mode = 1;
>> +#else
>> +	shim_cfg.s.dma_endian_mode = 0;
>> +	shim_cfg.s.csr_endian_mode = 0;
>> +#endif
>> +	shim_cfg.s.dma_read_cmd = 1; /* No allocate L2C */
>> +	cvmx_write_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG, shim_cfg.u64);
>> +
>> +	if (!node) {
>> +		dev_err(dev, "no device node, failed to add octeon sata\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = of_platform_populate(node, NULL, NULL, dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to add ahci-platform core\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> The current version doesn't really do anything, other than set a single
> register. Are you planning to extend this a lot in the future?

No, we are not.

> If not, just make this a derived sata driver with an extra set of
> soc-specific registers to set up.

This is not an option, because the device tree ABI is deployed and fixed,
and deriving sata driver does not fit it well.

Thanks
Aleksey Makarov
