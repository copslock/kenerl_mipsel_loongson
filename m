Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Mar 2015 15:23:23 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:57293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007821AbbCJOXVv7vSc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Mar 2015 15:23:21 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0MYoWQ-1XzrtR14tO-00VTMm; Tue, 10 Mar
 2015 15:22:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Aleksey Makarov <aleksey.makarov@auriga.com>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] SATA: OCTEON: support SATA on OCTEON platform
Date:   Tue, 10 Mar 2015 15:22:45 +0100
Message-ID: <2705826.IzKxg0MdBH@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1425993989-22770-1-git-send-email-aleksey.makarov@auriga.com>
References: <1425993989-22770-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:abVnXSvuSfUCUUQHvPOOE5jZEadoHj+R2sebw6TYT6ucX+ByZW7
 YcmfkjlwDpDmDyjxCN9ONcE04GAhBuW3qwrXnUV09o1Sg/nr+lS9tZmqtv1vT1GPQCzoBu5
 2EWxZhhQK+ZUAt8g5Zb0CxGI6yucbSGTlKxy+XHzyMmlUzYl8AcNkoIdv4TNNAkWcxBtcn1
 sz1RzQyGNp7H1i0V4hbIw==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tuesday 10 March 2015 16:26:26 Aleksey Makarov wrote:
> The OCTEON SATA controller is currently found on cn71XX devices.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>  .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  28 ++++
>  drivers/ata/Kconfig                                |   9 ++
>  drivers/ata/Makefile                               |   1 +
>  drivers/ata/ahci_platform.c                        |   1 +
>  drivers/ata/sata_octeon.c                          | 153 +++++++++++++++++++++
>  6 files changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>  create mode 100644 drivers/ata/sata_octeon.c
> 
> Version 3:
> https://lkml.kernel.org/g/<1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com>
> 
> Changes in v4:
> - The call to dma_coerce_mask_and_coherent() was removed as suggested by Arnd Bergmann
>   dma_mask and coherent_dma_mask are actually set in the ahci_platform_init_host()
>   (libahci_platform.c)

Actually I see now that this is a driver for a bus, not a device, so
you also need to put the dma-ranges property into this device and
its parent, otherwise the dma_set_mask in ahci_platform_init_host
will fail (at least once MIPS is fixed and starts honoring the
dma-ranges).

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

What is an uctl? Is that a standard bus device name?

This is also where you should set the dma-ranges for the bus.

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

Try to avoid bit fields, as you can see here, it gets awfully ugly if you
want to get endianess right, better just use #defines for the bits within
the u64 word.


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

The current version doesn't really do anything, other than set a single
register. Are you planning to extend this a lot in the future?

If not, just make this a derived sata driver with an extra set of
soc-specific registers to set up.

	Arnd
