Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 15:52:01 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:33619 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007109AbbKUOv5N8hZ9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Nov 2015 15:51:57 +0100
Received: from [192.168.178.24] (pD9F60D34.dip0.t-ipconnect.de [217.246.13.52])
        by hauke-m.de (Postfix) with ESMTPSA id 06AFB100028;
        Sat, 21 Nov 2015 15:51:54 +0100 (CET)
Subject: Re: [PATCH 2/4] pinctrl/lantiq: introduce new dedicated devicetree
 bindings
To:     Martin Schiller <mschiller@tdt.de>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
References: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
 <1447995151-3857-2-git-send-email-mschiller@tdt.de>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, ralf@linux-mips.org, blogic@openwrt.org,
        jogo@openwrt.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <5650850A.5050000@hauke-m.de>
Date:   Sat, 21 Nov 2015 15:51:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.3.0
MIME-Version: 1.0
In-Reply-To: <1447995151-3857-2-git-send-email-mschiller@tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 11/20/2015 05:52 AM, Martin Schiller wrote:
> This patch introduces new dedicated "lantiq,pinctrl-<chip>" devicetree
> bindings, where <chip> is one of "ase", "danube", "xrx100", "xrx200" or
> "xrx300" and marks the "lantiq,pinctrl-xway" and "lantiq,pinctrl-xr9" bindings as
> DEPRECATED.

Thanks for proposing this patch.

Most of my coments are not to your changes but to the old code.

> Based on the newest Lantiq Hardware Description it turend out, that there are
> some differences in the GPIO alternative functions of the Danube, xRX100 and
> xRX200 families, which makes it impossible to use only one xway_mfp table.
> 
> This patch also adds support for the xRX300 family.
> 
> Signed-off-by: Martin Schiller <mschiller@tdt.de>

When you copy code from one place to an other it is easier to put that
into an extra patch so a reviewer does not have to look into the details
and knows that the blocks itself did not changed. Then in a new patch
you can make the changes where a detailed review is needed.

