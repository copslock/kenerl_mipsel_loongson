Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 11:07:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57792 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992111AbdBNKHN7duTh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 11:07:13 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3A3A741F8EB7;
        Tue, 14 Feb 2017 11:11:05 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Feb 2017 11:11:05 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Feb 2017 11:11:05 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 98D975C0F9BD9;
        Tue, 14 Feb 2017 10:07:05 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Feb
 2017 10:07:07 +0000
Date:   Tue, 14 Feb 2017 10:07:07 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: OCTEON: Platform support for OCTEON III USB
 controller.
Message-ID: <20170214100707.GP24226@jhogan-linux.le.imgtec.org>
References: <de5a465e-9218-5288-c643-d0df0792baf5@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zxEKvxCKojqA/Afl"
Content-Disposition: inline
In-Reply-To: <de5a465e-9218-5288-c643-d0df0792baf5@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--zxEKvxCKojqA/Afl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 01:02:28AM -0600, Steven J. Hill wrote:
> Add all the necessary platform code to initialize the dwc3
> USB host controller. This code initializes the clocks and
> performs a reset on the USB core and PHYs. The driver code
> in 'drivers/usb/dwc3' is where the real driver lives.
>=20
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Applied

Thanks
James

>=20
> ---
> v2:
> - Removed unused typedefs.
> ---
>  arch/mips/cavium-octeon/Makefile              |   1 +
>  arch/mips/cavium-octeon/octeon-platform.c     |   1 +
>  arch/mips/cavium-octeon/octeon-usb.c          | 552 ++++++++++++++++++++=
++++++
>  arch/mips/include/asm/octeon/cvmx-gpio-defs.h |   8 +-
>  4 files changed, 560 insertions(+), 2 deletions(-)
>  create mode 100644 arch/mips/cavium-octeon/octeon-usb.c
>=20
> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/M=
akefile
> index 2a59265..a3d6ad8 100644
> --- a/arch/mips/cavium-octeon/Makefile
> +++ b/arch/mips/cavium-octeon/Makefile
> @@ -18,3 +18,4 @@ obj-y +=3D crypto/
>  obj-$(CONFIG_MTD)		      +=3D flash_setup.o
>  obj-$(CONFIG_SMP)		      +=3D smp.o
>  obj-$(CONFIG_OCTEON_ILM)	      +=3D oct_ilm.o
> +obj-$(CONFIG_USB)		+=3D octeon-usb.o
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium=
-octeon/octeon-platform.c
> index 37a932d..16083cf 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -448,6 +448,7 @@ static int __init octeon_ohci_device_init(void)
>  	{ .compatible =3D "cavium,octeon-3860-bootbus", },
>  	{ .compatible =3D "cavium,mdio-mux", },
>  	{ .compatible =3D "gpio-leds", },
> +	{ .compatible =3D "cavium,octeon-7130-usb-uctl", },
>  	{},
>  };
>=20
> diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octe=
on/octeon-usb.c
> new file mode 100644
> index 0000000..542be1c
> --- /dev/null
> +++ b/arch/mips/cavium-octeon/octeon-usb.c
> @@ -0,0 +1,552 @@
> +/*
> + * XHCI HCD glue for Cavium Octeon III SOCs.
> + *
> + * Copyright (C) 2010-2017 Cavium Networks
> + *
> + * This file is subject to the terms and conditions of the GNU General P=
ublic
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-gpio-defs.h>
> +
> +/* USB Control Register */
> +union cvm_usbdrd_uctl_ctl {
> +	uint64_t u64;
> +	struct cvm_usbdrd_uctl_ctl_s {
> +	/* 1 =3D BIST and set all USB RAMs to 0x0, 0 =3D BIST */
> +	__BITFIELD_FIELD(uint64_t clear_bist:1,
> +	/* 1 =3D Start BIST and cleared by hardware */
> +	__BITFIELD_FIELD(uint64_t start_bist:1,
> +	/* Reference clock select for SuperSpeed and HighSpeed PLLs:
> +	 *	0x0 =3D Both PLLs use DLMC_REF_CLK0 for reference clock
> +	 *	0x1 =3D Both PLLs use DLMC_REF_CLK1 for reference clock
> +	 *	0x2 =3D SuperSpeed PLL uses DLMC_REF_CLK0 for reference clock &
> +	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
> +	 *	0x3 =3D SuperSpeed PLL uses DLMC_REF_CLK1 for reference clock &
> +	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
> +	 */
> +	__BITFIELD_FIELD(uint64_t ref_clk_sel:2,
> +	/* 1 =3D Spread-spectrum clock enable, 0 =3D SS clock disable */
> +	__BITFIELD_FIELD(uint64_t ssc_en:1,
> +	/* Spread-spectrum clock modulation range:
> +	 *	0x0 =3D -4980 ppm downspread
> +	 *	0x1 =3D -4492 ppm downspread
> +	 *	0x2 =3D -4003 ppm downspread
> +	 *	0x3 - 0x7 =3D Reserved
> +	 */
> +	__BITFIELD_FIELD(uint64_t ssc_range:3,
> +	/* Enable non-standard oscillator frequencies:
> +	 *	[55:53] =3D modules -1
> +	 *	[52:47] =3D 2's complement push amount, 0 =3D Feature disabled
> +	 */
> +	__BITFIELD_FIELD(uint64_t ssc_ref_clk_sel:9,
> +	/* Reference clock multiplier for non-standard frequencies:
> +	 *	0x19 =3D 100MHz on DLMC_REF_CLK* if REF_CLK_SEL =3D 0x0 or 0x1
> +	 *	0x28 =3D 125MHz on DLMC_REF_CLK* if REF_CLK_SEL =3D 0x0 or 0x1
> +	 *	0x32 =3D  50MHz on DLMC_REF_CLK* if REF_CLK_SEL =3D 0x0 or 0x1
> +	 *	Other Values =3D Reserved
> +	 */
> +	__BITFIELD_FIELD(uint64_t mpll_multiplier:7,
> +	/* Enable reference clock to prescaler for SuperSpeed functionality.
> +	 * Should always be set to "1"
> +	 */
> +	__BITFIELD_FIELD(uint64_t ref_ssp_en:1,
> +	/* Divide the reference clock by 2 before entering the
> +	 * REF_CLK_FSEL divider:
> +	 *	If REF_CLK_SEL =3D 0x0 or 0x1, then only 0x0 is legal
> +	 *	If REF_CLK_SEL =3D 0x2 or 0x3, then:
> +	 *		0x1 =3D DLMC_REF_CLK* is 125MHz
> +	 *		0x0 =3D DLMC_REF_CLK* is another supported frequency
> +	 */
> +	__BITFIELD_FIELD(uint64_t ref_clk_div2:1,
> +	/* Select reference clock freqnuency for both PLL blocks:
> +	 *	0x27 =3D REF_CLK_SEL is 0x0 or 0x1
> +	 *	0x07 =3D REF_CLK_SEL is 0x2 or 0x3
> +	 */
> +	__BITFIELD_FIELD(uint64_t ref_clk_fsel:6,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_31_31:1,
> +	/* Controller clock enable. */
> +	__BITFIELD_FIELD(uint64_t h_clk_en:1,
> +	/* Select bypass input to controller clock divider:
> +	 *	0x0 =3D Use divided coprocessor clock from H_CLKDIV
> +	 *	0x1 =3D Use clock from GPIO pins
> +	 */
> +	__BITFIELD_FIELD(uint64_t h_clk_byp_sel:1,
> +	/* Reset controller clock divider. */
> +	__BITFIELD_FIELD(uint64_t h_clkdiv_rst:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_27_27:1,
> +	/* Clock divider select:
> +	 *	0x0 =3D divide by 1
> +	 *	0x1 =3D divide by 2
> +	 *	0x2 =3D divide by 4
> +	 *	0x3 =3D divide by 6
> +	 *	0x4 =3D divide by 8
> +	 *	0x5 =3D divide by 16
> +	 *	0x6 =3D divide by 24
> +	 *	0x7 =3D divide by 32
> +	 */
> +	__BITFIELD_FIELD(uint64_t h_clkdiv_sel:3,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_22_23:2,
> +	/* USB3 port permanently attached: 0x0 =3D No, 0x1 =3D Yes */
> +	__BITFIELD_FIELD(uint64_t usb3_port_perm_attach:1,
> +	/* USB2 port permanently attached: 0x0 =3D No, 0x1 =3D Yes */
> +	__BITFIELD_FIELD(uint64_t usb2_port_perm_attach:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_19_19:1,
> +	/* Disable SuperSpeed PHY: 0x0 =3D No, 0x1 =3D Yes */
> +	__BITFIELD_FIELD(uint64_t usb3_port_disable:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_17_17:1,
> +	/* Disable HighSpeed PHY: 0x0 =3D No, 0x1 =3D Yes */
> +	__BITFIELD_FIELD(uint64_t usb2_port_disable:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_15_15:1,
> +	/* Enable PHY SuperSpeed block power: 0x0 =3D No, 0x1 =3D Yes */
> +	__BITFIELD_FIELD(uint64_t ss_power_en:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_13_13:1,
> +	/* Enable PHY HighSpeed block power: 0x0 =3D No, 0x1 =3D Yes */
> +	__BITFIELD_FIELD(uint64_t hs_power_en:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_5_11:7,
> +	/* Enable USB UCTL interface clock: 0xx =3D No, 0x1 =3D Yes */
> +	__BITFIELD_FIELD(uint64_t csclk_en:1,
> +	/* Controller mode: 0x0 =3D Host, 0x1 =3D Device */
> +	__BITFIELD_FIELD(uint64_t drd_mode:1,
> +	/* PHY reset */
> +	__BITFIELD_FIELD(uint64_t uphy_rst:1,
> +	/* Software reset UAHC */
> +	__BITFIELD_FIELD(uint64_t uahc_rst:1,
> +	/* Software resets UCTL */
> +	__BITFIELD_FIELD(uint64_t uctl_rst:1,
> +	;)))))))))))))))))))))))))))))))))
> +	} s;
> +};
> +
> +/* UAHC Configuration Register */
> +union cvm_usbdrd_uctl_host_cfg {
> +	uint64_t u64;
> +	struct cvm_usbdrd_uctl_host_cfg_s {
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_60_63:4,
> +	/* Indicates minimum value of all received BELT values */
> +	__BITFIELD_FIELD(uint64_t host_current_belt:12,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_38_47:10,
> +	/* HS jitter adjustment */
> +	__BITFIELD_FIELD(uint64_t fla:6,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_29_31:3,
> +	/* Bus-master enable: 0x0 =3D Disabled (stall DMAs), 0x1 =3D enabled */
> +	__BITFIELD_FIELD(uint64_t bme:1,
> +	/* Overcurrent protection enable: 0x0 =3D unavailable, 0x1 =3D availabl=
e */
> +	__BITFIELD_FIELD(uint64_t oci_en:1,
> +	/* Overcurrent sene selection:
> +	 *	0x0 =3D Overcurrent indication from off-chip is active-low
> +	 *	0x1 =3D Overcurrent indication from off-chip is active-high
> +	 */
> +	__BITFIELD_FIELD(uint64_t oci_active_high_en:1,
> +	/* Port power control enable: 0x0 =3D unavailable, 0x1 =3D available */
> +	__BITFIELD_FIELD(uint64_t ppc_en:1,
> +	/* Port power control sense selection:
> +	 *	0x0 =3D Port power to off-chip is active-low
> +	 *	0x1 =3D Port power to off-chip is active-high
> +	 */
> +	__BITFIELD_FIELD(uint64_t ppc_active_high_en:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_0_23:24,
> +	;)))))))))))
> +	} s;
> +};
> +
> +/* UCTL Shim Features Register */
> +union cvm_usbdrd_uctl_shim_cfg {
> +	uint64_t u64;
> +	struct cvm_usbdrd_uctl_shim_cfg_s {
> +	/* Out-of-bound UAHC register access: 0 =3D read, 1 =3D write */
> +	__BITFIELD_FIELD(uint64_t xs_ncb_oob_wrn:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_60_62:3,
> +	/* SRCID error log for out-of-bound UAHC register access:
> +	 *	[59:58] =3D chipID
> +	 *	[57] =3D Request source: 0 =3D core, 1 =3D NCB-device
> +	 *	[56:51] =3D Core/NCB-device number, [56] always 0 for NCB devices
> +	 *	[50:48] =3D SubID
> +	 */
> +	__BITFIELD_FIELD(uint64_t xs_ncb_oob_osrc:12,
> +	/* Error log for bad UAHC DMA access: 0 =3D Read log, 1 =3D Write log */
> +	__BITFIELD_FIELD(uint64_t xm_bad_dma_wrn:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_44_46:3,
> +	/* Encoded error type for bad UAHC DMA */
> +	__BITFIELD_FIELD(uint64_t xm_bad_dma_type:4,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_13_39:27,
> +	/* Select the IOI read command used by DMA accesses */
> +	__BITFIELD_FIELD(uint64_t dma_read_cmd:1,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_10_11:2,
> +	/* Select endian format for DMA accesses to the L2c:
> +	 *	0x0 =3D Little endian
> +	 *`	0x1 =3D Big endian
> +	 *	0x2 =3D Reserved
> +	 *	0x3 =3D Reserved
> +	 */
> +	__BITFIELD_FIELD(uint64_t dma_endian_mode:2,
> +	/* Reserved */
> +	__BITFIELD_FIELD(uint64_t reserved_2_7:6,
> +	/* Select endian format for IOI CSR access to UAHC:
> +	 *	0x0 =3D Little endian
> +	 *`	0x1 =3D Big endian
> +	 *	0x2 =3D Reserved
> +	 *	0x3 =3D Reserved
> +	 */
> +	__BITFIELD_FIELD(uint64_t csr_endian_mode:2,
> +	;))))))))))))
> +	} s;
> +};
> +
> +#define OCTEON_H_CLKDIV_SEL		8
> +#define OCTEON_MIN_H_CLK_RATE		150000000
> +#define OCTEON_MAX_H_CLK_RATE		300000000
> +
> +static DEFINE_MUTEX(dwc3_octeon_clocks_mutex);
> +static uint8_t clk_div[OCTEON_H_CLKDIV_SEL] =3D {1, 2, 4, 6, 8, 16, 24, =
32};
> +
> +
> +static int dwc3_octeon_config_power(struct device *dev, u64 base)
> +{
> +#define UCTL_HOST_CFG	0xe0
> +	union cvm_usbdrd_uctl_host_cfg uctl_host_cfg;
> +	union cvmx_gpio_bit_cfgx gpio_bit;
> +	uint32_t gpio_pwr[3];
> +	int gpio, len, power_active_low;
> +	struct device_node *node =3D dev->of_node;
> +	int index =3D (base >> 24) & 1;
> +
> +	if (of_find_property(node, "power", &len) !=3D NULL) {
> +		if (len =3D=3D 12) {
> +			of_property_read_u32_array(node, "power", gpio_pwr, 3);
> +			power_active_low =3D gpio_pwr[2] & 0x01;
> +			gpio =3D gpio_pwr[1];
> +		} else if (len =3D=3D 8) {
> +			of_property_read_u32_array(node, "power", gpio_pwr, 2);
> +			power_active_low =3D 0;
> +			gpio =3D gpio_pwr[1];
> +		} else {
> +			dev_err(dev, "dwc3 controller clock init failure.\n");
> +			return -EINVAL;
> +		}
> +		if ((OCTEON_IS_MODEL(OCTEON_CN73XX) ||
> +		    OCTEON_IS_MODEL(OCTEON_CNF75XX))
> +		    && gpio <=3D 31) {
> +			gpio_bit.u64 =3D cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
> +			gpio_bit.s.tx_oe =3D 1;
> +			gpio_bit.cn73xx.output_sel =3D (index =3D=3D 0 ? 0x14 : 0x15);
> +			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
> +		} else if (gpio <=3D 15) {
> +			gpio_bit.u64 =3D cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
> +			gpio_bit.s.tx_oe =3D 1;
> +			gpio_bit.cn70xx.output_sel =3D (index =3D=3D 0 ? 0x14 : 0x19);
> +			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
> +		} else {
> +			gpio_bit.u64 =3D cvmx_read_csr(CVMX_GPIO_XBIT_CFGX(gpio));
> +			gpio_bit.s.tx_oe =3D 1;
> +			gpio_bit.cn70xx.output_sel =3D (index =3D=3D 0 ? 0x14 : 0x19);
> +			cvmx_write_csr(CVMX_GPIO_XBIT_CFGX(gpio), gpio_bit.u64);
> +		}
> +
> +		/* Enable XHCI power control and set if active high or low. */
> +		uctl_host_cfg.u64 =3D cvmx_read_csr(base + UCTL_HOST_CFG);
> +		uctl_host_cfg.s.ppc_en =3D 1;
> +		uctl_host_cfg.s.ppc_active_high_en =3D !power_active_low;
> +		cvmx_write_csr(base + UCTL_HOST_CFG, uctl_host_cfg.u64);
> +	} else {
> +		/* Disable XHCI power control and set if active high. */
> +		uctl_host_cfg.u64 =3D cvmx_read_csr(base + UCTL_HOST_CFG);
> +		uctl_host_cfg.s.ppc_en =3D 0;
> +		uctl_host_cfg.s.ppc_active_high_en =3D 0;
> +		cvmx_write_csr(base + UCTL_HOST_CFG, uctl_host_cfg.u64);
> +		dev_warn(dev, "dwc3 controller clock init failure.\n");
> +	}
> +	return 0;
> +}
> +
> +static int dwc3_octeon_clocks_start(struct device *dev, u64 base)
> +{
> +	union cvm_usbdrd_uctl_ctl uctl_ctl;
> +	int ref_clk_sel =3D 2;
> +	u64 div;
> +	u32 clock_rate;
> +	int mpll_mul;
> +	int i;
> +	u64 h_clk_rate;
> +	u64 uctl_ctl_reg =3D base;
> +
> +	if (dev->of_node) {
> +		const char *ss_clock_type;
> +		const char *hs_clock_type;
> +
> +		i =3D of_property_read_u32(dev->of_node,
> +					 "refclk-frequency", &clock_rate);
> +		if (i) {
> +			pr_err("No UCTL \"refclk-frequency\"\n");
> +			return -EINVAL;
> +		}
> +		i =3D of_property_read_string(dev->of_node,
> +					    "refclk-type-ss", &ss_clock_type);
> +		if (i) {
> +			pr_err("No UCTL \"refclk-type-ss\"\n");
> +			return -EINVAL;
> +		}
> +		i =3D of_property_read_string(dev->of_node,
> +					    "refclk-type-hs", &hs_clock_type);
> +		if (i) {
> +			pr_err("No UCTL \"refclk-type-hs\"\n");
> +			return -EINVAL;
> +		}
> +		if (strcmp("dlmc_ref_clk0", ss_clock_type) =3D=3D 0) {
> +			if (strcmp(hs_clock_type, "dlmc_ref_clk0") =3D=3D 0)
> +				ref_clk_sel =3D 0;
> +			else if (strcmp(hs_clock_type, "pll_ref_clk") =3D=3D 0)
> +				ref_clk_sel =3D 2;
> +			else
> +				pr_err("Invalid HS clock type %s, using  pll_ref_clk instead\n",
> +				       hs_clock_type);
> +		} else if (strcmp(ss_clock_type, "dlmc_ref_clk1") =3D=3D 0) {
> +			if (strcmp(hs_clock_type, "dlmc_ref_clk1") =3D=3D 0)
> +				ref_clk_sel =3D 1;
> +			else if (strcmp(hs_clock_type, "pll_ref_clk") =3D=3D 0)
> +				ref_clk_sel =3D 3;
> +			else {
> +				pr_err("Invalid HS clock type %s, using  pll_ref_clk instead\n",
> +				       hs_clock_type);
> +				ref_clk_sel =3D 3;
> +			}
> +		} else
> +			pr_err("Invalid SS clock type %s, using  dlmc_ref_clk0 instead\n",
> +			       ss_clock_type);
> +
> +		if ((ref_clk_sel =3D=3D 0 || ref_clk_sel =3D=3D 1) &&
> +				  (clock_rate !=3D 100000000))
> +			pr_err("Invalid UCTL clock rate of %u, using 100000000 instead\n",
> +			       clock_rate);
> +
> +	} else {
> +		pr_err("No USB UCTL device node\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Step 1: Wait for all voltages to be stable...that surely
> +	 *         happened before starting the kernel. SKIP
> +	 */
> +
> +	/* Step 2: Select GPIO for overcurrent indication, if desired. SKIP */
> +
> +	/* Step 3: Assert all resets. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.uphy_rst =3D 1;
> +	uctl_ctl.s.uahc_rst =3D 1;
> +	uctl_ctl.s.uctl_rst =3D 1;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	/* Step 4a: Reset the clock dividers. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.h_clkdiv_rst =3D 1;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	/* Step 4b: Select controller clock frequency. */
> +	for (div =3D 0; div < OCTEON_H_CLKDIV_SEL; div++) {
> +		h_clk_rate =3D octeon_get_io_clock_rate() / clk_div[div];
> +		if (h_clk_rate <=3D OCTEON_MAX_H_CLK_RATE &&
> +				 h_clk_rate >=3D OCTEON_MIN_H_CLK_RATE)
> +			break;
> +	}
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.h_clkdiv_sel =3D div;
> +	uctl_ctl.s.h_clk_en =3D 1;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	if ((div !=3D uctl_ctl.s.h_clkdiv_sel) || (!uctl_ctl.s.h_clk_en)) {
> +		dev_err(dev, "dwc3 controller clock init failure.\n");
> +			return -EINVAL;
> +	}
> +
> +	/* Step 4c: Deassert the controller clock divider reset. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.h_clkdiv_rst =3D 0;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	/* Step 5a: Reference clock configuration. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.ref_clk_sel =3D ref_clk_sel;
> +	uctl_ctl.s.ref_clk_fsel =3D 0x07;
> +	uctl_ctl.s.ref_clk_div2 =3D 0;
> +	switch (clock_rate) {
> +	default:
> +		dev_err(dev, "Invalid ref_clk %u, using 100000000 instead\n",
> +			clock_rate);
> +	case 100000000:
> +		mpll_mul =3D 0x19;
> +		if (ref_clk_sel < 2)
> +			uctl_ctl.s.ref_clk_fsel =3D 0x27;
> +		break;
> +	case 50000000:
> +		mpll_mul =3D 0x32;
> +		break;
> +	case 125000000:
> +		mpll_mul =3D 0x28;
> +		break;
> +	}
> +	uctl_ctl.s.mpll_multiplier =3D mpll_mul;
> +
> +	/* Step 5b: Configure and enable spread-spectrum for SuperSpeed. */
> +	uctl_ctl.s.ssc_en =3D 1;
> +
> +	/* Step 5c: Enable SuperSpeed. */
> +	uctl_ctl.s.ref_ssp_en =3D 1;
> +
> +	/* Step 5d: Cofngiure PHYs. SKIP */
> +
> +	/* Step 6a & 6b: Power up PHYs. */
> +	uctl_ctl.s.hs_power_en =3D 1;
> +	uctl_ctl.s.ss_power_en =3D 1;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	/* Step 7: Wait 10 controller-clock cycles to take effect. */
> +	udelay(10);
> +
> +	/* Step 8a: Deassert UCTL reset signal. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.uctl_rst =3D 0;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	/* Step 8b: Wait 10 controller-clock cycles. */
> +	udelay(10);
> +
> +	/* Steo 8c: Setup power-power control. */
> +	if (dwc3_octeon_config_power(dev, base)) {
> +		dev_err(dev, "Error configuring power.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Step 8d: Deassert UAHC reset signal. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.uahc_rst =3D 0;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	/* Step 8e: Wait 10 controller-clock cycles. */
> +	udelay(10);
> +
> +	/* Step 9: Enable conditional coprocessor clock of UCTL. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.csclk_en =3D 1;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	/*Step 10: Set for host mode only. */
> +	uctl_ctl.u64 =3D cvmx_read_csr(uctl_ctl_reg);
> +	uctl_ctl.s.drd_mode =3D 0;
> +	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
> +
> +	return 0;
> +}
> +
> +static void __init dwc3_octeon_set_endian_mode(u64 base)
> +{
> +#define UCTL_SHIM_CFG	0xe8
> +	union cvm_usbdrd_uctl_shim_cfg shim_cfg;
> +
> +	shim_cfg.u64 =3D cvmx_read_csr(base + UCTL_SHIM_CFG);
> +#ifdef __BIG_ENDIAN
> +	shim_cfg.s.dma_endian_mode =3D 1;
> +	shim_cfg.s.csr_endian_mode =3D 1;
> +#else
> +	shim_cfg.s.dma_endian_mode =3D 0;
> +	shim_cfg.s.csr_endian_mode =3D 0;
> +#endif
> +	cvmx_write_csr(base + UCTL_SHIM_CFG, shim_cfg.u64);
> +}
> +
> +#define CVMX_USBDRDX_UCTL_CTL(index)				\
> +		(CVMX_ADD_IO_SEG(0x0001180068000000ull) +	\
> +		((index & 1) * 0x1000000ull))
> +static void __init dwc3_octeon_phy_reset(u64 base)
> +{
> +	union cvm_usbdrd_uctl_ctl uctl_ctl;
> +	int index =3D (base >> 24) & 1;
> +
> +	uctl_ctl.u64 =3D cvmx_read_csr(CVMX_USBDRDX_UCTL_CTL(index));
> +	uctl_ctl.s.uphy_rst =3D 0;
> +	cvmx_write_csr(CVMX_USBDRDX_UCTL_CTL(index), uctl_ctl.u64);
> +}
> +
> +static int __init dwc3_octeon_device_init(void)
> +{
> +	const char compat_node_name[] =3D "cavium,octeon-7130-usb-uctl";
> +	struct platform_device *pdev;
> +	struct device_node *node;
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	/*
> +	 * There should only be three universal controllers, "uctl"
> +	 * in the device tree. Two USB and a SATA, which we ignore.
> +	 */
> +	node =3D NULL;
> +	do {
> +		node =3D of_find_node_by_name(node, "uctl");
> +		if (!node)
> +			return -ENODEV;
> +
> +		if (of_device_is_compatible(node, compat_node_name)) {
> +			pdev =3D of_find_device_by_node(node);
> +			if (!pdev)
> +				return -ENODEV;
> +
> +			res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +			if (res =3D=3D NULL) {
> +				dev_err(&pdev->dev, "No memory resources\n");
> +				return -ENXIO;
> +			}
> +
> +			/*
> +			 * The code below maps in the registers necessary for
> +			 * setting up the clocks and reseting PHYs. We must
> +			 * release the resources so the dwc3 subsystem doesn't
> +			 * know the difference.
> +			 */
> +			base =3D devm_ioremap_resource(&pdev->dev, res);
> +			if (IS_ERR(base))
> +				return PTR_ERR(base);
> +
> +			mutex_lock(&dwc3_octeon_clocks_mutex);
> +			dwc3_octeon_clocks_start(&pdev->dev, (u64)base);
> +			dwc3_octeon_set_endian_mode((u64)base);
> +			dwc3_octeon_phy_reset((u64)base);
> +			dev_info(&pdev->dev, "clocks initialized.\n");
> +			mutex_unlock(&dwc3_octeon_clocks_mutex);
> +			devm_iounmap(&pdev->dev, base);
> +			devm_release_mem_region(&pdev->dev, res->start,
> +						resource_size(res));
> +		}
> +	} while (node !=3D NULL);
> +
> +	return 0;
> +}
> +device_initcall(dwc3_octeon_device_init);
> +
> +MODULE_AUTHOR("David Daney <david.daney@cavium.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("USB driver for OCTEON III SoC");
> diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/in=
clude/asm/octeon/cvmx-gpio-defs.h
> index 4719fcf..8123b82 100644
> --- a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
> +++ b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
> @@ -46,7 +46,8 @@
>  	uint64_t u64;
>  	struct cvmx_gpio_bit_cfgx_s {
>  #ifdef __BIG_ENDIAN_BITFIELD
> -		uint64_t reserved_17_63:47;
> +		uint64_t reserved_21_63:42;
> +		uint64_t output_sel:5;
>  		uint64_t synce_sel:2;
>  		uint64_t clk_gen:1;
>  		uint64_t clk_sel:2;
> @@ -66,7 +67,8 @@
>  		uint64_t clk_sel:2;
>  		uint64_t clk_gen:1;
>  		uint64_t synce_sel:2;
> -		uint64_t reserved_17_63:47;
> +		uint64_t output_sel:5;
> +		uint64_t reserved_21_63:42;
>  #endif
>  	} s;
>  	struct cvmx_gpio_bit_cfgx_cn30xx {
> @@ -126,6 +128,8 @@
>  	struct cvmx_gpio_bit_cfgx_s cn66xx;
>  	struct cvmx_gpio_bit_cfgx_s cn68xx;
>  	struct cvmx_gpio_bit_cfgx_s cn68xxp1;
> +	struct cvmx_gpio_bit_cfgx_s cn70xx;
> +	struct cvmx_gpio_bit_cfgx_s cn73xx;
>  	struct cvmx_gpio_bit_cfgx_s cnf71xx;
>  };
>=20
> --=20
> 1.9.1
>=20
>=20

--zxEKvxCKojqA/Afl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYotbLAAoJEGwLaZPeOHZ6ysIP/iR+QOjGE8ym0ZuYqP7HO05d
ivctZzuFi8SxkP/2PoeruEa+MiGsIr0ECO/1nFr5t4bIkgOy+NB5Jb962mnk2xUG
kePUREEk3tpKIzQDgRLqOMpsADZZ7FSGO5lIc42dG0Qf8CDx2q9M8elMA4iUOgRg
duO+YXU4W6wlSH8xFj8Dolos2YDelgYL/MNHy1P7TqufM3K0EmueMqnkIkmKWX63
lz9IcGbjTuTsisUN43Ex8r7e7NidFf/yuXPPTWZDKkxhPrgLELvtVYk3LsHMXG/a
QRIkEKL16/jGnVPbc8d4cXRKhigS7nL5sRVdCjZzG/QXRPH+/u+d8XVrciLjOlco
yJJOuWHwYEW2aiBK28t3VuO2yqezJBjndJPSVMRozzj5jYZIBP77iaQrSgWWSL0P
SSfzmg6yZmHusJbh99ZBdeUtuOEwpA5JHOdZPJTcf8ionBPMQj7wE3PgJFdFvcum
AStawFIt3V1R2hy70kGabw/v3cfYnUxDApeSgg2dJjVyda9461B+VEPwp9DDDZX5
A6Vwv4HUER35F25iH+uzQxVkJmJnSMAis53SEdA1ZYuk91SFomctJauG/f250gk/
MMNr+OJ+yiAQ5EuiKxN43HvIf841aSXgzTWfhwgbbQNwRWbSGPGVxd9lqxyST6VL
rUwvMBKbwBF1+EbmDqtq
=obWh
-----END PGP SIGNATURE-----

--zxEKvxCKojqA/Afl--
