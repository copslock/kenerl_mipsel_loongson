Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 23:04:51 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:53827 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490988Ab1G2VEo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jul 2011 23:04:44 +0200
Received: by pzk36 with SMTP id 36so6866883pzk.34
        for <multiple recipients>; Fri, 29 Jul 2011 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JJCiSis/MvO7a527QjIkvhxjucv7Lej2euJpBjOTOGU=;
        b=I9/WO/KjpkDiAkKhit1i098JyhWImb14W+Q0apeRj0wlxSJ8xGj2+H0NtjEu6vX3Hi
         NOepL67Ma1PgkvfFyY/vi6+7TjxBEe6EpgGHP24DUcXQj3SgWxb3M0n8GhUma2zbgKpZ
         WOyO0YLOgz26yH8Y20y1y8l3YY8qM5ow2aHXc=
MIME-Version: 1.0
Received: by 10.68.57.100 with SMTP id h4mr3039465pbq.317.1311973477492; Fri,
 29 Jul 2011 14:04:37 -0700 (PDT)
Received: by 10.68.50.103 with HTTP; Fri, 29 Jul 2011 14:04:37 -0700 (PDT)
In-Reply-To: <1311376815-15755-7-git-send-email-hauke@hauke-m.de>
References: <1311376815-15755-1-git-send-email-hauke@hauke-m.de>
        <1311376815-15755-7-git-send-email-hauke@hauke-m.de>
Date:   Fri, 29 Jul 2011 23:04:37 +0200
Message-ID: <CACna6rxMA9KDuWSPLmdNsS=zNJawkbX5-KYrRWq3Jn25gWhX7A@mail.gmail.com>
Subject: Re: [PATCH 06/11] bcma: add serial console support
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linville@tuxdriver.com, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com,
        ralf@linux-mips.org, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22053

2011/7/23 Hauke Mehrtens <hauke@hauke-m.de>:
> This adds support for serial console to bcma, when operating on an SoC.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/bcma/bcma_private.h                 |    8 ++++
>  drivers/bcma/driver_chipcommon.c            |   48 +++++++++++++++++++++++++++
>  drivers/bcma/driver_chipcommon_pmu.c        |   26 ++++++++++++++
>  drivers/bcma/driver_mips.c                  |    1 +
>  include/linux/bcma/bcma_driver_chipcommon.h |   14 ++++++++
>  5 files changed, 97 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bcma/bcma_private.h b/drivers/bcma/bcma_private.h
> index b97633d..22d3052 100644
> --- a/drivers/bcma/bcma_private.h
> +++ b/drivers/bcma/bcma_private.h
> @@ -29,6 +29,14 @@ void bcma_init_bus(struct bcma_bus *bus);
>  /* sprom.c */
>  int bcma_sprom_get(struct bcma_bus *bus);
>
> +/* driver_chipcommon.c */
> +#ifdef CONFIG_BCMA_DRIVER_MIPS
> +void bcma_chipco_serial_init(struct bcma_drv_cc *cc);
> +#endif /* CONFIG_BCMA_DRIVER_MIPS */
> +
> +/* driver_chipcommon_pmu.c */
> +u32 bcma_pmu_alp_clock(struct bcma_drv_cc *cc);
> +
>  #ifdef CONFIG_BCMA_HOST_PCI
>  /* host_pci.c */
>  extern int __init bcma_host_pci_init(void);

Not sure, what do you think about this, feel free to comment.

My idea was to use bcma_private.h for bcma-internal functions. For
example, support for PCI host or SoC host, is something "internal" (as
I call it) for bcma. Drivers in theory could be separated modules and
I use include/linux/bcma/driver_*.h for them.

If following this schema, declarations of
bcma_pmu_alp_clock
bcma_host_pci_init
should be in include/linux/bcma/bcma_driver_chipcommon.h

-- 
Rafał
