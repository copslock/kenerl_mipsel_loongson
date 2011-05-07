Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 19:24:47 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:40242 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491142Ab1EGRYo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 7 May 2011 19:24:44 +0200
Received: by qyl38 with SMTP id 38so3761394qyl.15
        for <multiple recipients>; Sat, 07 May 2011 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KjtSvzSNEK39jCQQvsWFfibn7y4jBmF8y0mBbjVhzdk=;
        b=xQIIgjROYREM7vbapu6XU6ImcnfwYhRh1TqtLTviyIRsLTWrSttWg1QjH8yJpzzcxT
         gHo6oo9SSNhfzRa9v9zEIA0K4JIMD++ov/VASajawXOUo9xzWbwte24N3P3oQPuh/DJE
         5uaKmgXbke+Bqj1zdVHvPXgz6fwER1UW2kua0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=p1BA63pfHBxx+pGp0k01/JdZS+h3O9RRe7uEQ6xo1xsO4fFHpatkv/wK+tsgoWC1jY
         JEF8MqL+eVE5XYaMCTEB3++EECb5nbERgxjtBteHD4GXr7uRH/Qs2e71KaJRVaxCofy+
         YGzfezZfr9mhzWQ3p8+v/wqQTD2u0oJ6s6weI=
Received: by 10.229.197.13 with SMTP id ei13mr1629624qcb.50.1304789078194;
 Sat, 07 May 2011 10:24:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.184.69 with HTTP; Sat, 7 May 2011 10:24:18 -0700 (PDT)
In-Reply-To: <1304771263-10937-2-git-send-email-hauke@hauke-m.de>
References: <1304771263-10937-1-git-send-email-hauke@hauke-m.de> <1304771263-10937-2-git-send-email-hauke@hauke-m.de>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 7 May 2011 19:24:18 +0200
Message-ID: <BANLkTinV+cuTr2cPvR2pBDE_C-2J4KwWcA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ssb: Change fallback sprom to callback mechanism.
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

just some small small spelling nit-picks:

On 7 May 2011 14:27, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Some embedded devices like the Netgear WNDR3300 have two SSB based
> cards without an own sprom on the pci bus. We have to provide two
> different fallback sproms for these and this was not possible with the
> old solution. In the bcm47xx architecture the sprom data is stored in
> the nvram in the main flash storage. The architecture code will be able
> to fill the sprom with the stored data based on the bus where the
> device was found.
>
> The bcm63xx code should to the same thing as before, just using the new

to -> do