> ---
>  drivers/pinctrl/pinctrl-lantiq.h |    8 +
>  drivers/pinctrl/pinctrl-xway.c   | 1125 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 1030 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-lantiq.h b/drivers/pinctrl/pinctrl-lantiq.h
> index eb89ba0..e137d13 100644
> --- a/drivers/pinctrl/pinctrl-lantiq.h
> +++ b/drivers/pinctrl/pinctrl-lantiq.h
> @@ -162,6 +162,14 @@ enum ltq_pin {
>  	GPIO53,
>  	GPIO54,
>  	GPIO55,
> +	GPIO56,
> +	GPIO57,
> +	GPIO58,
> +	GPIO59,
> +	GPIO60, /* 60 */
> +	GPIO61,
> +	GPIO62,
> +	GPIO63,
>  
>  	GPIO64,
>  	GPIO65,

What is the advantage of using this enum compared to just use integers
directly? Was it intentionally that GPIO64 has the number 56 before?

> diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
> index ae724bd..234d3f4 100644
> --- a/drivers/pinctrl/pinctrl-xway.c
> +++ b/drivers/pinctrl/pinctrl-xway.c
> @@ -7,6 +7,7 @@
>   *  publishhed by the Free Software Foundation.
>   *
>   *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
> + *  Copyright (C) 2015 Martin Schiller <mschiller@tdt.de>
>   */
>  
>  #include <linux/err.h>
> @@ -24,7 +25,7 @@
>  
>  #include <lantiq_soc.h>
>  
> -/* we have 3 1/2 banks of 16 bit each */
> +/* we have up to 4 banks of 16 bit each */
>  #define PINS			16
>  #define PORT3			3
>  #define PORT(x)			(x / PINS)
> @@ -35,7 +36,7 @@
>  #define MUX_ALT1	0x2
>  
>  /*
> - * each bank has this offset apart from the 1/2 bank that is mixed into the
> + * each bank has this offset apart from the 4th bank that is mixed into the
>   * other 3 ranges
>   */
>  #define REG_OFF			0x30
> @@ -51,7 +52,7 @@
>  #define GPIO_PUDSEL(p)		(GPIO_BASE(p) + 0x1c)
>  #define GPIO_PUDEN(p)		(GPIO_BASE(p) + 0x20)
>  
> -/* the 1/2 port needs special offsets for some registers */
> +/* the 4th port needs special offsets for some registers */
>  #define GPIO3_OD		(GPIO_BASE(0) + 0x24)
>  #define GPIO3_PUDSEL		(GPIO_BASE(0) + 0x28)
>  #define GPIO3_PUDEN		(GPIO_BASE(0) + 0x2C)
> @@ -80,17 +81,18 @@
>  #define FUNC_MUX(f, m)		\
>  	{ .func = f, .mux = XWAY_MUX_##m, }
>  
> -#define XWAY_MAX_PIN		32
> -#define XR9_MAX_PIN		56
> -
>  enum xway_mux {
>  	XWAY_MUX_GPIO = 0,
>  	XWAY_MUX_SPI,
>  	XWAY_MUX_ASC,
> +	XWAY_MUX_USIF,
>  	XWAY_MUX_PCI,
> +	XWAY_MUX_CBUS,
>  	XWAY_MUX_CGU,
>  	XWAY_MUX_EBU,
> +	XWAY_MUX_EBU2,
>  	XWAY_MUX_JTAG,
> +	XWAY_MUX_MCD,
>  	XWAY_MUX_EXIN,
>  	XWAY_MUX_TDM,
>  	XWAY_MUX_STP,
> @@ -103,9 +105,16 @@ enum xway_mux {
>  	XWAY_MUX_DFE,
>  	XWAY_MUX_SDIO,
>  	XWAY_MUX_GPHY,
> +	XWAY_MUX_SSI,
> +	XWAY_MUX_WIFI,
>  	XWAY_MUX_NONE = 0xffff,
>  };
>  
> +/* ---------  DEPRECATED: xway/xr9 related code --------- */
> +/* ---------  use danube/xrx100/xrx200 instead  --------- */
> +#define XWAY_MAX_PIN		32
> +#define XR9_MAX_PIN		56
> +
>  static const struct ltq_mfp_pin xway_mfp[] = {
>  	/*       pin    f0	f1	f2	f3   */
>  	MFP_XWAY(GPIO0, GPIO,	EXIN,	NONE,	TDM),
> @@ -113,7 +122,7 @@ static const struct ltq_mfp_pin xway_mfp[] = {
>  	MFP_XWAY(GPIO2, GPIO,	CGU,	EXIN,	GPHY),
>  	MFP_XWAY(GPIO3, GPIO,	CGU,	NONE,	PCI),
>  	MFP_XWAY(GPIO4, GPIO,	STP,	NONE,	ASC),
> -	MFP_XWAY(GPIO5, GPIO,	STP,	NONE,	GPHY),
> +	MFP_XWAY(GPIO5, GPIO,	STP,	GPHY,	NONE),
>  	MFP_XWAY(GPIO6, GPIO,	STP,	GPT,	ASC),
>  	MFP_XWAY(GPIO7, GPIO,	CGU,	PCI,	GPHY),
>  	MFP_XWAY(GPIO8, GPIO,	CGU,	NMI,	NONE),
> @@ -152,7 +161,7 @@ static const struct ltq_mfp_pin xway_mfp[] = {
>  	MFP_XWAY(GPIO41, GPIO,	NONE,	NONE,	NONE),
>  	MFP_XWAY(GPIO42, GPIO,	MDIO,	NONE,	NONE),
>  	MFP_XWAY(GPIO43, GPIO,	MDIO,	NONE,	NONE),
> -	MFP_XWAY(GPIO44, GPIO,	NONE,	GPHY,	SIN),
> +	MFP_XWAY(GPIO44, GPIO,	NONE,	SIN,	GPHY),
>  	MFP_XWAY(GPIO45, GPIO,	NONE,	GPHY,	SIN),
>  	MFP_XWAY(GPIO46, GPIO,	NONE,	NONE,	EXIN),
>  	MFP_XWAY(GPIO47, GPIO,	NONE,	GPHY,	SIN),
> @@ -166,42 +175,6 @@ static const struct ltq_mfp_pin xway_mfp[] = {
>  	MFP_XWAY(GPIO55, GPIO,	NONE,	NONE,	NONE),
>  };
>  
> -static const struct ltq_mfp_pin ase_mfp[] = {
> -	/*       pin    f0	f1	f2	f3   */
> -	MFP_XWAY(GPIO0, GPIO,	EXIN,	MII,	TDM),
> -	MFP_XWAY(GPIO1, GPIO,	STP,	DFE,	EBU),
> -	MFP_XWAY(GPIO2, GPIO,	STP,	DFE,	EPHY),
> -	MFP_XWAY(GPIO3, GPIO,	STP,	EPHY,	EBU),
> -	MFP_XWAY(GPIO4, GPIO,	GPT,	EPHY,	MII),
> -	MFP_XWAY(GPIO5, GPIO,	MII,	ASC,	GPT),
> -	MFP_XWAY(GPIO6, GPIO,	MII,	ASC,	EXIN),
> -	MFP_XWAY(GPIO7, GPIO,	SPI,	MII,	JTAG),
> -	MFP_XWAY(GPIO8, GPIO,	SPI,	MII,	JTAG),
> -	MFP_XWAY(GPIO9, GPIO,	SPI,	MII,	JTAG),
> -	MFP_XWAY(GPIO10, GPIO,	SPI,	MII,	JTAG),
> -	MFP_XWAY(GPIO11, GPIO,	EBU,	CGU,	JTAG),
> -	MFP_XWAY(GPIO12, GPIO,	EBU,	MII,	SDIO),
> -	MFP_XWAY(GPIO13, GPIO,	EBU,	MII,	CGU),
> -	MFP_XWAY(GPIO14, GPIO,	EBU,	SPI,	CGU),
> -	MFP_XWAY(GPIO15, GPIO,	EBU,	SPI,	SDIO),
> -	MFP_XWAY(GPIO16, GPIO,	NONE,	NONE,	NONE),
> -	MFP_XWAY(GPIO17, GPIO,	NONE,	NONE,	NONE),
> -	MFP_XWAY(GPIO18, GPIO,	NONE,	NONE,	NONE),
> -	MFP_XWAY(GPIO19, GPIO,	EBU,	MII,	SDIO),
> -	MFP_XWAY(GPIO20, GPIO,	EBU,	MII,	SDIO),
> -	MFP_XWAY(GPIO21, GPIO,	EBU,	MII,	SDIO),
> -	MFP_XWAY(GPIO22, GPIO,	EBU,	MII,	CGU),
> -	MFP_XWAY(GPIO23, GPIO,	EBU,	MII,	CGU),
> -	MFP_XWAY(GPIO24, GPIO,	EBU,	NONE,	MII),
> -	MFP_XWAY(GPIO25, GPIO,	EBU,	MII,	GPT),
> -	MFP_XWAY(GPIO26, GPIO,	EBU,	MII,	SDIO),
> -	MFP_XWAY(GPIO27, GPIO,	EBU,	NONE,	MII),
> -	MFP_XWAY(GPIO28, GPIO,	MII,	EBU,	SDIO),
> -	MFP_XWAY(GPIO29, GPIO,	EBU,	MII,	EXIN),
> -	MFP_XWAY(GPIO30, GPIO,	NONE,	NONE,	NONE),
> -	MFP_XWAY(GPIO31, GPIO,	NONE,	NONE,	NONE),
> -};
> -
>  static const unsigned pins_jtag[] = {GPIO15, GPIO16, GPIO17, GPIO19, GPIO35};
>  static const unsigned pins_asc0[] = {GPIO11, GPIO12};
>  static const unsigned pins_asc0_cts_rts[] = {GPIO9, GPIO10};
> @@ -231,6 +204,8 @@ static const unsigned pins_nand_cle[] = {GPIO24};
>  static const unsigned pins_nand_rdy[] = {GPIO48};
>  static const unsigned pins_nand_rd[] = {GPIO49};
>  
> +static const unsigned xway_exin_pin_map[] = {GPIO0, GPIO1, GPIO2, GPIO39, GPIO46, GPIO9};
> +
>  static const unsigned pins_exin0[] = {GPIO0};
>  static const unsigned pins_exin1[] = {GPIO1};
>  static const unsigned pins_exin2[] = {GPIO2};
> @@ -240,7 +215,7 @@ static const unsigned pins_exin5[] = {GPIO9};
>  
>  static const unsigned pins_spi[] = {GPIO16, GPIO17, GPIO18};
>  static const unsigned pins_spi_cs1[] = {GPIO15};
> -static const unsigned pins_spi_cs2[] = {GPIO21};
> +static const unsigned pins_spi_cs2[] = {GPIO22};
>  static const unsigned pins_spi_cs3[] = {GPIO13};
>  static const unsigned pins_spi_cs4[] = {GPIO10};
>  static const unsigned pins_spi_cs5[] = {GPIO9};
> @@ -264,25 +239,6 @@ static const unsigned pins_pci_req2[] = {GPIO31};
>  static const unsigned pins_pci_req3[] = {GPIO3};
>  static const unsigned pins_pci_req4[] = {GPIO37};
>  
> -static const unsigned ase_pins_jtag[] = {GPIO7, GPIO8, GPIO9, GPIO10, GPIO11};
> -static const unsigned ase_pins_asc[] = {GPIO5, GPIO6};
> -static const unsigned ase_pins_stp[] = {GPIO1, GPIO2, GPIO3};
> -static const unsigned ase_pins_ephy[] = {GPIO2, GPIO3, GPIO4};
> -static const unsigned ase_pins_dfe[] = {GPIO1, GPIO2};
> -
> -static const unsigned ase_pins_spi[] = {GPIO8, GPIO9, GPIO10};
> -static const unsigned ase_pins_spi_cs1[] = {GPIO7};
> -static const unsigned ase_pins_spi_cs2[] = {GPIO15};
> -static const unsigned ase_pins_spi_cs3[] = {GPIO14};
> -
> -static const unsigned ase_pins_exin0[] = {GPIO6};
> -static const unsigned ase_pins_exin1[] = {GPIO29};
> -static const unsigned ase_pins_exin2[] = {GPIO0};
> -
> -static const unsigned ase_pins_gpt1[] = {GPIO5};
> -static const unsigned ase_pins_gpt2[] = {GPIO4};
> -static const unsigned ase_pins_gpt3[] = {GPIO25};
> -
>  static const struct ltq_pin_group xway_grps[] = {
>  	GRP_MUX("exin0", EXIN, pins_exin0),
>  	GRP_MUX("exin1", EXIN, pins_exin1),
> @@ -338,24 +294,6 @@ static const struct ltq_pin_group xway_grps[] = {
>  	GRP_MUX("gphy1 led2", GPHY, pins_gphy1_led2),
>  };
>  
> -static const struct ltq_pin_group ase_grps[] = {
> -	GRP_MUX("exin0", EXIN, ase_pins_exin0),
> -	GRP_MUX("exin1", EXIN, ase_pins_exin1),
> -	GRP_MUX("exin2", EXIN, ase_pins_exin2),
> -	GRP_MUX("jtag", JTAG, ase_pins_jtag),
> -	GRP_MUX("stp", STP, ase_pins_stp),
> -	GRP_MUX("asc", ASC, ase_pins_asc),
> -	GRP_MUX("gpt1", GPT, ase_pins_gpt1),
> -	GRP_MUX("gpt2", GPT, ase_pins_gpt2),
> -	GRP_MUX("gpt3", GPT, ase_pins_gpt3),
> -	GRP_MUX("ephy", EPHY, ase_pins_ephy),
> -	GRP_MUX("dfe", DFE, ase_pins_dfe),
> -	GRP_MUX("spi", SPI, ase_pins_spi),
> -	GRP_MUX("spi_cs1", SPI, ase_pins_spi_cs1),
> -	GRP_MUX("spi_cs2", SPI, ase_pins_spi_cs2),
> -	GRP_MUX("spi_cs3", SPI, ase_pins_spi_cs3),
> -};
> -
>  static const char * const xway_pci_grps[] = {"gnt1", "gnt2",
>  						"gnt3", "req1",
>  						"req2", "req3"};
> @@ -395,18 +333,7 @@ static const char * const xrx_pci_grps[] = {"gnt1", "gnt2",
>  						"req1", "req2",
>  						"req3", "req4"};
>  
> -/* ase */
> -static const char * const ase_exin_grps[] = {"exin0", "exin1", "exin2"};
> -static const char * const ase_gpt_grps[] = {"gpt1", "gpt2", "gpt3"};
> -static const char * const ase_dfe_grps[] = {"dfe"};
> -static const char * const ase_ephy_grps[] = {"ephy"};
> -static const char * const ase_asc_grps[] = {"asc"};
> -static const char * const ase_jtag_grps[] = {"jtag"};
> -static const char * const ase_stp_grps[] = {"stp"};
> -static const char * const ase_spi_grps[] = {"spi", "spi_cs1",
> -						"spi_cs2", "spi_cs3"};
> -
> -static const struct ltq_pmx_func danube_funcs[] = {
> +static const struct ltq_pmx_func legacy_danube_funcs[] = {
>  	{"spi",		ARRAY_AND_SIZE(xway_spi_grps)},
>  	{"asc",		ARRAY_AND_SIZE(xway_asc_grps)},
>  	{"cgu",		ARRAY_AND_SIZE(xway_cgu_grps)},
> @@ -434,17 +361,988 @@ static const struct ltq_pmx_func xrx_funcs[] = {
>  	{"gphy",	ARRAY_AND_SIZE(xrx_gphy_grps)},
>  };
>  
> +/* ---------  ase related code --------- */
> +#define ASE_MAX_PIN		32
> +
> +static const struct ltq_mfp_pin ase_mfp[] = {
> +	/*       pin    f0	f1	f2	f3   */
> +	MFP_XWAY(GPIO0, GPIO,	EXIN,	MII,	TDM),
> +	MFP_XWAY(GPIO1, GPIO,	STP,	DFE,	EBU),
> +	MFP_XWAY(GPIO2, GPIO,	STP,	DFE,	EPHY),
> +	MFP_XWAY(GPIO3, GPIO,	STP,	EPHY,	EBU),
> +	MFP_XWAY(GPIO4, GPIO,	GPT,	EPHY,	MII),
> +	MFP_XWAY(GPIO5, GPIO,	MII,	ASC,	GPT),
> +	MFP_XWAY(GPIO6, GPIO,	MII,	ASC,	EXIN),
> +	MFP_XWAY(GPIO7, GPIO,	SPI,	MII,	JTAG),
> +	MFP_XWAY(GPIO8, GPIO,	SPI,	MII,	JTAG),
> +	MFP_XWAY(GPIO9, GPIO,	SPI,	MII,	JTAG),
> +	MFP_XWAY(GPIO10, GPIO,	SPI,	MII,	JTAG),
> +	MFP_XWAY(GPIO11, GPIO,	EBU,	CGU,	JTAG),
> +	MFP_XWAY(GPIO12, GPIO,	EBU,	MII,	SDIO),
> +	MFP_XWAY(GPIO13, GPIO,	EBU,	MII,	CGU),
> +	MFP_XWAY(GPIO14, GPIO,	EBU,	SPI,	CGU),
> +	MFP_XWAY(GPIO15, GPIO,	EBU,	SPI,	SDIO),
> +	MFP_XWAY(GPIO16, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO17, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO18, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO19, GPIO,	EBU,	MII,	SDIO),
> +	MFP_XWAY(GPIO20, GPIO,	EBU,	MII,	SDIO),
> +	MFP_XWAY(GPIO21, GPIO,	EBU,	MII,	EBU2),
> +	MFP_XWAY(GPIO22, GPIO,	EBU,	MII,	CGU),
> +	MFP_XWAY(GPIO23, GPIO,	EBU,	MII,	CGU),
> +	MFP_XWAY(GPIO24, GPIO,	EBU,	EBU2,	MDIO),
> +	MFP_XWAY(GPIO25, GPIO,	EBU,	MII,	GPT),
> +	MFP_XWAY(GPIO26, GPIO,	EBU,	MII,	SDIO),
> +	MFP_XWAY(GPIO27, GPIO,	EBU,	NONE,	MDIO),
> +	MFP_XWAY(GPIO28, GPIO,	MII,	EBU,	SDIO),
> +	MFP_XWAY(GPIO29, GPIO,	EBU,	MII,	EXIN),
> +	MFP_XWAY(GPIO30, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO31, GPIO,	NONE,	NONE,	NONE),
> +};
> +
> +static const unsigned ase_exin_pin_map[] = {GPIO6, GPIO29, GPIO0};
> +
> +static const unsigned ase_pins_exin0[] = {GPIO6};
> +static const unsigned ase_pins_exin1[] = {GPIO29};
> +static const unsigned ase_pins_exin2[] = {GPIO0};
> +
> +static const unsigned ase_pins_jtag[] = {GPIO7, GPIO8, GPIO9, GPIO10, GPIO11};
> +static const unsigned ase_pins_asc[] = {GPIO5, GPIO6};
> +static const unsigned ase_pins_stp[] = {GPIO1, GPIO2, GPIO3};
> +static const unsigned ase_pins_mdio[] = {GPIO24, GPIO27};
> +static const unsigned ase_pins_ephy_led0[] = {GPIO2};
> +static const unsigned ase_pins_ephy_led1[] = {GPIO3};
> +static const unsigned ase_pins_ephy_led2[] = {GPIO4};
> +static const unsigned ase_pins_dfe_led0[] = {GPIO1};
> +static const unsigned ase_pins_dfe_led1[] = {GPIO2};
> +
> +static const unsigned ase_pins_spi[] = {GPIO8, GPIO9, GPIO10}; /* DEPRECATED */
> +static const unsigned ase_pins_spi_di[] = {GPIO8};
> +static const unsigned ase_pins_spi_do[] = {GPIO9};
> +static const unsigned ase_pins_spi_clk[] = {GPIO10};
> +static const unsigned ase_pins_spi_cs1[] = {GPIO7};
> +static const unsigned ase_pins_spi_cs2[] = {GPIO15};
> +static const unsigned ase_pins_spi_cs3[] = {GPIO14};
> +
> +static const unsigned ase_pins_gpt1[] = {GPIO5};
> +static const unsigned ase_pins_gpt2[] = {GPIO4};
> +static const unsigned ase_pins_gpt3[] = {GPIO25};
> +
> +static const unsigned ase_pins_clkout0[] = {GPIO23};
> +static const unsigned ase_pins_clkout1[] = {GPIO22};
> +static const unsigned ase_pins_clkout2[] = {GPIO14};
> +
> +static const struct ltq_pin_group ase_grps[] = {
> +	GRP_MUX("exin0", EXIN, ase_pins_exin0),
> +	GRP_MUX("exin1", EXIN, ase_pins_exin1),
> +	GRP_MUX("exin2", EXIN, ase_pins_exin2),
> +	GRP_MUX("jtag", JTAG, ase_pins_jtag),
> +	GRP_MUX("spi", SPI, ase_pins_spi), /* DEPRECATED */
> +	GRP_MUX("spi_di", SPI, ase_pins_spi_di),
> +	GRP_MUX("spi_do", SPI, ase_pins_spi_do),
> +	GRP_MUX("spi_clk", SPI, ase_pins_spi_clk),
> +	GRP_MUX("spi_cs1", SPI, ase_pins_spi_cs1),
> +	GRP_MUX("spi_cs2", SPI, ase_pins_spi_cs2),
> +	GRP_MUX("spi_cs3", SPI, ase_pins_spi_cs3),
> +	GRP_MUX("asc", ASC, ase_pins_asc),
> +	GRP_MUX("stp", STP, ase_pins_stp),
> +	GRP_MUX("gpt1", GPT, ase_pins_gpt1),
> +	GRP_MUX("gpt2", GPT, ase_pins_gpt2),
> +	GRP_MUX("gpt3", GPT, ase_pins_gpt3),
> +	GRP_MUX("clkout0", CGU, ase_pins_clkout0),
> +	GRP_MUX("clkout1", CGU, ase_pins_clkout1),
> +	GRP_MUX("clkout2", CGU, ase_pins_clkout2),
> +	GRP_MUX("mdio", MDIO, ase_pins_mdio),
> +	GRP_MUX("dfe led0", DFE, ase_pins_dfe_led0),
> +	GRP_MUX("dfe led1", DFE, ase_pins_dfe_led1),
> +	GRP_MUX("ephy led0", EPHY, ase_pins_ephy_led0),
> +	GRP_MUX("ephy led1", EPHY, ase_pins_ephy_led1),
> +	GRP_MUX("ephy led2", EPHY, ase_pins_ephy_led2),
> +};
> +
> +static const char * const ase_exin_grps[] = {"exin0", "exin1", "exin2"};
> +static const char * const ase_gpt_grps[] = {"gpt1", "gpt2", "gpt3"};
> +static const char * const ase_cgu_grps[] = {"clkout0", "clkout1",
> +						"clkout2"};
> +static const char * const ase_mdio_grps[] = {"mdio"};
> +static const char * const ase_dfe_grps[] = {"dfe led0", "dfe led1"};
> +static const char * const ase_ephy_grps[] = {"ephy led0", "ephy led1",
> +						"ephy led2"};
> +static const char * const ase_asc_grps[] = {"asc"};
> +static const char * const ase_jtag_grps[] = {"jtag"};
> +static const char * const ase_stp_grps[] = {"stp"};
> +static const char * const ase_spi_grps[] = {"spi",  /* DEPRECATED */
> +						"spi_di", "spi_do",
> +						"spi_clk", "spi_cs1",
> +						"spi_cs2", "spi_cs3"};
> +
>  static const struct ltq_pmx_func ase_funcs[] = {
>  	{"spi",		ARRAY_AND_SIZE(ase_spi_grps)},
>  	{"asc",		ARRAY_AND_SIZE(ase_asc_grps)},
> +	{"cgu",		ARRAY_AND_SIZE(ase_cgu_grps)},
>  	{"jtag",	ARRAY_AND_SIZE(ase_jtag_grps)},
>  	{"exin",	ARRAY_AND_SIZE(ase_exin_grps)},
>  	{"stp",		ARRAY_AND_SIZE(ase_stp_grps)},
>  	{"gpt",		ARRAY_AND_SIZE(ase_gpt_grps)},
> +	{"mdio",	ARRAY_AND_SIZE(ase_mdio_grps)},
>  	{"ephy",	ARRAY_AND_SIZE(ase_ephy_grps)},
>  	{"dfe",		ARRAY_AND_SIZE(ase_dfe_grps)},
>  };
>  
> +/* ---------  danube related code --------- */
> +#define DANUBE_MAX_PIN		32
> +
> +static const struct ltq_mfp_pin danube_mfp[] = {
> +	/*       pin    f0	f1	f2	f3   */
> +	MFP_XWAY(GPIO0, GPIO,	EXIN,	SDIO,	TDM),
> +	MFP_XWAY(GPIO1, GPIO,	EXIN,	CBUS,	MII),
> +	MFP_XWAY(GPIO2, GPIO,	CGU,	EXIN,	MII),
> +	MFP_XWAY(GPIO3, GPIO,	CGU,	SDIO,	PCI),
> +	MFP_XWAY(GPIO4, GPIO,	STP,	DFE,	ASC),
> +	MFP_XWAY(GPIO5, GPIO,	STP,	MII,	DFE),
> +	MFP_XWAY(GPIO6, GPIO,	STP,	GPT,	ASC),
> +	MFP_XWAY(GPIO7, GPIO,	CGU,	CBUS,	MII),
> +	MFP_XWAY(GPIO8, GPIO,	CGU,	NMI,	MII),
> +	MFP_XWAY(GPIO9, GPIO,	ASC,	SPI,	MII),
> +	MFP_XWAY(GPIO10, GPIO,	ASC,	SPI,	MII),
> +	MFP_XWAY(GPIO11, GPIO,	ASC,	CBUS,	SPI),
> +	MFP_XWAY(GPIO12, GPIO,	ASC,	CBUS,	MCD),
> +	MFP_XWAY(GPIO13, GPIO,	EBU,	SPI,	MII),
> +	MFP_XWAY(GPIO14, GPIO,	CGU,	CBUS,	MII),
> +	MFP_XWAY(GPIO15, GPIO,	SPI,	SDIO,	JTAG),
> +	MFP_XWAY(GPIO16, GPIO,	SPI,	SDIO,	JTAG),
> +	MFP_XWAY(GPIO17, GPIO,	SPI,	SDIO,	JTAG),
> +	MFP_XWAY(GPIO18, GPIO,	SPI,	SDIO,	JTAG),
> +	MFP_XWAY(GPIO19, GPIO,	PCI,	SDIO,	MII),
> +	MFP_XWAY(GPIO20, GPIO,	JTAG,	SDIO,	MII),
> +	MFP_XWAY(GPIO21, GPIO,	PCI,	EBU,	GPT),
> +	MFP_XWAY(GPIO22, GPIO,	SPI,	MCD,	MII),
> +	MFP_XWAY(GPIO23, GPIO,	EBU,	PCI,	STP),
> +	MFP_XWAY(GPIO24, GPIO,	EBU,	TDM,	PCI),
> +	MFP_XWAY(GPIO25, GPIO,	TDM,	SDIO,	ASC),
> +	MFP_XWAY(GPIO26, GPIO,	EBU,	TDM,	SDIO),
> +	MFP_XWAY(GPIO27, GPIO,	TDM,	SDIO,	ASC),
> +	MFP_XWAY(GPIO28, GPIO,	GPT,	MII,	SDIO),
> +	MFP_XWAY(GPIO29, GPIO,	PCI,	CBUS,	MII),
> +	MFP_XWAY(GPIO30, GPIO,	PCI,	CBUS,	MII),
> +	MFP_XWAY(GPIO31, GPIO,	EBU,	PCI,	MII),
> +};
> +
> +static const unsigned danube_exin_pin_map[] = {GPIO0, GPIO1, GPIO2};
> +
> +static const unsigned danube_pins_exin0[] = {GPIO0};
> +static const unsigned danube_pins_exin1[] = {GPIO1};
> +static const unsigned danube_pins_exin2[] = {GPIO2};
> +
> +static const unsigned danube_pins_jtag[] = {GPIO15, GPIO16, GPIO17, GPIO18, GPIO20};
> +static const unsigned danube_pins_asc0[] = {GPIO11, GPIO12};
> +static const unsigned danube_pins_asc0_cts_rts[] = {GPIO9, GPIO10};
> +static const unsigned danube_pins_stp[] = {GPIO4, GPIO5, GPIO6};
> +static const unsigned danube_pins_nmi[] = {GPIO8};
> +
> +static const unsigned danube_pins_dfe_led0[] = {GPIO4};
> +static const unsigned danube_pins_dfe_led1[] = {GPIO5};
> +
> +static const unsigned danube_pins_ebu_a24[] = {GPIO13};
> +static const unsigned danube_pins_ebu_clk[] = {GPIO21};
> +static const unsigned danube_pins_ebu_cs1[] = {GPIO23};
> +static const unsigned danube_pins_ebu_a23[] = {GPIO24};
> +static const unsigned danube_pins_ebu_wait[] = {GPIO26};
> +static const unsigned danube_pins_ebu_a25[] = {GPIO31};
> +
> +static const unsigned danube_pins_nand_ale[] = {GPIO13};
> +static const unsigned danube_pins_nand_cs1[] = {GPIO23};
> +static const unsigned danube_pins_nand_cle[] = {GPIO24};
> +
> +static const unsigned danube_pins_spi_di[] = {GPIO16};
> +static const unsigned danube_pins_spi_do[] = {GPIO17};
> +static const unsigned danube_pins_spi_clk[] = {GPIO18};
> +static const unsigned danube_pins_spi_cs1[] = {GPIO15};
> +static const unsigned danube_pins_spi_cs2[] = {GPIO21};
> +static const unsigned danube_pins_spi_cs3[] = {GPIO13};
> +static const unsigned danube_pins_spi_cs4[] = {GPIO10};
> +static const unsigned danube_pins_spi_cs5[] = {GPIO9};
> +static const unsigned danube_pins_spi_cs6[] = {GPIO11};
> +
> +static const unsigned danube_pins_gpt1[] = {GPIO28};
> +static const unsigned danube_pins_gpt2[] = {GPIO21};
> +static const unsigned danube_pins_gpt3[] = {GPIO6};
> +
> +static const unsigned danube_pins_clkout0[] = {GPIO8};
> +static const unsigned danube_pins_clkout1[] = {GPIO7};
> +static const unsigned danube_pins_clkout2[] = {GPIO3};
> +static const unsigned danube_pins_clkout3[] = {GPIO2};
> +
> +static const unsigned danube_pins_pci_gnt1[] = {GPIO30};
> +static const unsigned danube_pins_pci_gnt2[] = {GPIO23};
> +static const unsigned danube_pins_pci_gnt3[] = {GPIO19};
> +static const unsigned danube_pins_pci_req1[] = {GPIO29};
> +static const unsigned danube_pins_pci_req2[] = {GPIO31};
> +static const unsigned danube_pins_pci_req3[] = {GPIO3};
> +
> +static const struct ltq_pin_group danube_grps[] = {
> +	GRP_MUX("exin0", EXIN, danube_pins_exin0),
> +	GRP_MUX("exin1", EXIN, danube_pins_exin1),
> +	GRP_MUX("exin2", EXIN, danube_pins_exin2),
> +	GRP_MUX("jtag", JTAG, danube_pins_jtag),
> +	GRP_MUX("ebu a23", EBU, danube_pins_ebu_a23),
> +	GRP_MUX("ebu a24", EBU, danube_pins_ebu_a24),
> +	GRP_MUX("ebu a25", EBU, danube_pins_ebu_a25),
> +	GRP_MUX("ebu clk", EBU, danube_pins_ebu_clk),
> +	GRP_MUX("ebu cs1", EBU, danube_pins_ebu_cs1),
> +	GRP_MUX("ebu wait", EBU, danube_pins_ebu_wait),
> +	GRP_MUX("nand ale", EBU, danube_pins_nand_ale),
> +	GRP_MUX("nand cs1", EBU, danube_pins_nand_cs1),
> +	GRP_MUX("nand cle", EBU, danube_pins_nand_cle),
> +	GRP_MUX("spi_di", SPI, danube_pins_spi_di),
> +	GRP_MUX("spi_do", SPI, danube_pins_spi_do),
> +	GRP_MUX("spi_clk", SPI, danube_pins_spi_clk),
> +	GRP_MUX("spi_cs1", SPI, danube_pins_spi_cs1),
> +	GRP_MUX("spi_cs2", SPI, danube_pins_spi_cs2),
> +	GRP_MUX("spi_cs3", SPI, danube_pins_spi_cs3),
> +	GRP_MUX("spi_cs4", SPI, danube_pins_spi_cs4),
> +	GRP_MUX("spi_cs5", SPI, danube_pins_spi_cs5),
> +	GRP_MUX("spi_cs6", SPI, danube_pins_spi_cs6),
> +	GRP_MUX("asc0", ASC, danube_pins_asc0),
> +	GRP_MUX("asc0 cts rts", ASC, danube_pins_asc0_cts_rts),
> +	GRP_MUX("stp", STP, danube_pins_stp),
> +	GRP_MUX("nmi", NMI, danube_pins_nmi),
> +	GRP_MUX("gpt1", GPT, danube_pins_gpt1),
> +	GRP_MUX("gpt2", GPT, danube_pins_gpt2),
> +	GRP_MUX("gpt3", GPT, danube_pins_gpt3),
> +	GRP_MUX("clkout0", CGU, danube_pins_clkout0),
> +	GRP_MUX("clkout1", CGU, danube_pins_clkout1),
> +	GRP_MUX("clkout2", CGU, danube_pins_clkout2),
> +	GRP_MUX("clkout3", CGU, danube_pins_clkout3),
> +	GRP_MUX("gnt1", PCI, danube_pins_pci_gnt1),
> +	GRP_MUX("gnt2", PCI, danube_pins_pci_gnt2),
> +	GRP_MUX("gnt3", PCI, danube_pins_pci_gnt3),
> +	GRP_MUX("req1", PCI, danube_pins_pci_req1),
> +	GRP_MUX("req2", PCI, danube_pins_pci_req2),
> +	GRP_MUX("req3", PCI, danube_pins_pci_req3),
> +	GRP_MUX("dfe led0", DFE, danube_pins_dfe_led0),
> +	GRP_MUX("dfe led1", DFE, danube_pins_dfe_led1),
> +};
> +
> +static const char * const danube_pci_grps[] = {"gnt1", "gnt2",
> +						"gnt3", "req1",
> +						"req2", "req3"};
> +static const char * const danube_spi_grps[] = {"spi_di", "spi_do",
> +						"spi_clk", "spi_cs1",
> +						"spi_cs2", "spi_cs3",
> +						"spi_cs4", "spi_cs5",
> +						"spi_cs6"};
> +static const char * const danube_cgu_grps[] = {"clkout0", "clkout1",
> +						"clkout2", "clkout3"};
> +static const char * const danube_ebu_grps[] = {"ebu a23", "ebu a24",
> +						"ebu a25", "ebu cs1",
> +						"ebu wait", "ebu clk",
> +						"nand ale", "nand cs1",
> +						"nand cle"};
> +static const char * const danube_dfe_grps[] = {"dfe led0", "dfe led1"};
> +static const char * const danube_exin_grps[] = {"exin0", "exin1", "exin2"};
> +static const char * const danube_gpt_grps[] = {"gpt1", "gpt2", "gpt3"};
> +static const char * const danube_asc_grps[] = {"asc0", "asc0 cts rts"};
> +static const char * const danube_jtag_grps[] = {"jtag"};
> +static const char * const danube_stp_grps[] = {"stp"};
> +static const char * const danube_nmi_grps[] = {"nmi"};
> +
> +static const struct ltq_pmx_func danube_funcs[] = {
> +	{"spi",		ARRAY_AND_SIZE(danube_spi_grps)},
> +	{"asc",		ARRAY_AND_SIZE(danube_asc_grps)},
> +	{"cgu",		ARRAY_AND_SIZE(danube_cgu_grps)},
> +	{"jtag",	ARRAY_AND_SIZE(danube_jtag_grps)},
> +	{"exin",	ARRAY_AND_SIZE(danube_exin_grps)},
> +	{"stp",		ARRAY_AND_SIZE(danube_stp_grps)},
> +	{"gpt",		ARRAY_AND_SIZE(danube_gpt_grps)},
> +	{"nmi",		ARRAY_AND_SIZE(danube_nmi_grps)},
> +	{"pci",		ARRAY_AND_SIZE(danube_pci_grps)},
> +	{"ebu",		ARRAY_AND_SIZE(danube_ebu_grps)},
> +	{"dfe",		ARRAY_AND_SIZE(danube_dfe_grps)},
> +};
> +
> +/* ---------  xrx100 related code --------- */
> +#define XRX100_MAX_PIN		56
> +
> +static const struct ltq_mfp_pin xrx100_mfp[] = {
> +	/*       pin    f0	f1	f2	f3   */
> +	MFP_XWAY(GPIO0, GPIO,	EXIN,	SDIO,	TDM),
> +	MFP_XWAY(GPIO1, GPIO,	EXIN,	CBUS,	SIN),
> +	MFP_XWAY(GPIO2, GPIO,	CGU,	EXIN,	NONE),
> +	MFP_XWAY(GPIO3, GPIO,	CGU,	SDIO,	PCI),
> +	MFP_XWAY(GPIO4, GPIO,	STP,	DFE,	ASC),
> +	MFP_XWAY(GPIO5, GPIO,	STP,	NONE,	DFE),
> +	MFP_XWAY(GPIO6, GPIO,	STP,	GPT,	ASC),
> +	MFP_XWAY(GPIO7, GPIO,	CGU,	CBUS,	NONE),
> +	MFP_XWAY(GPIO8, GPIO,	CGU,	NMI,	NONE),
> +	MFP_XWAY(GPIO9, GPIO,	ASC,	SPI,	EXIN),
> +	MFP_XWAY(GPIO10, GPIO,	ASC,	SPI,	EXIN),
> +	MFP_XWAY(GPIO11, GPIO,	ASC,	CBUS,	SPI),
> +	MFP_XWAY(GPIO12, GPIO,	ASC,	CBUS,	MCD),
> +	MFP_XWAY(GPIO13, GPIO,	EBU,	SPI,	NONE),
> +	MFP_XWAY(GPIO14, GPIO,	CGU,	NONE,	NONE),
> +	MFP_XWAY(GPIO15, GPIO,	SPI,	SDIO,	MCD),
> +	MFP_XWAY(GPIO16, GPIO,	SPI,	SDIO,	NONE),
> +	MFP_XWAY(GPIO17, GPIO,	SPI,	SDIO,	NONE),
> +	MFP_XWAY(GPIO18, GPIO,	SPI,	SDIO,	NONE),
> +	MFP_XWAY(GPIO19, GPIO,	PCI,	SDIO,	CGU),
> +	MFP_XWAY(GPIO20, GPIO,	NONE,	SDIO,	EBU),
> +	MFP_XWAY(GPIO21, GPIO,	PCI,	EBU,	GPT),
> +	MFP_XWAY(GPIO22, GPIO,	SPI,	NONE,	EBU),
> +	MFP_XWAY(GPIO23, GPIO,	EBU,	PCI,	STP),
> +	MFP_XWAY(GPIO24, GPIO,	EBU,	TDM,	PCI),
> +	MFP_XWAY(GPIO25, GPIO,	TDM,	SDIO,	ASC),
> +	MFP_XWAY(GPIO26, GPIO,	EBU,	TDM,	SDIO),
> +	MFP_XWAY(GPIO27, GPIO,	TDM,	SDIO,	ASC),
> +	MFP_XWAY(GPIO28, GPIO,	GPT,	NONE,	SDIO),
> +	MFP_XWAY(GPIO29, GPIO,	PCI,	CBUS,	NONE),
> +	MFP_XWAY(GPIO30, GPIO,	PCI,	CBUS,	NONE),
> +	MFP_XWAY(GPIO31, GPIO,	EBU,	PCI,	NONE),
> +	MFP_XWAY(GPIO32, GPIO,	MII,	NONE,	EBU),
> +	MFP_XWAY(GPIO33, GPIO,	MII,	NONE,	EBU),
> +	MFP_XWAY(GPIO34, GPIO,	SIN,	SSI,	NONE),
> +	MFP_XWAY(GPIO35, GPIO,	SIN,	SSI,	NONE),
> +	MFP_XWAY(GPIO36, GPIO,	SIN,	SSI,	NONE),
> +	MFP_XWAY(GPIO37, GPIO,	PCI,	NONE,	NONE),
> +	MFP_XWAY(GPIO38, GPIO,	PCI,	NONE,	NONE),
> +	MFP_XWAY(GPIO39, GPIO,	NONE,	EXIN,	NONE),
> +	MFP_XWAY(GPIO40, GPIO,	MII,	TDM,	NONE),
> +	MFP_XWAY(GPIO41, GPIO,	MII,	TDM,	NONE),
> +	MFP_XWAY(GPIO42, GPIO,	MDIO,	NONE,	NONE),
> +	MFP_XWAY(GPIO43, GPIO,	MDIO,	NONE,	NONE),
> +	MFP_XWAY(GPIO44, GPIO,	MII,	SIN,	NONE),
> +	MFP_XWAY(GPIO45, GPIO,	MII,	NONE,	SIN),
> +	MFP_XWAY(GPIO46, GPIO,	MII,	NONE,	EXIN),
> +	MFP_XWAY(GPIO47, GPIO,	MII,	NONE,	SIN),
> +	MFP_XWAY(GPIO48, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO49, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO50, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO51, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO52, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO53, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO54, GPIO,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO55, GPIO,	NONE,	NONE,	NONE),
> +};
> +
> +static const unsigned xrx100_exin_pin_map[] = {GPIO0, GPIO1, GPIO2, GPIO39, GPIO10, GPIO9};
> +
> +static const unsigned xrx100_pins_exin0[] = {GPIO0};
> +static const unsigned xrx100_pins_exin1[] = {GPIO1};
> +static const unsigned xrx100_pins_exin2[] = {GPIO2};
> +static const unsigned xrx100_pins_exin3[] = {GPIO39};
> +static const unsigned xrx100_pins_exin4[] = {GPIO10};
> +static const unsigned xrx100_pins_exin5[] = {GPIO9};
> +
> +static const unsigned xrx100_pins_asc0[] = {GPIO11, GPIO12};
> +static const unsigned xrx100_pins_asc0_cts_rts[] = {GPIO9, GPIO10};
> +static const unsigned xrx100_pins_stp[] = {GPIO4, GPIO5, GPIO6};
> +static const unsigned xrx100_pins_nmi[] = {GPIO8};
> +static const unsigned xrx100_pins_mdio[] = {GPIO42, GPIO43};
> +
> +static const unsigned xrx100_pins_dfe_led0[] = {GPIO4};
> +static const unsigned xrx100_pins_dfe_led1[] = {GPIO5};
> +
> +static const unsigned xrx100_pins_ebu_a24[] = {GPIO13};
> +static const unsigned xrx100_pins_ebu_clk[] = {GPIO21};
> +static const unsigned xrx100_pins_ebu_cs1[] = {GPIO23};
> +static const unsigned xrx100_pins_ebu_a23[] = {GPIO24};
> +static const unsigned xrx100_pins_ebu_wait[] = {GPIO26};
> +static const unsigned xrx100_pins_ebu_a25[] = {GPIO31};
> +
> +static const unsigned xrx100_pins_nand_ale[] = {GPIO13};
> +static const unsigned xrx100_pins_nand_cs1[] = {GPIO23};
> +static const unsigned xrx100_pins_nand_cle[] = {GPIO24};
> +static const unsigned xrx100_pins_nand_rdy[] = {GPIO48};
> +static const unsigned xrx100_pins_nand_rd[] = {GPIO49};
> +
> +static const unsigned xrx100_pins_spi_di[] = {GPIO16};
> +static const unsigned xrx100_pins_spi_do[] = {GPIO17};
> +static const unsigned xrx100_pins_spi_clk[] = {GPIO18};
> +static const unsigned xrx100_pins_spi_cs1[] = {GPIO15};
> +static const unsigned xrx100_pins_spi_cs2[] = {GPIO22};
> +static const unsigned xrx100_pins_spi_cs3[] = {GPIO13};
> +static const unsigned xrx100_pins_spi_cs4[] = {GPIO10};
> +static const unsigned xrx100_pins_spi_cs5[] = {GPIO9};
> +static const unsigned xrx100_pins_spi_cs6[] = {GPIO11};
> +
> +static const unsigned xrx100_pins_gpt1[] = {GPIO28};
> +static const unsigned xrx100_pins_gpt2[] = {GPIO21};
> +static const unsigned xrx100_pins_gpt3[] = {GPIO6};
> +
> +static const unsigned xrx100_pins_clkout0[] = {GPIO8};
> +static const unsigned xrx100_pins_clkout1[] = {GPIO7};
> +static const unsigned xrx100_pins_clkout2[] = {GPIO3};
> +static const unsigned xrx100_pins_clkout3[] = {GPIO2};
> +
> +static const unsigned xrx100_pins_pci_gnt1[] = {GPIO30};
> +static const unsigned xrx100_pins_pci_gnt2[] = {GPIO23};
> +static const unsigned xrx100_pins_pci_gnt3[] = {GPIO19};
> +static const unsigned xrx100_pins_pci_gnt4[] = {GPIO38};
> +static const unsigned xrx100_pins_pci_req1[] = {GPIO29};
> +static const unsigned xrx100_pins_pci_req2[] = {GPIO31};
> +static const unsigned xrx100_pins_pci_req3[] = {GPIO3};
> +static const unsigned xrx100_pins_pci_req4[] = {GPIO37};
> +
> +static const struct ltq_pin_group xrx100_grps[] = {
> +	GRP_MUX("exin0", EXIN, xrx100_pins_exin0),
> +	GRP_MUX("exin1", EXIN, xrx100_pins_exin1),
> +	GRP_MUX("exin2", EXIN, xrx100_pins_exin2),
> +	GRP_MUX("exin3", EXIN, xrx100_pins_exin3),
> +	GRP_MUX("exin4", EXIN, xrx100_pins_exin4),
> +	GRP_MUX("exin5", EXIN, xrx100_pins_exin5),
> +	GRP_MUX("ebu a23", EBU, xrx100_pins_ebu_a23),
> +	GRP_MUX("ebu a24", EBU, xrx100_pins_ebu_a24),
> +	GRP_MUX("ebu a25", EBU, xrx100_pins_ebu_a25),
> +	GRP_MUX("ebu clk", EBU, xrx100_pins_ebu_clk),
> +	GRP_MUX("ebu cs1", EBU, xrx100_pins_ebu_cs1),
> +	GRP_MUX("ebu wait", EBU, xrx100_pins_ebu_wait),
> +	GRP_MUX("nand ale", EBU, xrx100_pins_nand_ale),
> +	GRP_MUX("nand cs1", EBU, xrx100_pins_nand_cs1),
> +	GRP_MUX("nand cle", EBU, xrx100_pins_nand_cle),
> +	GRP_MUX("nand rdy", EBU, xrx100_pins_nand_rdy),
> +	GRP_MUX("nand rd", EBU, xrx100_pins_nand_rd),
> +	GRP_MUX("spi_di", SPI, xrx100_pins_spi_di),
> +	GRP_MUX("spi_do", SPI, xrx100_pins_spi_do),
> +	GRP_MUX("spi_clk", SPI, xrx100_pins_spi_clk),
> +	GRP_MUX("spi_cs1", SPI, xrx100_pins_spi_cs1),
> +	GRP_MUX("spi_cs2", SPI, xrx100_pins_spi_cs2),
> +	GRP_MUX("spi_cs3", SPI, xrx100_pins_spi_cs3),
> +	GRP_MUX("spi_cs4", SPI, xrx100_pins_spi_cs4),
> +	GRP_MUX("spi_cs5", SPI, xrx100_pins_spi_cs5),
> +	GRP_MUX("spi_cs6", SPI, xrx100_pins_spi_cs6),
> +	GRP_MUX("asc0", ASC, xrx100_pins_asc0),
> +	GRP_MUX("asc0 cts rts", ASC, xrx100_pins_asc0_cts_rts),
> +	GRP_MUX("stp", STP, xrx100_pins_stp),
> +	GRP_MUX("nmi", NMI, xrx100_pins_nmi),
> +	GRP_MUX("gpt1", GPT, xrx100_pins_gpt1),
> +	GRP_MUX("gpt2", GPT, xrx100_pins_gpt2),
> +	GRP_MUX("gpt3", GPT, xrx100_pins_gpt3),
> +	GRP_MUX("clkout0", CGU, xrx100_pins_clkout0),
> +	GRP_MUX("clkout1", CGU, xrx100_pins_clkout1),
> +	GRP_MUX("clkout2", CGU, xrx100_pins_clkout2),
> +	GRP_MUX("clkout3", CGU, xrx100_pins_clkout3),
> +	GRP_MUX("gnt1", PCI, xrx100_pins_pci_gnt1),
> +	GRP_MUX("gnt2", PCI, xrx100_pins_pci_gnt2),
> +	GRP_MUX("gnt3", PCI, xrx100_pins_pci_gnt3),
> +	GRP_MUX("gnt4", PCI, xrx100_pins_pci_gnt4),
> +	GRP_MUX("req1", PCI, xrx100_pins_pci_req1),
> +	GRP_MUX("req2", PCI, xrx100_pins_pci_req2),
> +	GRP_MUX("req3", PCI, xrx100_pins_pci_req3),
> +	GRP_MUX("req4", PCI, xrx100_pins_pci_req4),
> +	GRP_MUX("mdio", MDIO, xrx100_pins_mdio),
> +	GRP_MUX("dfe led0", DFE, xrx100_pins_dfe_led0),
> +	GRP_MUX("dfe led1", DFE, xrx100_pins_dfe_led1),
> +};
> +
> +static const char * const xrx100_pci_grps[] = {"gnt1", "gnt2",
> +						"gnt3", "gnt4",
> +						"req1", "req2",
> +						"req3", "req4"};
> +static const char * const xrx100_spi_grps[] = {"spi_di", "spi_do",
> +						"spi_clk", "spi_cs1",
> +						"spi_cs2", "spi_cs3",
> +						"spi_cs4", "spi_cs5",
> +						"spi_cs6"};
> +static const char * const xrx100_cgu_grps[] = {"clkout0", "clkout1",
> +						"clkout2", "clkout3"};
> +static const char * const xrx100_ebu_grps[] = {"ebu a23", "ebu a24",
> +						"ebu a25", "ebu cs1",
> +						"ebu wait", "ebu clk",
> +						"nand ale", "nand cs1",
> +						"nand cle", "nand rdy",
> +						"nand rd"};
> +static const char * const xrx100_exin_grps[] = {"exin0", "exin1", "exin2",
> +						"exin3", "exin4", "exin5"};
> +static const char * const xrx100_gpt_grps[] = {"gpt1", "gpt2", "gpt3"};
> +static const char * const xrx100_asc_grps[] = {"asc0", "asc0 cts rts"};
> +static const char * const xrx100_stp_grps[] = {"stp"};
> +static const char * const xrx100_nmi_grps[] = {"nmi"};
> +static const char * const xrx100_mdio_grps[] = {"mdio"};
> +static const char * const xrx100_dfe_grps[] = {"dfe led0", "dfe led1"};
> +
> +static const struct ltq_pmx_func xrx100_funcs[] = {
> +	{"spi",		ARRAY_AND_SIZE(xrx100_spi_grps)},
> +	{"asc",		ARRAY_AND_SIZE(xrx100_asc_grps)},
> +	{"cgu",		ARRAY_AND_SIZE(xrx100_cgu_grps)},
> +	{"exin",	ARRAY_AND_SIZE(xrx100_exin_grps)},
> +	{"stp",		ARRAY_AND_SIZE(xrx100_stp_grps)},
> +	{"gpt",		ARRAY_AND_SIZE(xrx100_gpt_grps)},
> +	{"nmi",		ARRAY_AND_SIZE(xrx100_nmi_grps)},
> +	{"pci",		ARRAY_AND_SIZE(xrx100_pci_grps)},
> +	{"ebu",		ARRAY_AND_SIZE(xrx100_ebu_grps)},
> +	{"mdio",	ARRAY_AND_SIZE(xrx100_mdio_grps)},
> +	{"dfe",		ARRAY_AND_SIZE(xrx100_dfe_grps)},
> +};
> +
> +/* ---------  xrx200 related code --------- */
> +#define XRX200_MAX_PIN		50
> +
> +static const struct ltq_mfp_pin xrx200_mfp[] = {
> +	/*       pin    f0	f1	f2	f3   */
> +	MFP_XWAY(GPIO0, GPIO,	EXIN,	SDIO,	TDM),
> +	MFP_XWAY(GPIO1, GPIO,	EXIN,	CBUS,	SIN),
> +	MFP_XWAY(GPIO2, GPIO,	CGU,	EXIN,	GPHY),
> +	MFP_XWAY(GPIO3, GPIO,	CGU,	SDIO,	PCI),
> +	MFP_XWAY(GPIO4, GPIO,	STP,	DFE,	USIF),
> +	MFP_XWAY(GPIO5, GPIO,	STP,	GPHY,	DFE),
> +	MFP_XWAY(GPIO6, GPIO,	STP,	GPT,	USIF),
> +	MFP_XWAY(GPIO7, GPIO,	CGU,	CBUS,	GPHY),
> +	MFP_XWAY(GPIO8, GPIO,	CGU,	NMI,	NONE),
> +	MFP_XWAY(GPIO9, GPIO,	USIF,	SPI,	EXIN),
> +	MFP_XWAY(GPIO10, GPIO,	USIF,	SPI,	EXIN),
> +	MFP_XWAY(GPIO11, GPIO,	USIF,	CBUS,	SPI),
> +	MFP_XWAY(GPIO12, GPIO,	USIF,	CBUS,	MCD),
> +	MFP_XWAY(GPIO13, GPIO,	EBU,	SPI,	NONE),
> +	MFP_XWAY(GPIO14, GPIO,	CGU,	CBUS,	USIF),
> +	MFP_XWAY(GPIO15, GPIO,	SPI,	SDIO,	MCD),
> +	MFP_XWAY(GPIO16, GPIO,	SPI,	SDIO,	NONE),
> +	MFP_XWAY(GPIO17, GPIO,	SPI,	SDIO,	NONE),
> +	MFP_XWAY(GPIO18, GPIO,	SPI,	SDIO,	NONE),
> +	MFP_XWAY(GPIO19, GPIO,	PCI,	SDIO,	CGU),
> +	MFP_XWAY(GPIO20, GPIO,	NONE,	SDIO,	EBU),
> +	MFP_XWAY(GPIO21, GPIO,	PCI,	EBU,	GPT),
> +	MFP_XWAY(GPIO22, GPIO,	SPI,	CGU,	EBU),
> +	MFP_XWAY(GPIO23, GPIO,	EBU,	PCI,	STP),
> +	MFP_XWAY(GPIO24, GPIO,	EBU,	TDM,	PCI),
> +	MFP_XWAY(GPIO25, GPIO,	TDM,	SDIO,	USIF),
> +	MFP_XWAY(GPIO26, GPIO,	EBU,	TDM,	SDIO),
> +	MFP_XWAY(GPIO27, GPIO,	TDM,	SDIO,	USIF),
> +	MFP_XWAY(GPIO28, GPIO,	GPT,	PCI,	SDIO),
> +	MFP_XWAY(GPIO29, GPIO,	PCI,	CBUS,	EXIN),
> +	MFP_XWAY(GPIO30, GPIO,	PCI,	CBUS,	NONE),
> +	MFP_XWAY(GPIO31, GPIO,	EBU,	PCI,	NONE),
> +	MFP_XWAY(GPIO32, GPIO,	MII,	NONE,	EBU),
> +	MFP_XWAY(GPIO33, GPIO,	MII,	NONE,	EBU),
> +	MFP_XWAY(GPIO34, GPIO,	SIN,	SSI,	NONE),
> +	MFP_XWAY(GPIO35, GPIO,	SIN,	SSI,	NONE),
> +	MFP_XWAY(GPIO36, GPIO,	SIN,	SSI,	EXIN),
> +	MFP_XWAY(GPIO37, GPIO,	USIF,	NONE,	PCI),
> +	MFP_XWAY(GPIO38, GPIO,	PCI,	USIF,	NONE),
> +	MFP_XWAY(GPIO39, GPIO,	USIF,	EXIN,	NONE),
> +	MFP_XWAY(GPIO40, GPIO,	MII,	TDM,	NONE),
> +	MFP_XWAY(GPIO41, GPIO,	MII,	TDM,	NONE),
> +	MFP_XWAY(GPIO42, GPIO,	MDIO,	NONE,	NONE),
> +	MFP_XWAY(GPIO43, GPIO,	MDIO,	NONE,	NONE),
> +	MFP_XWAY(GPIO44, GPIO,	MII,	SIN,	GPHY),
> +	MFP_XWAY(GPIO45, GPIO,	MII,	GPHY,	SIN),
> +	MFP_XWAY(GPIO46, GPIO,	MII,	NONE,	EXIN),
> +	MFP_XWAY(GPIO47, GPIO,	MII,	GPHY,	SIN),
> +	MFP_XWAY(GPIO48, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO49, GPIO,	EBU,	NONE,	NONE),
> +};
> +
> +static const unsigned xrx200_exin_pin_map[] = {GPIO0, GPIO1, GPIO2, GPIO39, GPIO10, GPIO9};
> +
> +static const unsigned xrx200_pins_exin0[] = {GPIO0};
> +static const unsigned xrx200_pins_exin1[] = {GPIO1};
> +static const unsigned xrx200_pins_exin2[] = {GPIO2};
> +static const unsigned xrx200_pins_exin3[] = {GPIO39};
> +static const unsigned xrx200_pins_exin4[] = {GPIO10};
> +static const unsigned xrx200_pins_exin5[] = {GPIO9};
> +
> +static const unsigned xrx200_pins_usif_uart_rx[] = {GPIO11};
> +static const unsigned xrx200_pins_usif_uart_tx[] = {GPIO12};
> +static const unsigned xrx200_pins_usif_uart_rts[] = {GPIO9};
> +static const unsigned xrx200_pins_usif_uart_cts[] = {GPIO10};
> +static const unsigned xrx200_pins_usif_uart_dtr[] = {GPIO4};
> +static const unsigned xrx200_pins_usif_uart_dsr[] = {GPIO6};
> +static const unsigned xrx200_pins_usif_uart_dcd[] = {GPIO25};
> +static const unsigned xrx200_pins_usif_uart_ri[] = {GPIO27};
> +
> +static const unsigned xrx200_pins_usif_spi_di[] = {GPIO11};
> +static const unsigned xrx200_pins_usif_spi_do[] = {GPIO12};
> +static const unsigned xrx200_pins_usif_spi_clk[] = {GPIO38};
> +static const unsigned xrx200_pins_usif_spi_cs0[] = {GPIO37};
> +static const unsigned xrx200_pins_usif_spi_cs1[] = {GPIO39};
> +static const unsigned xrx200_pins_usif_spi_cs2[] = {GPIO14};
> +
> +static const unsigned xrx200_pins_stp[] = {GPIO4, GPIO5, GPIO6};
> +static const unsigned xrx200_pins_nmi[] = {GPIO8};
> +static const unsigned xrx200_pins_mdio[] = {GPIO42, GPIO43};
> +
> +static const unsigned xrx200_pins_dfe_led0[] = {GPIO4};
> +static const unsigned xrx200_pins_dfe_led1[] = {GPIO5};
> +
> +static const unsigned xrx200_pins_gphy0_led0[] = {GPIO5};
> +static const unsigned xrx200_pins_gphy0_led1[] = {GPIO7};
> +static const unsigned xrx200_pins_gphy0_led2[] = {GPIO2};
> +static const unsigned xrx200_pins_gphy1_led0[] = {GPIO44};
> +static const unsigned xrx200_pins_gphy1_led1[] = {GPIO45};
> +static const unsigned xrx200_pins_gphy1_led2[] = {GPIO47};
> +
> +static const unsigned xrx200_pins_ebu_a24[] = {GPIO13};
> +static const unsigned xrx200_pins_ebu_clk[] = {GPIO21};
> +static const unsigned xrx200_pins_ebu_cs1[] = {GPIO23};
> +static const unsigned xrx200_pins_ebu_a23[] = {GPIO24};
> +static const unsigned xrx200_pins_ebu_wait[] = {GPIO26};
> +static const unsigned xrx200_pins_ebu_a25[] = {GPIO31};
> +
> +static const unsigned xrx200_pins_nand_ale[] = {GPIO13};
> +static const unsigned xrx200_pins_nand_cs1[] = {GPIO23};
> +static const unsigned xrx200_pins_nand_cle[] = {GPIO24};
> +static const unsigned xrx200_pins_nand_rdy[] = {GPIO48};
> +static const unsigned xrx200_pins_nand_rd[] = {GPIO49};
> +
> +static const unsigned xrx200_pins_spi_di[] = {GPIO16};
> +static const unsigned xrx200_pins_spi_do[] = {GPIO17};
> +static const unsigned xrx200_pins_spi_clk[] = {GPIO18};
> +static const unsigned xrx200_pins_spi_cs1[] = {GPIO15};
> +static const unsigned xrx200_pins_spi_cs2[] = {GPIO22};
> +static const unsigned xrx200_pins_spi_cs3[] = {GPIO13};
> +static const unsigned xrx200_pins_spi_cs4[] = {GPIO10};
> +static const unsigned xrx200_pins_spi_cs5[] = {GPIO9};
> +static const unsigned xrx200_pins_spi_cs6[] = {GPIO11};
> +
> +static const unsigned xrx200_pins_gpt1[] = {GPIO28};
> +static const unsigned xrx200_pins_gpt2[] = {GPIO21};
> +static const unsigned xrx200_pins_gpt3[] = {GPIO6};
> +
> +static const unsigned xrx200_pins_clkout0[] = {GPIO8};
> +static const unsigned xrx200_pins_clkout1[] = {GPIO7};
> +static const unsigned xrx200_pins_clkout2[] = {GPIO3};
> +static const unsigned xrx200_pins_clkout3[] = {GPIO2};
> +
> +static const unsigned xrx200_pins_pci_gnt1[] = {GPIO28};
> +static const unsigned xrx200_pins_pci_gnt2[] = {GPIO23};
> +static const unsigned xrx200_pins_pci_gnt3[] = {GPIO19};
> +static const unsigned xrx200_pins_pci_gnt4[] = {GPIO38};
> +static const unsigned xrx200_pins_pci_req1[] = {GPIO29};
> +static const unsigned xrx200_pins_pci_req2[] = {GPIO31};
> +static const unsigned xrx200_pins_pci_req3[] = {GPIO3};
> +static const unsigned xrx200_pins_pci_req4[] = {GPIO37};
> +
> +static const struct ltq_pin_group xrx200_grps[] = {
> +	GRP_MUX("exin0", EXIN, xrx200_pins_exin0),
> +	GRP_MUX("exin1", EXIN, xrx200_pins_exin1),
> +	GRP_MUX("exin2", EXIN, xrx200_pins_exin2),
> +	GRP_MUX("exin3", EXIN, xrx200_pins_exin3),
> +	GRP_MUX("exin4", EXIN, xrx200_pins_exin4),
> +	GRP_MUX("exin5", EXIN, xrx200_pins_exin5),
> +	GRP_MUX("ebu a23", EBU, xrx200_pins_ebu_a23),
> +	GRP_MUX("ebu a24", EBU, xrx200_pins_ebu_a24),
> +	GRP_MUX("ebu a25", EBU, xrx200_pins_ebu_a25),
> +	GRP_MUX("ebu clk", EBU, xrx200_pins_ebu_clk),
> +	GRP_MUX("ebu cs1", EBU, xrx200_pins_ebu_cs1),
> +	GRP_MUX("ebu wait", EBU, xrx200_pins_ebu_wait),
> +	GRP_MUX("nand ale", EBU, xrx200_pins_nand_ale),
> +	GRP_MUX("nand cs1", EBU, xrx200_pins_nand_cs1),
> +	GRP_MUX("nand cle", EBU, xrx200_pins_nand_cle),
> +	GRP_MUX("nand rdy", EBU, xrx200_pins_nand_rdy),
> +	GRP_MUX("nand rd", EBU, xrx200_pins_nand_rd),
> +	GRP_MUX("spi_di", SPI, xrx200_pins_spi_di),
> +	GRP_MUX("spi_do", SPI, xrx200_pins_spi_do),
> +	GRP_MUX("spi_clk", SPI, xrx200_pins_spi_clk),
> +	GRP_MUX("spi_cs1", SPI, xrx200_pins_spi_cs1),
> +	GRP_MUX("spi_cs2", SPI, xrx200_pins_spi_cs2),
> +	GRP_MUX("spi_cs3", SPI, xrx200_pins_spi_cs3),
> +	GRP_MUX("spi_cs4", SPI, xrx200_pins_spi_cs4),
> +	GRP_MUX("spi_cs5", SPI, xrx200_pins_spi_cs5),
> +	GRP_MUX("spi_cs6", SPI, xrx200_pins_spi_cs6),
> +	GRP_MUX("usif uart_rx", USIF, xrx200_pins_usif_uart_rx),
> +	GRP_MUX("usif uart_rx", USIF, xrx200_pins_usif_uart_tx),
> +	GRP_MUX("usif uart_rts", USIF, xrx200_pins_usif_uart_rts),
> +	GRP_MUX("usif uart_cts", USIF, xrx200_pins_usif_uart_cts),
> +	GRP_MUX("usif uart_dtr", USIF, xrx200_pins_usif_uart_dtr),
> +	GRP_MUX("usif uart_dsr", USIF, xrx200_pins_usif_uart_dsr),
> +	GRP_MUX("usif uart_dcd", USIF, xrx200_pins_usif_uart_dcd),
> +	GRP_MUX("usif uart_ri", USIF, xrx200_pins_usif_uart_ri),
> +	GRP_MUX("usif spi_di", USIF, xrx200_pins_usif_spi_di),
> +	GRP_MUX("usif spi_do", USIF, xrx200_pins_usif_spi_do),
> +	GRP_MUX("usif spi_clk", USIF, xrx200_pins_usif_spi_clk),
> +	GRP_MUX("usif spi_cs0", USIF, xrx200_pins_usif_spi_cs0),
> +	GRP_MUX("usif spi_cs1", USIF, xrx200_pins_usif_spi_cs1),
> +	GRP_MUX("usif spi_cs2", USIF, xrx200_pins_usif_spi_cs2),
> +	GRP_MUX("stp", STP, xrx200_pins_stp),
> +	GRP_MUX("nmi", NMI, xrx200_pins_nmi),
> +	GRP_MUX("gpt1", GPT, xrx200_pins_gpt1),
> +	GRP_MUX("gpt2", GPT, xrx200_pins_gpt2),
> +	GRP_MUX("gpt3", GPT, xrx200_pins_gpt3),
> +	GRP_MUX("clkout0", CGU, xrx200_pins_clkout0),
> +	GRP_MUX("clkout1", CGU, xrx200_pins_clkout1),
> +	GRP_MUX("clkout2", CGU, xrx200_pins_clkout2),
> +	GRP_MUX("clkout3", CGU, xrx200_pins_clkout3),
> +	GRP_MUX("gnt1", PCI, xrx200_pins_pci_gnt1),
> +	GRP_MUX("gnt2", PCI, xrx200_pins_pci_gnt2),
> +	GRP_MUX("gnt3", PCI, xrx200_pins_pci_gnt3),
> +	GRP_MUX("gnt4", PCI, xrx200_pins_pci_gnt4),
> +	GRP_MUX("req1", PCI, xrx200_pins_pci_req1),
> +	GRP_MUX("req2", PCI, xrx200_pins_pci_req2),
> +	GRP_MUX("req3", PCI, xrx200_pins_pci_req3),
> +	GRP_MUX("req4", PCI, xrx200_pins_pci_req4),
> +	GRP_MUX("mdio", MDIO, xrx200_pins_mdio),
> +	GRP_MUX("dfe led0", DFE, xrx200_pins_dfe_led0),
> +	GRP_MUX("dfe led1", DFE, xrx200_pins_dfe_led1),
> +	GRP_MUX("gphy0 led0", GPHY, xrx200_pins_gphy0_led0),
> +	GRP_MUX("gphy0 led1", GPHY, xrx200_pins_gphy0_led1),
> +	GRP_MUX("gphy0 led2", GPHY, xrx200_pins_gphy0_led2),
> +	GRP_MUX("gphy1 led0", GPHY, xrx200_pins_gphy1_led0),
> +	GRP_MUX("gphy1 led1", GPHY, xrx200_pins_gphy1_led1),
> +	GRP_MUX("gphy1 led2", GPHY, xrx200_pins_gphy1_led2),
> +};
> +
> +static const char * const xrx200_pci_grps[] = {"gnt1", "gnt2",
> +						"gnt3", "gnt4",
> +						"req1", "req2",
> +						"req3", "req4"};
> +static const char * const xrx200_spi_grps[] = {"spi_di", "spi_do",
> +						"spi_clk", "spi_cs1",
> +						"spi_cs2", "spi_cs3",
> +						"spi_cs4", "spi_cs5",
> +						"spi_cs6"};
> +static const char * const xrx200_cgu_grps[] = {"clkout0", "clkout1",
> +						"clkout2", "clkout3"};
> +static const char * const xrx200_ebu_grps[] = {"ebu a23", "ebu a24",
> +						"ebu a25", "ebu cs1",
> +						"ebu wait", "ebu clk",
> +						"nand ale", "nand cs1",
> +						"nand cle", "nand rdy",
> +						"nand rd"};
> +static const char * const xrx200_exin_grps[] = {"exin0", "exin1", "exin2",
> +						"exin3", "exin4", "exin5"};
> +static const char * const xrx200_gpt_grps[] = {"gpt1", "gpt2", "gpt3"};
> +static const char * const xrx200_usif_grps[] = {"usif uart_rx", "usif uart_tx",
> +						"usif uart_rts", "usif uart_cts",
> +						"usif uart_dtr", "usif uart_dsr",
> +						"usif uart_dcd", "usif uart_ri",
> +						"usif spi_di", "usif spi_do",
> +						"usif spi_clk", "usif spi_cs0",
> +						"usif spi_cs1", "usif spi_cs2"};
> +static const char * const xrx200_stp_grps[] = {"stp"};
> +static const char * const xrx200_nmi_grps[] = {"nmi"};
> +static const char * const xrx200_mdio_grps[] = {"mdio"};
> +static const char * const xrx200_dfe_grps[] = {"dfe led0", "dfe led1"};
> +static const char * const xrx200_gphy_grps[] = {"gphy0 led0", "gphy0 led1",
> +						"gphy0 led2", "gphy1 led0",
> +						"gphy1 led1", "gphy1 led2"};
> +
> +static const struct ltq_pmx_func xrx200_funcs[] = {
> +	{"spi",		ARRAY_AND_SIZE(xrx200_spi_grps)},
> +	{"usif",	ARRAY_AND_SIZE(xrx200_usif_grps)},
> +	{"cgu",		ARRAY_AND_SIZE(xrx200_cgu_grps)},
> +	{"exin",	ARRAY_AND_SIZE(xrx200_exin_grps)},
> +	{"stp",		ARRAY_AND_SIZE(xrx200_stp_grps)},
> +	{"gpt",		ARRAY_AND_SIZE(xrx200_gpt_grps)},
> +	{"nmi",		ARRAY_AND_SIZE(xrx200_nmi_grps)},
> +	{"pci",		ARRAY_AND_SIZE(xrx200_pci_grps)},
> +	{"ebu",		ARRAY_AND_SIZE(xrx200_ebu_grps)},
> +	{"mdio",	ARRAY_AND_SIZE(xrx200_mdio_grps)},
> +	{"dfe",		ARRAY_AND_SIZE(xrx200_dfe_grps)},
> +	{"gphy",	ARRAY_AND_SIZE(xrx200_gphy_grps)},
> +};
> +
> +/* ---------  xrx300 related code --------- */
> +#define XRX300_MAX_PIN		64
> +
> +static const struct ltq_mfp_pin xrx300_mfp[] = {
> +	/*       pin    f0	f1	f2	f3   */
> +	MFP_XWAY(GPIO0, GPIO,	EXIN,	EPHY,	NONE),
> +	MFP_XWAY(GPIO1, GPIO,	NONE,	EXIN,	NONE),
> +	MFP_XWAY(GPIO2, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO3, GPIO,	CGU,	NONE,	NONE),
> +	MFP_XWAY(GPIO4, GPIO,	STP,	DFE,	NONE),
> +	MFP_XWAY(GPIO5, GPIO,	STP,	EPHY,	DFE),
> +	MFP_XWAY(GPIO6, GPIO,	STP,	NONE,	NONE),
> +	MFP_XWAY(GPIO7, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO8, GPIO,	CGU,	GPHY,	EPHY),
> +	MFP_XWAY(GPIO9, GPIO,	WIFI,	NONE,	EXIN),
> +	MFP_XWAY(GPIO10, GPIO,	USIF,	SPI,	EXIN),
> +	MFP_XWAY(GPIO11, GPIO,	USIF,	WIFI,	SPI),
> +	MFP_XWAY(GPIO12, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO13, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO14, GPIO,	CGU,	USIF,	EPHY),
> +	MFP_XWAY(GPIO15, GPIO,	SPI,	NONE,	MCD),
> +	MFP_XWAY(GPIO16, GPIO,	SPI,	EXIN,	NONE),
> +	MFP_XWAY(GPIO17, GPIO,	SPI,	NONE,	NONE),
> +	MFP_XWAY(GPIO18, GPIO,	SPI,	NONE,	NONE),
> +	MFP_XWAY(GPIO19, GPIO,	USIF,	NONE,	EPHY),
> +	MFP_XWAY(GPIO20, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO21, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO22, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO23, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO24, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO25, GPIO,	TDM,	NONE,	NONE),
> +	MFP_XWAY(GPIO26, GPIO,	TDM,	NONE,	NONE),
> +	MFP_XWAY(GPIO27, GPIO,	TDM,	NONE,	NONE),
> +	MFP_XWAY(GPIO28, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO29, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO30, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO31, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO32, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO33, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO34, GPIO,	NONE,	SSI,	NONE),
> +	MFP_XWAY(GPIO35, GPIO,	NONE,	SSI,	NONE),
> +	MFP_XWAY(GPIO36, GPIO,	NONE,	SSI,	NONE),
> +	MFP_XWAY(GPIO37, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO38, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO39, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO40, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO41, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO42, GPIO,	MDIO,	NONE,	NONE),
> +	MFP_XWAY(GPIO43, GPIO,	MDIO,	NONE,	NONE),
> +	MFP_XWAY(GPIO44, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO45, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO46, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO47, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO48, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO49, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO50, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO51, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO52, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO53, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO54, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO55, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO56, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO57, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO58, GPIO,	EBU,	TDM,	NONE),
> +	MFP_XWAY(GPIO59, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO60, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO61, GPIO,	EBU,	NONE,	NONE),
> +	MFP_XWAY(GPIO62, NONE,	NONE,	NONE,	NONE),
> +	MFP_XWAY(GPIO63, NONE,	NONE,	NONE,	NONE),
> +};
> +
> +static const unsigned xrx300_exin_pin_map[] = {GPIO0, GPIO1, GPI16, GPIO10, GPIO9};
> +
> +static const unsigned xrx300_pins_exin0[] = {GPIO0};
> +static const unsigned xrx300_pins_exin1[] = {GPIO1};
> +static const unsigned xrx300_pins_exin2[] = {GPIO16};
> +/* EXIN3 is not available on xrX300 */
> +static const unsigned xrx300_pins_exin4[] = {GPIO10};
> +static const unsigned xrx300_pins_exin5[] = {GPIO9};
> +
> +static const unsigned xrx300_pins_usif_uart_rx[] = {GPIO11};
> +static const unsigned xrx300_pins_usif_uart_tx[] = {GPIO10};
> +
> +static const unsigned xrx300_pins_usif_spi_di[] = {GPIO11};
> +static const unsigned xrx300_pins_usif_spi_do[] = {GPIO10};
> +static const unsigned xrx300_pins_usif_spi_clk[] = {GPIO19};
> +static const unsigned xrx300_pins_usif_spi_cs0[] = {GPIO14};
> +
> +static const unsigned xrx300_pins_stp[] = {GPIO4, GPIO5, GPIO6};
> +static const unsigned xrx300_pins_mdio[] = {GPIO42, GPIO43};
> +
> +static const unsigned xrx300_pins_dfe_led0[] = {GPIO4};
> +static const unsigned xrx300_pins_dfe_led1[] = {GPIO5};
> +
> +static const unsigned xrx300_pins_ephy0_led0[] = {GPIO5};
> +static const unsigned xrx300_pins_ephy0_led1[] = {GPIO8};
> +static const unsigned xrx300_pins_ephy1_led0[] = {GPIO14};
> +static const unsigned xrx300_pins_ephy1_led1[] = {GPIO19};
> +
> +static const unsigned xrx300_pins_nand_ale[] = {GPIO13};
> +static const unsigned xrx300_pins_nand_cs1[] = {GPIO23};
> +static const unsigned xrx300_pins_nand_cle[] = {GPIO24};
> +static const unsigned xrx300_pins_nand_rdy[] = {GPIO48};
> +static const unsigned xrx300_pins_nand_rd[] = {GPIO49};
> +static const unsigned xrx300_pins_nand_d1[] = {GPIO50};
> +static const unsigned xrx300_pins_nand_d0[] = {GPIO51};
> +static const unsigned xrx300_pins_nand_d2[] = {GPIO52};
> +static const unsigned xrx300_pins_nand_d7[] = {GPIO53};
> +static const unsigned xrx300_pins_nand_d6[] = {GPIO54};
> +static const unsigned xrx300_pins_nand_d5[] = {GPIO55};
> +static const unsigned xrx300_pins_nand_d4[] = {GPIO56};
> +static const unsigned xrx300_pins_nand_d3[] = {GPIO57};
> +static const unsigned xrx300_pins_nand_cs0[] = {GPIO58};
> +static const unsigned xrx300_pins_nand_wr[] = {GPIO59};
> +static const unsigned xrx300_pins_nand_wp[] = {GPIO60};
> +static const unsigned xrx300_pins_nand_se[] = {GPIO61};
> +
> +static const unsigned xrx300_pins_spi_di[] = {GPIO16};
> +static const unsigned xrx300_pins_spi_do[] = {GPIO17};
> +static const unsigned xrx300_pins_spi_clk[] = {GPIO18};
> +static const unsigned xrx300_pins_spi_cs1[] = {GPIO15};
> +/* SPI_CS2 is not available on xrX300 */
> +/* SPI_CS3 is not available on xrX300 */
> +static const unsigned xrx300_pins_spi_cs4[] = {GPIO10};
> +/* SPI_CS5 is not available on xrX300 */
> +static const unsigned xrx300_pins_spi_cs6[] = {GPIO11};
> +
> +/* CLKOUT0 is not available on xrX300 */
> +/* CLKOUT1 is not available on xrX300 */
> +static const unsigned xrx300_pins_clkout2[] = {GPIO3};
> +
> +static const struct ltq_pin_group xrx300_grps[] = {
> +	GRP_MUX("exin0", EXIN, xrx300_pins_exin0),
> +	GRP_MUX("exin1", EXIN, xrx300_pins_exin1),
> +	GRP_MUX("exin2", EXIN, xrx300_pins_exin2),
> +	GRP_MUX("exin4", EXIN, xrx300_pins_exin4),
> +	GRP_MUX("exin5", EXIN, xrx300_pins_exin5),
> +	GRP_MUX("nand ale", EBU, xrx300_pins_nand_ale),
> +	GRP_MUX("nand cs1", EBU, xrx300_pins_nand_cs1),
> +	GRP_MUX("nand cle", EBU, xrx300_pins_nand_cle),
> +	GRP_MUX("nand rdy", EBU, xrx300_pins_nand_rdy),
> +	GRP_MUX("nand rd", EBU, xrx300_pins_nand_rd),
> +	GRP_MUX("nand d1", EBU, xrx300_pins_nand_d1),
> +	GRP_MUX("nand d0", EBU, xrx300_pins_nand_d0),
> +	GRP_MUX("nand d2", EBU, xrx300_pins_nand_d2),
> +	GRP_MUX("nand d7", EBU, xrx300_pins_nand_d7),
> +	GRP_MUX("nand d6", EBU, xrx300_pins_nand_d6),
> +	GRP_MUX("nand d5", EBU, xrx300_pins_nand_d5),
> +	GRP_MUX("nand d4", EBU, xrx300_pins_nand_d4),
> +	GRP_MUX("nand d3", EBU, xrx300_pins_nand_d3),
> +	GRP_MUX("nand cs0", EBU, xrx300_pins_nand_cs0),
> +	GRP_MUX("nand wr", EBU, xrx300_pins_nand_wr),
> +	GRP_MUX("nand wp", EBU, xrx300_pins_nand_wp),
> +	GRP_MUX("nand se", EBU, xrx300_pins_nand_se),
> +	GRP_MUX("spi_di", SPI, xrx300_pins_spi_di),
> +	GRP_MUX("spi_do", SPI, xrx300_pins_spi_do),
> +	GRP_MUX("spi_clk", SPI, xrx300_pins_spi_clk),
> +	GRP_MUX("spi_cs1", SPI, xrx300_pins_spi_cs1),
> +	GRP_MUX("spi_cs4", SPI, xrx300_pins_spi_cs4),
> +	GRP_MUX("spi_cs6", SPI, xrx300_pins_spi_cs6),
> +	GRP_MUX("usif uart_rx", USIF, xrx300_pins_usif_uart_rx),
> +	GRP_MUX("usif uart_tx", USIF, xrx300_pins_usif_uart_tx),
> +	GRP_MUX("usif spi_di", USIF, xrx300_pins_usif_spi_di),
> +	GRP_MUX("usif spi_do", USIF, xrx300_pins_usif_spi_do),
> +	GRP_MUX("usif spi_clk", USIF, xrx300_pins_usif_spi_clk),
> +	GRP_MUX("usif spi_cs0", USIF, xrx300_pins_usif_spi_cs0),
> +	GRP_MUX("stp", STP, xrx300_pins_stp),
> +	GRP_MUX("clkout2", CGU, xrx300_pins_clkout2),
> +	GRP_MUX("mdio", MDIO, xrx300_pins_mdio),
> +	GRP_MUX("dfe led0", DFE, xrx300_pins_dfe_led0),
> +	GRP_MUX("dfe led1", DFE, xrx300_pins_dfe_led1),
> +	GRP_MUX("ephy0 led0", GPHY, xrx300_pins_ephy0_led0),
> +	GRP_MUX("ephy0 led1", GPHY, xrx300_pins_ephy0_led1),
> +	GRP_MUX("ephy1 led0", GPHY, xrx300_pins_ephy1_led0),
> +	GRP_MUX("ephy1 led1", GPHY, xrx300_pins_ephy1_led1),
> +};
> +
> +static const char * const xrx300_spi_grps[] = {"spi_di", "spi_do",
> +						"spi_clk", "spi_cs1",
> +						"spi_cs4", "spi_cs6"}
> +static const char * const xrx300_cgu_grps[] = {"clkout2"};
> +static const char * const xrx300_ebu_grps[] = {"nand ale", "nand cs1",
> +						"nand cle", "nand rdy",
> +						"nand rd", "nand d1",
> +						"nand d0", "nand d2",
> +						"nand d7", "nand d6",
> +						"nand d5", "nand d4",
> +						"nand d3", "nand cs0",
> +						"nand wr", "nand wp",
> +						"nand se"};
> +static const char * const xrx300_exin_grps[] = {"exin0", "exin1", "exin2",
> +						"exin4", "exin5"};
> +static const char * const xrx300_usif_grps[] = {"usif uart_rx", "usif uart_tx",
> +						"usif spi_di", "usif spi_do",
> +						"usif spi_clk", "usif spi_cs0"};
> +static const char * const xrx300_stp_grps[] = {"stp"};
> +static const char * const xrx300_mdio_grps[] = {"mdio"};
> +static const char * const xrx300_dfe_grps[] = {"dfe led0", "dfe led1"};
> +static const char * const xrx300_gphy_grps[] = {"ephy0 led0", "ephy0 led1",
> +						"ephy1 led0", "ephy1 led1"};
> +
> +static const struct ltq_pmx_func xrx300_funcs[] = {
> +	{"spi",		ARRAY_AND_SIZE(xrx300_spi_grps)},
> +	{"usif",	ARRAY_AND_SIZE(xrx300_usif_grps)},
> +	{"cgu",		ARRAY_AND_SIZE(xrx300_cgu_grps)},
> +	{"exin",	ARRAY_AND_SIZE(xrx300_exin_grps)},
> +	{"stp",		ARRAY_AND_SIZE(xrx300_stp_grps)},
> +	{"ebu",		ARRAY_AND_SIZE(xrx300_ebu_grps)},
> +	{"mdio",	ARRAY_AND_SIZE(xrx300_mdio_grps)},
> +	{"dfe",		ARRAY_AND_SIZE(xrx300_dfe_grps)},
> +	{"ephy",	ARRAY_AND_SIZE(xrx300_gphy_grps)},
> +};
> +
>  /* ---------  pinconf related code --------- */
>  static int xway_pinconf_get(struct pinctrl_dev *pctldev,
>  				unsigned pin,
> @@ -695,9 +1593,6 @@ static struct gpio_chip xway_chip = {
>  
>  
>  /* --------- register the pinctrl layer --------- */
> -static const unsigned xway_exin_pin_map[] = {GPIO0, GPIO1, GPIO2, GPIO39, GPIO46, GPIO9};
> -static const unsigned ase_exin_pins_map[] = {GPIO6, GPIO29, GPIO0};
> -
>  static struct pinctrl_xway_soc {
>  	int pin_count;
>  	const struct ltq_mfp_pin *mfp;
> @@ -708,21 +1603,41 @@ static struct pinctrl_xway_soc {
>  	const unsigned *exin;
>  	unsigned int num_exin;
>  } soc_cfg[] = {
> -	/* legacy xway */
> +	/* legacy xway (DEPRECATED: Use XWAY DANUBE Family) */
>  	{XWAY_MAX_PIN, xway_mfp,
>  		xway_grps, ARRAY_SIZE(xway_grps),
> -		danube_funcs, ARRAY_SIZE(danube_funcs),
> +		legacy_danube_funcs, ARRAY_SIZE(legacy_danube_funcs),
>  		xway_exin_pin_map, 3},

What is the difference between this entry and the new danube entry? Is
this legay entry needed here our can we map that to the danube entry? If
it is not needed you should probably change it directly in the
xway_match table.

> -	/* xway xr9 series */
> +	/* xway xr9 series (DEPRECATED: Use XWAY xRX100/xRX200 Family) */
>  	{XR9_MAX_PIN, xway_mfp,
>  		xway_grps, ARRAY_SIZE(xway_grps),
>  		xrx_funcs, ARRAY_SIZE(xrx_funcs),
>  		xway_exin_pin_map, 6},
> -	/* xway ase series */
> -	{XWAY_MAX_PIN, ase_mfp,
> +	/* XWAY AMAZON Family */
> +	{ASE_MAX_PIN, ase_mfp,
>  		ase_grps, ARRAY_SIZE(ase_grps),
>  		ase_funcs, ARRAY_SIZE(ase_funcs),
> -		ase_exin_pins_map, 3},
> +		ase_exin_pin_map, 3},
> +	/* XWAY DANUBE Family */
> +	{DANUBE_MAX_PIN, danube_mfp,
> +		danube_grps, ARRAY_SIZE(danube_grps),
> +		danube_funcs, ARRAY_SIZE(danube_funcs),
> +		danube_exin_pin_map, 3},
> +	/* XWAY xRX100 Family */
> +	{XRX100_MAX_PIN, xrx100_mfp,
> +		xrx100_grps, ARRAY_SIZE(xrx100_grps),
> +		xrx100_funcs, ARRAY_SIZE(xrx100_funcs),
> +		xrx100_exin_pin_map, 6},
> +	/* XWAY xRX200 Family */
> +	{XRX200_MAX_PIN, xrx200_mfp,
> +		xrx200_grps, ARRAY_SIZE(xrx200_grps),
> +		xrx200_funcs, ARRAY_SIZE(xrx200_funcs),
> +		xrx200_exin_pin_map, 6},
> +	/* XWAY xRX300 Family */
> +	{XRX300_MAX_PIN, xrx300_mfp,
> +		xrx300_grps, ARRAY_SIZE(xrx300_grps),
> +		xrx300_funcs, ARRAY_SIZE(xrx300_funcs),
> +		xrx300_exin_pin_map, 5},
>  };
>  
>  static struct pinctrl_gpio_range xway_gpio_range = {
> @@ -734,6 +1649,10 @@ static const struct of_device_id xway_match[] = {
>  	{ .compatible = "lantiq,pinctrl-xway", .data = &soc_cfg[0]},
>  	{ .compatible = "lantiq,pinctrl-xr9", .data = &soc_cfg[1]},
>  	{ .compatible = "lantiq,pinctrl-ase", .data = &soc_cfg[2]},
> +	{ .compatible = "lantiq,pinctrl-danube", .data = &soc_cfg[3]},
> +	{ .compatible = "lantiq,pinctrl-xrx100", .data = &soc_cfg[4]},
> +	{ .compatible = "lantiq,pinctrl-xrx200", .data = &soc_cfg[5]},
> +	{ .compatible = "lantiq,pinctrl-xrx300", .data = &soc_cfg[6]},

Using pointers to an array elemnt here looks error prone to me. Why not
use one static entry for each SoC and reference it directly.

Something like this:

static struct pinctrl_xway_soc pinctrl_xrx300 = {
	XRX300_MAX_PIN, xrx300_mfp,
	xrx300_grps, ARRAY_SIZE(xrx300_grps),
	xrx300_funcs, ARRAY_SIZE(xrx300_funcs),
	xrx300_exin_pin_map, 5
};

Then you can just do this:
{ .compatible = "lantiq,pinctrl-xrx300", .data = &pinctrl_xrx300},


>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, xway_match);
> 

Hauke
