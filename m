Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 09:52:56 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:53049 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006657AbaHYHwx7Ufh5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 09:52:53 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue006) with ESMTP (Nemesis)
        id 0MPvIk-1XGt7f21o2-004ymG; Mon, 25 Aug 2014 09:52:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        zajec5@gmail.com
Subject: Re: [RFC 3/7] bcm47xx-sprom: add Broadcom sprom parser driver
Date:   Mon, 25 Aug 2014 09:52:20 +0200
Message-ID: <8344390.rjnOcYBCET@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.11.0-26-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1408915485-8078-5-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de> <1408915485-8078-5-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:xrllyE1W4kUYLx3Wa66OI/ZgX2z94t5495Il6JVjFE0
 NOlut9ekcz6xMrmAeQEMhtRrnfGv4mY5VS1ytnx5pjsBDOtwCk
 eJ6/QNoW56mfD9FhlZuL3jAyaECG4oYhSAppJp+aaMTmU95iHd
 Aru5Tdg9k0WOm0AENBWnc5CTVrnXO59br/F+hOw2TfSj+BQ2sS
 gu8cqiu9WcCT5wELkJV2ZhxP0QfHIV83arJwiEFhxklCRlWJ0E
 TrpAj+yjeXo0tMCmrC5CpeQamLcL1W1T4doAOn6yL00t8LBEwg
 OkWSNrwIWdo3/0jnTmcs3B1h4mEfLyKeMaZcXB0KsrAU8qNz3d
 JAZnVosz8uJSSfLl+WXc=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42209
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

On Sunday 24 August 2014 23:24:41 Hauke Mehrtens wrote:
> This driver needs an nvram driver and fetches the sprom values from the
> nvram and provides it to any other driver. The calibration data for the
> wifi chip the mac address and some more board description data is
> stores in the sprom.
> 
> This is based on a copy of arch/mips/bcm47xx/sprom.c and my plan is to
> make the bcm47xx MIPS SoCs also use this driver some time later.

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/misc/bcm47xx-sprom.txt     |  16 +

I'd prefer not to list the binding in a 'misc' category. Maybe we can
have a new category and move the misc/sram.txt into the same?

>  drivers/misc/Kconfig                               |  14 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/bcm47xx-sprom.c                       | 690 +++++++++++++++++++++

On a similar note, putting the driver into drivers/misc seems
suboptimal: misc drivers should by definition be something that
is for some odd hardware with no external dependencies on it,
whereas your driver seems to be used by multiple other drivers.

Would it make sense to put it into drivers/bcma when that is the
only bus it is used on?

>  4 files changed, 721 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/bcm47xx-sprom.txt
>  create mode 100644 drivers/misc/bcm47xx-sprom.c
> 
> diff --git a/Documentation/devicetree/bindings/misc/bcm47xx-sprom.txt b/Documentation/devicetree/bindings/misc/bcm47xx-sprom.txt
> new file mode 100644
> index 0000000..eed2a4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/bcm47xx-sprom.txt
> @@ -0,0 +1,16 @@
> +Broadcom bcm47xx/bcm53xx sprom converter
> +
> +This driver provbides an sprom based on a given nvram.
> +
> +Required properties:
> +
> +- compatible : brcm,bcm47xx-sprom

Please use a specific SoC here as the compatible string, not something
with 'x' in it as a wildcard.


> +#define NVRAM_READ_VAL(type)						\
> +static void nvram_read_ ## type (const struct bcm47xx_sprom_fill *fill,	\
> +				 const char *postfix, const char *name, \
> +				 type *val, type allset)		\
> +{									\
> +	char buf[100];							\
> +	int err;							\
> +	type var;							\
> +									\
> +	err = get_nvram_var(fill, postfix, name, buf, sizeof(buf));	\
> +	if (err < 0)							\
> +		return;							\
> +	err = kstrto ## type(strim(buf), 0, &var);			\
> +	if (err) {							\
> +		pr_warn("can not parse nvram name %s%s%s with value %s got %i\n",	\
> +			fill->prefix, name, postfix, buf, err);		\
> +		return;							\
> +	}								\
> +	if (allset && var == allset)					\
> +		return;							\
> +	*val = var;							\
> +}
> +
> +NVRAM_READ_VAL(u8)
> +NVRAM_READ_VAL(s8)
> +NVRAM_READ_VAL(u16)
> +NVRAM_READ_VAL(u32)
> +
> +#undef NVRAM_READ_VAL

Hmm, multiline macros are ugly. How about using one function to read
into an s64 internally using kstrtoll, and simple inline wrappers around
that for the smaller types, doing the appropriate range check?

> +static void bcm47xx_sprom_fill_r1234589(struct ssb_sprom *sprom,
> +					const struct bcm47xx_sprom_fill *fill)
> +{
> +	nvram_read_u16(fill, NULL, "devid", &sprom->dev_id, 0);
> +	nvram_read_u8(fill, NULL, "ledbh0", &sprom->gpio0, 0xff);
> +	nvram_read_u8(fill, NULL, "ledbh1", &sprom->gpio1, 0xff);
> +	nvram_read_u8(fill, NULL, "ledbh2", &sprom->gpio2, 0xff);
> +	nvram_read_u8(fill, NULL, "ledbh3", &sprom->gpio3, 0xff);
> +	nvram_read_u8(fill, NULL, "aa2g", &sprom->ant_available_bg, 0);
> +	nvram_read_u8(fill, NULL, "aa5g", &sprom->ant_available_a, 0);
> +	nvram_read_s8(fill, NULL, "ag0", &sprom->antenna_gain.a0, 0);
> +	nvram_read_s8(fill, NULL, "ag1", &sprom->antenna_gain.a1, 0);
> +	nvram_read_alpha2(fill, "ccode", sprom->alpha2);
> +}

Rather than calling the same set of functions multiple times, can you
do this using a table driven approach for smaller code size and
improved readability?

> +static int bcm47xx_sprom_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct ssb_sprom *sprom;
> +	const __be32 *handle;
> +	struct device_node *nvram_node;
> +	struct platform_device *nvram_dev;
> +	struct bcm47xx_sprom_fill fill;
> +
> +	/* Alloc */
> +	sprom = devm_kzalloc(dev, sizeof(*sprom), GFP_KERNEL);
> +	if (!sprom)
> +		return -ENOMEM;
> +
> +	handle = of_get_property(np, "nvram", NULL);
> +	if (!handle)
> +		return -ENOMEM;
> +
> +	nvram_node = of_find_node_by_phandle(be32_to_cpup(handle));

You can avoid the explicit be32_to_cpup here if you use
of_property_read_u32 above.

	Arnd