> API.
>
> CC: Michael Buesch <mb@bu3sch.de>
> CC: netdev@vger.kernel.org
> CC: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/bcm63xx/boards/board_bcm963xx.c |   16 ++++++++++++++--
>  drivers/ssb/pci.c                         |   16 +++++++++++-----
>  drivers/ssb/sprom.c                       |   26 +++++++++++++++-----------
>  drivers/ssb/ssb_private.h                 |    2 +-
>  include/linux/ssb/ssb.h                   |    4 +++-
>  5 files changed, 44 insertions(+), 20 deletions(-)
>
> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> index 8dba8cf..40b223b 100644
> --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> @@ -643,6 +643,17 @@ static struct ssb_sprom bcm63xx_sprom = {
>        .boardflags_lo          = 0x2848,
>        .boardflags_hi          = 0x0000,
>  };
> +
> +int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
> +{
> +       if (bus->bustype == SSB_BUSTYPE_PCI) {
> +               memcpy(out, &bcm63xx_sprom, sizeof(struct ssb_sprom));
> +               return 0;
> +       } else {
> +               printk(KERN_ERR PFX "unable to fill SPROM for given bustype.\n");
> +               return -EINVAL;
> +       }
> +}
>  #endif
>
>  /*
> @@ -793,8 +804,9 @@ void __init board_prom_init(void)
>        if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
>                memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
>                memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
> -               if (ssb_arch_set_fallback_sprom(&bcm63xx_sprom) < 0)
> -                       printk(KERN_ERR "failed to register fallback SPROM\n");
> +               if (ssb_arch_register_fallback_sprom(
> +                               &bcm63xx_get_fallback_sprom) < 0)
> +                       printk(KERN_ERR PFX "failed to register fallback SPROM\n");
>        }
>  #endif
>  }
> diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
> index 6f34963..34955d1 100644
> --- a/drivers/ssb/pci.c
> +++ b/drivers/ssb/pci.c
> @@ -662,7 +662,6 @@ static int sprom_extract(struct ssb_bus *bus, struct ssb_sprom *out,
>  static int ssb_pci_sprom_get(struct ssb_bus *bus,
>                             struct ssb_sprom *sprom)
>  {
> -       const struct ssb_sprom *fallback;
>        int err;
>        u16 *buf;
>
> @@ -707,10 +706,17 @@ static int ssb_pci_sprom_get(struct ssb_bus *bus,
>                if (err) {
>                        /* All CRC attempts failed.
>                         * Maybe there is no SPROM on the device?
> -                        * If we have a fallback, use that. */
> -                       fallback = ssb_get_fallback_sprom();
> -                       if (fallback) {
> -                               memcpy(sprom, fallback, sizeof(*sprom));
> +                        * Now we ask the arch code if there is some sprom
> +                        * avaliable for this device in some other storage */

avaliable -> available

> +                       err = ssb_fill_sprom_with_fallback(bus, sprom);
> +                       if (err) {
> +                               ssb_printk(KERN_WARNING PFX "WARNING: Using"
> +                                          " fallback SPROM failed (err %d)\n",
> +                                          err);
> +                       } else {
> +                               ssb_dprintk(KERN_DEBUG PFX "Using SPROM"
> +                                           " revision %d provided by"
> +                                           " platform.\n", sprom->revision);
>                                err = 0;
>                                goto out_free;
>                        }
> diff --git a/drivers/ssb/sprom.c b/drivers/ssb/sprom.c
> index 5f34d7a..20cd139 100644
> --- a/drivers/ssb/sprom.c
> +++ b/drivers/ssb/sprom.c
> @@ -17,7 +17,7 @@
>  #include <linux/slab.h>
>
>
> -static const struct ssb_sprom *fallback_sprom;
> +static int(*get_fallback_sprom)(struct ssb_bus *dev, struct ssb_sprom *out);
>
>
>  static int sprom2hex(const u16 *sprom, char *buf, size_t buf_len,
> @@ -145,13 +145,14 @@ out:
>  }
>
>  /**
> - * ssb_arch_set_fallback_sprom - Set a fallback SPROM for use if no SPROM is found.
> + * ssb_arch_register_fallback_sprom - Registers a method providing a fallback
> + * SPROM if no SPROM is found.
>  *
> - * @sprom: The SPROM data structure to register.
> + * @sprom_callback: The callbcak function.

callbcak -> callback

>  *
> - * With this function the architecture implementation may register a fallback
> - * SPROM data structure. The fallback is only used for PCI based SSB devices,
> - * where no valid SPROM can be found in the shadow registers.
> + * With this function the architecture implementation may register a callback
> + * handler which wills the SPROM data structure. The fallback is only used for

wills -> fills

> + * PCI based SSB devices, where no valid SPROM can be found in the shadow registers.
>  *
>  * This function is useful for weird architectures that have a half-assed SSB device
>  * hardwired to their PCI bus.
> @@ -163,18 +164,21 @@ out:
>  *
>  * This function is available for architecture code, only. So it is not exported.
>  */
> -int ssb_arch_set_fallback_sprom(const struct ssb_sprom *sprom)
> +int ssb_arch_register_fallback_sprom(int (*sprom_callback)(struct ssb_bus *bus, struct ssb_sprom *out))
>  {
> -       if (fallback_sprom)
> +       if (get_fallback_sprom)
>                return -EEXIST;
> -       fallback_sprom = sprom;
> +       get_fallback_sprom = sprom_callback;
>
>        return 0;
>  }
>
> -const struct ssb_sprom *ssb_get_fallback_sprom(void)
> +int ssb_fill_sprom_with_fallback(struct ssb_bus *bus, struct ssb_sprom *out)
>  {
> -       return fallback_sprom;
> +       if (!get_fallback_sprom)
> +               return -ENOENT;
> +
> +       return get_fallback_sprom(bus, out);
>  }
>
>  /* http://bcm-v4.sipsolutions.net/802.11/IsSpromAvailable */
> diff --git a/drivers/ssb/ssb_private.h b/drivers/ssb/ssb_private.h
> index 0331139..1a32f58 100644
> --- a/drivers/ssb/ssb_private.h
> +++ b/drivers/ssb/ssb_private.h
> @@ -171,7 +171,7 @@ ssize_t ssb_attr_sprom_store(struct ssb_bus *bus,
>                             const char *buf, size_t count,
>                             int (*sprom_check_crc)(const u16 *sprom, size_t size),
>                             int (*sprom_write)(struct ssb_bus *bus, const u16 *sprom));
> -extern const struct ssb_sprom *ssb_get_fallback_sprom(void);
> +extern int ssb_fill_sprom_with_fallback(struct ssb_bus *bus, struct ssb_sprom *out);
>
>
>  /* core.c */
> diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
> index 9659eff..045f72a 100644
> --- a/include/linux/ssb/ssb.h
> +++ b/include/linux/ssb/ssb.h
> @@ -404,7 +404,9 @@ extern bool ssb_is_sprom_available(struct ssb_bus *bus);
>
>  /* Set a fallback SPROM.
>  * See kdoc at the function definition for complete documentation. */
> -extern int ssb_arch_set_fallback_sprom(const struct ssb_sprom *sprom);
> +extern int ssb_arch_register_fallback_sprom(
> +               int (*sprom_callback)(struct ssb_bus *bus,
> +               struct ssb_sprom *out));
>
>  /* Suspend a SSB bus.
>  * Call this from the parent bus suspend routine. */
> --
> 1.7.4.1
>
>
>
