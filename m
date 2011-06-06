Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 12:22:19 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:38587 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab1FFKWM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 12:22:12 +0200
Received: by qwi2 with SMTP id 2so2057014qwi.36
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IzibVUCJH0gKSiZ4nb+Y4qLHWWou9URcAr73tnfmUOU=;
        b=ewBc9VvQw0+/QoHmrmcIaPAD0ZHa8F/9dfpmtRORXZNNQzIWJS9gPn8rKgPKcPCXDo
         N9qT3n/5t2p0cfKIYIYuu+FWDi10Nbwb2IpATU7NSUGck1OxHld8DSZRD6vV4owmq1e8
         LbeI0LrU6K0pUzBbeaq7sLyz5VjH2fyOZ/Iz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rau/oZd8uObQAR0RHDUIlFfZPZKLMoQGF+3H0fsFPRGqDVa/gWN/3I/N/wlQxmYc90
         G4d7y93uIKc4yPlSFgUhT8WTIxlRyAWTCduQDtQA0/wzBPIIFZPYsHJJiaKz/IljpPyI
         aZwgX4vzdP5zDGbyN6F9X0VLefnGPkwV111ss=
MIME-Version: 1.0
Received: by 10.229.142.11 with SMTP id o11mr3397442qcu.46.1307355724941; Mon,
 06 Jun 2011 03:22:04 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 03:22:04 -0700 (PDT)
In-Reply-To: <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 12:22:04 +0200
Message-ID: <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4059

Hauke,

My idea for naming schema was to use:
bcma_host_TYPE_*

Like:
bcma_host_pci_*
bcma_host_sdio_*

You are using:
bcma_host_bcma_*

What do you think about changing this to:
bcma_host_embedded_*
or just some:
bcma_host_emb_*
?

Does it make more sense to you? I was trying to keep names in bcma
really clear, so every first-time-reader can see differences between
hosts, host and driver, etc.


2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> --- /dev/null
> +++ b/drivers/bcma/host_embedded.c
> @@ -0,0 +1,93 @@
> +/*
> + * Broadcom specific AMBA
> + * PCI Host

s/PCI/Embedded/


> +int bcma_host_bcma_register(struct bcma_bus *bus)
> +{
> +       u32 __iomem *mmio;
> +       /* iomap only first core. We have to read some register on this core
> +        * to get the number of cores. This is sone in bcma_scan()
> +        */
> +       mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE * 1);
> +       if (!mmio)
> +               return -ENOMEM;
> +       bus->mmio = mmio;

Maybe just:
bus->mmio = ioremap(...);
? :)


> +       /* Host specific */
> +       bus->hosttype = BCMA_HOSTTYPE_EMBEDDED;
> +       bus->ops = &bcma_host_bcma_ops;
> +
> +       /* Register */
> +       return bcma_bus_register(bus);
> +}
> diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
> index 1afa107..c5bcb5f 100644
> --- a/drivers/bcma/main.c
> +++ b/drivers/bcma/main.c
> @@ -119,6 +119,7 @@ static int bcma_register_cores(struct bcma_bus *bus)
>                        break;
>                case BCMA_HOSTTYPE_NONE:
>                case BCMA_HOSTTYPE_SDIO:
> +               case BCMA_HOSTTYPE_EMBEDDED:
>                        break;
>                }
>
> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
> index 70b39f7..9229615 100644
> --- a/drivers/bcma/scan.c
> +++ b/drivers/bcma/scan.c
> @@ -203,7 +203,7 @@ static s32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 **eromptr,
>  int bcma_bus_scan(struct bcma_bus *bus)
>  {
>        u32 erombase;
> -       u32 __iomem *eromptr, *eromend;
> +       u32 __iomem *eromptr, *eromend, *mmio;
>
>        s32 cia, cib;
>        u8 ports[2], wrappers[2];
> @@ -219,9 +219,34 @@ int bcma_bus_scan(struct bcma_bus *bus)
>        bus->chipinfo.id = (tmp & BCMA_CC_ID_ID) >> BCMA_CC_ID_ID_SHIFT;
>        bus->chipinfo.rev = (tmp & BCMA_CC_ID_REV) >> BCMA_CC_ID_REV_SHIFT;
>        bus->chipinfo.pkg = (tmp & BCMA_CC_ID_PKG) >> BCMA_CC_ID_PKG_SHIFT;
> +       bus->nr_cores = (tmp & BCMA_CC_ID_NRCORES) >> BCMA_CC_ID_NRCORES_SHIFT;

I'd use different variable as Julian suggested.


> +
> +       /* If we are an embedded device we now know the number of avaliable
> +        * core and ioremap the correct space.
> +        */

Typo: avaliable


> +       if (bus->hosttype == BCMA_HOSTTYPE_EMBEDDED) {
> +               iounmap(bus->mmio);
> +               mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE * bus->nr_cores);
> +               if (!mmio)
> +                       return -ENOMEM;
> +               bus->mmio = mmio;
> +
> +               mmio = ioremap(BCMA_WRAP_BASE, BCMA_CORE_SIZE * bus->nr_cores);
> +               if (!mmio)
> +                       return -ENOMEM;
> +               bus->host_embedded = mmio;

Do we really need both? mmio and host_embedded? What about keeping
mmio only and using it in calculation for read/write[8,16,32]?


> +       }
> +       /* reset it to 0 as we use it for counting */
> +       bus->nr_cores = 0;
>
>        erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
> -       eromptr = bus->mmio;
> +       if (bus->hosttype == BCMA_HOSTTYPE_EMBEDDED) {
> +               eromptr = ioremap(erombase, BCMA_CORE_SIZE);
> +               if (!eromptr)
> +                       return -ENOMEM;
> +       } else
> +               eromptr = bus->mmio;

I though eromptr = bus->mmio; will do the trick for embedded as well.
I think I need some time to read about IO mapping and understand that.

-- 
Rafał
