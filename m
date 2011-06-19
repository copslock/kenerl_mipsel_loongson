Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 00:53:05 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:50064 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab1FSWxD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jun 2011 00:53:03 +0200
Received: by iyn15 with SMTP id 15so877500iyn.36
        for <linux-mips@linux-mips.org>; Sun, 19 Jun 2011 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ahboKRw529B8y6NMJRRb2o7RZOTvI0gJfYy1bqwDzRw=;
        b=uOWWetjJ8G7+NUiuh0bZ1iK2cCCGyRr7wZNJld4cwcjWCorA6eSbJ0cHG2GDKWp9SO
         pw+bRzuL8TZMjFXggeJhaKHU3uqhCLcO0ZMOEVsK1fG0LSVwUySIsXnrYnyabU+r0YWu
         fa9voHw5HzyPmGdwDowYQXPmoaeV2ryBeb9Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qDUzbcAv156c2+8An4/Sf6g/2m1zAKYxfeY4bBbWm/qBBUT5uapTql/BmfTJawFjLt
         /Oq4+zmGi0spC4s6ZULLprfWmKgrim3Uiag0U4us/NHzHGM9ikW04/igsWaU3k8qoBgE
         EYRtgMUyIJqrjl1yOgK+80NdP2cl1qy3zv4to=
Received: by 10.231.211.72 with SMTP id gn8mr4517566ibb.24.1308523976134; Sun,
 19 Jun 2011 15:52:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.167.71 with HTTP; Sun, 19 Jun 2011 15:52:36 -0700 (PDT)
In-Reply-To: <1308520209-668-4-git-send-email-hauke@hauke-m.de>
References: <1308520209-668-1-git-send-email-hauke@hauke-m.de> <1308520209-668-4-git-send-email-hauke@hauke-m.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 20 Jun 2011 08:52:36 +1000
Message-ID: <BANLkTinfFHwd++rxb0wn266dQhF=7ANmhQ@mail.gmail.com>
Subject: Re: [RFC v2 03/12] bcma: add functions to scan cores needed on SoCs
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de, sshtylyov@mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15713

Hauke,

Couple of minor points

On Mon, Jun 20, 2011 at 07:50, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> The chip common and mips core have to be setup early in the boot
> process to get the cpu clock.
> bcma_bus_earyl_register() gets pointers to some space to store the core

Spelling: s/earyl/early/

> data and searches for the chip common and mips core and initializes
> chip common. After that was done and the kernel is out of early boot we
> just have to run bcma_bus_register() and it will search for the other
> cores, initialize and register them.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
> diff --git a/drivers/bcma/bcma_private.h b/drivers/bcma/bcma_private.h
> index 12a75ab..6416bbc 100644
> --- a/drivers/bcma/bcma_private.h
> +++ b/drivers/bcma/bcma_private.h
> @@ -15,9 +15,16 @@ struct bcma_bus;
>  /* main.c */
>  extern int bcma_bus_register(struct bcma_bus *bus);
>  extern void bcma_bus_unregister(struct bcma_bus *bus);
> +int __init bcma_bus_earyl_register(struct bcma_bus *bus,
> +                                  struct bcma_device *core_cc,
> +                                  struct bcma_device *core_mips);

Here too.

> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
> index 7970553..4ebb186 100644
> --- a/drivers/bcma/scan.c
> +++ b/drivers/bcma/scan.c
> @@ -332,9 +361,10 @@ int bcma_bus_scan(struct bcma_bus *bus)
>        u32 erombase;
>        u32 __iomem *eromptr, *eromend;
>
> -       int err;
> +       int err, core_num = 0;
>
> -       bcma_init_bus(bus);
> +       if (!bus->init_done)
> +               bcma_init_bus(bus);

For consistency with the core init functions, should this test go in
bcma_init_bus()?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
