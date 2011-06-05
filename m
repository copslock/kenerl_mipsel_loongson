Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 01:23:26 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:35223 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491779Ab1FEXXX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 01:23:23 +0200
Received: by iwn36 with SMTP id 36so3851719iwn.36
        for <linux-mips@linux-mips.org>; Sun, 05 Jun 2011 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=bw2QYFd8KM0cNRRZtkinbeQSYFIDVmOI8ZdINVvO3UE=;
        b=JgizzoJBO1nzuoywPzhkKpmtjbACNdQFG9DnpH6+A7YeST1+oBz9fAtzhVc1HLBHDU
         lrL0vT3WgMVC/iRB32sqj9MwnRctkrz3bk83fJs5ADicgsHbmx5Big3xtSiYMQR8/Ci2
         zqxYFh9ArR3q9cvM/rv2ZYZyCgZo3hFXr/I5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eRQwOBPfrf5n9mPMI1OYANs9LQtEwtv/PkdFjwuQF8IkqzdMaUpMT+7jRVCFLnPaLd
         g/JLkqOy1mLC/marP3p8Lw2lnxHThCC1dG9o/TFZNQ9lVmAxpWW7Z3ROCY/UjZxTqXlX
         MdzUl5lEGlZPAQasFvaciDUtUiQeRnCvMmGcc=
Received: by 10.231.142.17 with SMTP id o17mr6983863ibu.49.1307316196086; Sun,
 05 Jun 2011 16:23:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.167.71 with HTTP; Sun, 5 Jun 2011 16:22:56 -0700 (PDT)
In-Reply-To: <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 6 Jun 2011 09:22:56 +1000
Message-ID: <BANLkTi=atiB_=_N3xSJBAjRGXjTV8a97CA@mail.gmail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        zajec5@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3709

Hauke,

Minor nit:

On Mon, Jun 6, 2011 at 08:07, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This patch adds support for using bcma on an embedded bus. An embedded
> system like the bcm4716 could register this bus and it searches for the
> bcma cores then.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
> index 70b39f7..9229615 100644
> --- a/drivers/bcma/scan.c
> +++ b/drivers/bcma/scan.c
> @@ -219,9 +219,34 @@ int bcma_bus_scan(struct bcma_bus *bus)
>        bus->chipinfo.id = (tmp & BCMA_CC_ID_ID) >> BCMA_CC_ID_ID_SHIFT;
>        bus->chipinfo.rev = (tmp & BCMA_CC_ID_REV) >> BCMA_CC_ID_REV_SHIFT;
>        bus->chipinfo.pkg = (tmp & BCMA_CC_ID_PKG) >> BCMA_CC_ID_PKG_SHIFT;
> +       bus->nr_cores = (tmp & BCMA_CC_ID_NRCORES) >> BCMA_CC_ID_NRCORES_SHIFT;
> +
> +       /* If we are an embedded device we now know the number of avaliable
> +        * core and ioremap the correct space.
> +        */
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
> +       }
> +       /* reset it to 0 as we use it for counting */
> +       bus->nr_cores = 0;

Would it make sense to use a local variable for nr_cores, and only use
it within the BCMA_HOSTTYPE_EMBEDDED if statement, rather than
re-using bus->nr_cores and having to reset it?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
