Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 19:22:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35780 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992078AbdFERWFGS8xK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 19:22:05 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 04D6241F8E09;
        Mon,  5 Jun 2017 19:31:00 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 05 Jun 2017 19:31:00 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 05 Jun 2017 19:31:00 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1E9B6C46C65DF;
        Mon,  5 Jun 2017 18:21:55 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 5 Jun 2017 18:21:59 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun
 2017 18:21:59 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 5 Jun 2017
 10:21:56 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, Tobias Klauser <tklauser@distanz.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jarod Wilson <jarod@redhat.com>, <linux-mips@linux-mips.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 2/7] net: pch_gbe: Pull PHY GPIO handling out of Minnow code
Date:   Mon, 5 Jun 2017 10:21:50 -0700
Message-ID: <4378321.AjzBvRIWiG@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170603175200.GC17099@lunn.ch>
References: <20170602234042.22782-1-paul.burton@imgtec.com> <20170602234042.22782-3-paul.burton@imgtec.com> <20170603175200.GC17099@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1754611.YrGcW5r07r";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1754611.YrGcW5r07r
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andrew,

On Saturday, 3 June 2017 10:52:00 PDT Andrew Lunn wrote:
> > diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> > b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c index
> > d38198718005..cb9b904786e4 100644
> > --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> > +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> > @@ -360,6 +360,16 @@ static void pch_gbe_mac_mar_set(struct pch_gbe_hw
> > *hw, u8 * addr, u32 index)> 
> >  	pch_gbe_wait_clr_bit(&hw->reg->ADDR_MASK, PCH_GBE_BUSY);
> >  
> >  }
> > 
> > +static void pch_gbe_phy_set_reset(struct pch_gbe_hw *hw, int value)
> > +{
> > +	struct pch_gbe_adapter *adapter = pch_gbe_hw_to_adapter(hw);
> > +
> > +	if (!adapter->pdata || !adapter->pdata->phy_reset_gpio)
> > +		return;
> > +
> > +	gpiod_set_value(adapter->pdata->phy_reset_gpio, value);
> 
> Hi Paul
> 
> Since you are using the gpiod_ API, the core will take notice of the
> active low/active high flag when performing this set.

Correct, and as desired.

> >  	ret = devm_gpio_request_one(&pdev->dev, gpio, flags,
> >  	
> >  				    "minnow_phy_reset");
> > 
> > -	if (ret) {
> > +	if (!ret)
> > +		pdata->phy_reset_gpio = gpio_to_desc(gpio);
> 
> Here however, you are using the gpio_ API, which ignores the active
> high/low flag in device tree. And in your binding patch, you give the
> example:
> 
> +               phy-reset-gpios = <&eg20t_gpio 6
> +                                  GPIO_ACTIVE_LOW>;
> 
> This active low is totally ignored.

First of all, this path is for the existing Minnow platform, which doesn't use 
the device tree. That is, this code is the non-DT path so looking at what 
happens to flags in the device tree here makes no sense.

If you want to examine what happens in the DT case then please look at 
pch_gbe_get_priv() which uses devm_gpiod_get() which should honor the flags 
provided by the DT.

> I personally would say this is all messed up, and going to result in
> problems for somebody with a board which actually needs an
> GPIO_ACTIVE_HIGH.

It's a path which only applies to the Minnow board, which is always active 
low. Before patch 1 of this series that was done without the GPIOF_ACTIVE_LOW 
flag by setting GPIO values to reflect the physical GPIO line low/high rather 
than the logical active/not-active. After patch 1 this path began using 
GPIOF_ACTIVE_LOW such that the rest of the code can use logical active/not-
active values which work with either active low or active high GPIOs. In this 
Minnow-specific path GPIOF_ACTIVE_LOW is hardcoded, but again only applies to 
the Minnow board which doesn't take the GPIO value from device tree.

> Please use the gpiod_ API through out and respect the flags in the
> device tree binding.

The gpiod_ API, quite rightly, retrieves GPIOs associated with a device - for 
example via the device tree. The Minnow board, which is what the driver 
already supports in-tree, does not do this but instead hardcodes a GPIO number 
(MINNOW_PHY_RESET_GPIO). I don't own, use or care about the Minnow platform so 
that is not something that I can change. In the path that my patch does add, 
the path which is used with DT, I already do use the gpiod_ API & respect 
flags from the DT.

Thanks,
    Paul
--nextPart1754611.YrGcW5r07r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlk1ky4ACgkQgiDZ+mk8
HGUTFg//cMZv4+XUh4gBsflFfugQFxEoylpvJy6gtxKOkS2w7DX/sWRO1NqhK5EW
lzOVrwQXEdtEqlBjFa4eBD8HEVPCdj531AjS0FoHgodcyez8Tq58C9Zpv3takVnm
cpradEbQQ/dNlzGhktActmcG8V04otniPI61yvIHQDQziEd/QckBb+PuSytvlEDx
hhebHs2ZnfwxCBcZULy4zxGkH5269oGj7+23g+J6O7HqRkbAIGQIQ+pqeenG17Hj
8G4uSnt2s2OaR56vK0WUZGlvuAMSoyXHiHTFjO9hHpWGcRFaSAQcKzW0ggdcygGx
As/CV/XWBlbC0YHyDGYGT5UYufGFynnAQsWwHyewMagn7jf9TX7LilixmoIKFW3l
W8DA1u4q8dgmZrDdi6HNlyCEKUWEelR1KzjJUdjNSbmMBKaNUVLSWQTV5RYkwSEL
hbH836phGiwBVnn3pLP7nuLr2quaHFnv1S/2MnBM7KWhst4WswMOdFbGgLStwSoB
auqcXrsVxmHCinWkQL8w8CKJicvYOYPstMxNHViYpRTyR4i2lPHzk4MpAEnoSIgS
oO2LlnkDSFM+Z28D+VQxS0ak0X4s2RlMqB7B9kD8Vo+reI5PlVP7TpqnHAzWJZf3
mKCL9t8EpFJF/3xqH9dIKx70A0FrTfJ+oCOEj+XSVHjZrwLLViE=
=t0VA
-----END PGP SIGNATURE-----

--nextPart1754611.YrGcW5r07r--
