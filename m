Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 01:12:42 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:62896 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab1EJXMh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2011 01:12:37 +0200
Received: by qyk32 with SMTP id 32so2407784qyk.15
        for <multiple recipients>; Tue, 10 May 2011 16:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S4Oga9zsqoYBOetVcx7aESLktw0t+gWRuXIPp5vNIlc=;
        b=sNyFSOvhegsmFuyTFsUZUdFwdwkL0YDJ2aweBhbvoGDWwebaKUHvphdSh7iVR6WaXJ
         dzAQM9fLhs7kUFazwKRhVYTf35apjoS88ckr+vNQrtLm8YCQoduVCCok458cxZlHW7Cn
         JSyWV+65kGeTc2jk0zOql/Ve4jLeN0vJGqfNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iNyQIPALuVW45i0UYYCtQ0vMCeWLMxGuQc4uLlgFWqKjiHx7FOrpu7fOZqptpyyctg
         xscV75mSgAkJacFllPAzcquUre86xagr16h/Srt3JJoCCfxRTi7S9ZNrNS3TV/BAMjsg
         yqoxSzsCFdxvLQRbAOaonYWAHzeyxCDYlQaWc=
MIME-Version: 1.0
Received: by 10.229.18.77 with SMTP id v13mr6822935qca.56.1305069150900; Tue,
 10 May 2011 16:12:30 -0700 (PDT)
Received: by 10.229.211.5 with HTTP; Tue, 10 May 2011 16:12:30 -0700 (PDT)
In-Reply-To: <1305063094-26656-2-git-send-email-hauke@hauke-m.de>
References: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
        <1305063094-26656-2-git-send-email-hauke@hauke-m.de>
Date:   Wed, 11 May 2011 01:12:30 +0200
Message-ID: <BANLkTinZkCPQh84wy66nDmHpgwCO3Pvu3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ssb: Change fallback sprom to callback mechanism.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips

2011/5/10 Hauke Mehrtens <hauke@hauke-m.de>:
> Some embedded devices like the Netgear WNDR3300 have two SSB based
> cards without an own sprom on the pci bus. We have to provide two
> different fallback sproms for these and this was not possible with the
> old solution. In the bcm47xx architecture the sprom data is stored in
> the nvram in the main flash storage. The architecture code will be able
> to fill the sprom with the stored data based on the bus where the
> device was found.
>
> The bcm63xx code should do the same thing as before, just using the new
> API.
>
> Acked-by: Michael Buesch <mb@bu3sch.de>
> CC: netdev@vger.kernel.org
> CC: linux-wireless@vger.kernel.org
> CC: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>
> v2: * fix some checkpatch errors and warnings
>    * spelling issues
>
>  arch/mips/bcm63xx/boards/board_bcm963xx.c |   16 +++++++++-
>  drivers/ssb/pci.c                         |   16 +++++++---
>  drivers/ssb/sprom.c                       |   43 +++++++++++++++++------------
>  drivers/ssb/ssb_private.h                 |    3 +-
>  include/linux/ssb/ssb.h                   |    4 ++-
>  5 files changed, 55 insertions(+), 27 deletions(-)
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
> index 6f34963..7ad4858 100644
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
> +                        * available for this device in some other storage */
> +                       err = ssb_fill_sprom_with_fallback(bus, sprom);
> +                       if (err) {
> +                               ssb_printk(KERN_WARNING PFX "WARNING: Using"
> +                                          " fallback SPROM failed (err %d)\n",
> +                                          err);

I was recently told we should not duplicate message levels info with
own prefixes ("WARNING: ").

-- 
Rafał
