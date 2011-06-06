Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 13:07:44 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:37407 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFLHl convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 13:07:41 +0200
Received: by qyk32 with SMTP id 32so837219qyk.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lNIogaLGKBSA4BPEy9gMuBSWJ6F3wWqWJ9A4r5WWayc=;
        b=HtY0d55j9R5lFri2CD8miZyKXJoI9qzSJBU1gp6SjVHOZG5YL5WlbTmL9oVnrkHjSz
         08NXQxunnGhl9SXkdT+MOm4vQi2koRMLD0alQ+hZwckLXqR5W3d51nIcyK7cMFsX/v9P
         0IXc5NTNJFRzVxGtsqs/QYd8iIsynDduIY4/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NKd1mxNmoH7KHrbBk+OcwUuopx6qU1jRa9PShHx1GzTD5mk5HxvPMfW2U1lENpKWLV
         tseDxEy62xZsfDnSDZkkXWvY4v/RDo1fXjdJFNzEsab/OMeLz2lIHwJRbUwwOsHjyKiB
         IN2eAEKjSW27QVB+ciCAxeACBN3pPK6StLoTk=
MIME-Version: 1.0
Received: by 10.229.43.99 with SMTP id v35mr3451104qce.8.1307358455148; Mon,
 06 Jun 2011 04:07:35 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 04:07:35 -0700 (PDT)
In-Reply-To: <1307311658-15853-10-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-10-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 13:07:35 +0200
Message-ID: <BANLkTi=ybf59NR1NA3TOuamsWzey9zx19A@mail.gmail.com>
Subject: Re: [RFC][PATCH 09/10] bcm47xx: add support for bcma bus
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4116

2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> This patch add support for the bcma bus. Broadcom uses only Mips 74K
> CPUs on the new SoC and on the old ons using ssb bus there are no Mips
> 74K CPUs.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/Kconfig                            |    4 +++
>  arch/mips/bcm47xx/gpio.c                     |    9 ++++++++
>  arch/mips/bcm47xx/nvram.c                    |    6 +++++
>  arch/mips/bcm47xx/serial.c                   |   24 +++++++++++++++++++++++
>  arch/mips/bcm47xx/setup.c                    |   27 ++++++++++++++++++++++++-
>  arch/mips/bcm47xx/time.c                     |    3 ++
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    3 ++
>  arch/mips/include/asm/mach-bcm47xx/gpio.h    |   18 +++++++++++++++++
>  drivers/watchdog/bcm47xx_wdt.c               |    6 +++++
>  9 files changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 653da62..bdb0341 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -100,6 +100,10 @@ config BCM47XX
>        select SSB_EMBEDDED
>        select SSB_B43_PCI_BRIDGE if PCI
>        select SSB_PCICORE_HOSTMODE if PCI
> +       select BCMA
> +       select BCMA_HOST_EMBEDDED
> +       select BCMA_DRIVER_MIPS
> +       select BCMA_PCICORE_HOSTMODE

I'm not involved in development for embedded devices but I believe
that space is quite important for them.

You force compiling both: ssb and bcma for every device using bcm47xx.
I think ppl may want to compile only one bus driver.

-- 
Rafał
