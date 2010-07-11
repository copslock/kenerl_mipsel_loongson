Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jul 2010 19:10:09 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:55508 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491135Ab0GKRKG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Jul 2010 19:10:06 +0200
Received: by wyf28 with SMTP id 28so2188447wyf.36
        for <multiple recipients>; Sun, 11 Jul 2010 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=sbvh4uut5qdh0nuuG+tboh59vYQeK7UlSKwb56nGdMY=;
        b=bUZyg2ggBh8bheIN48+hfiKFjgSs/s0FJgf/azAoVj9isPDOZW/MNOReJ9bnq7O5cG
         n3xounQU37+8FQ7+mZLgd34LPF5rw4hbMtx0dWOlDvo0ZuxrkBprOdczTU2906Kfwnt+
         Ldfx3cyX5LZwK+ko3ZFbpAC8vX8X0x0gfQvvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=QwOGdksN/Yt0vDrNKW5es8WbJqhaNfRD8BRuc23xu//Fb9gRhoI7km7S04/iAZHhaW
         BGcZcGdv+D8TtHkiqj0z7SR7mvZMcGlQCLsf/0bRqPt8xrtHQTXURALcCRbeC+4i5IIx
         IFrSOxYIgnD0ia1gQq9Txrxc3A8IrgLicPI0I=
Received: by 10.216.29.1 with SMTP id h1mr7493530wea.20.1278868199931;
        Sun, 11 Jul 2010 10:09:59 -0700 (PDT)
Received: from lenovo.localnet (147.199.66-86.rev.gaoland.net [86.66.199.147])
        by mx.google.com with ESMTPS id m73sm1209119wej.36.2010.07.11.10.09.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 10:09:59 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     Bruno Randolf <randolf.bruno@googlemail.com>
Subject: Re: [PATCH 1/2] MIPS: MTX-1: fix PCI on the MeshCube and related boards
Date:   Sun, 11 Jul 2010 19:10:20 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.34-1-amd64; KDE/4.4.4; x86_64; ; )
Cc:     linux-mips@linux-mips.org, manuel.lauss@googlemail.com,
        ralf@linux-mips.org
References: <20100711154028.29863.74414.stgit@void>
In-Reply-To: <20100711154028.29863.74414.stgit@void>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201007111910.22303.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Sunday 11 July 2010 17:40:28, Bruno Randolf a écrit :
> This patch fixes a regression introduced by commit "MIPS: Alchemy: MTX-1:
> Use linux gpio api." (bb706b28bbd647c2fd7f22d6bf03a18b9552be05) which
> broke PCI bus operation. The problem is caused by alchemy_gpio2_enable()
> which resets the GPIO2 block. Two PCI signals (PCI_SERR and PCI_RST) are
> connected to GPIO2 and they obviously do not to like the reset. Since
> GPIO2 is correctly initialized by the boot monitor (YAMON) it is not
> necessary to call this function, so just remove it.
> 
> Also replace gpio_set_value() with alchemy_gpio_set_value() to avoid
> problems in case gpiolib gets initialized after PCI. And since alchemy
> gpio_set_value() calls au_sync() we don't have to au_sync() again later.
> 
> Cc: stable@kernel.org
> Signed-off-by: Bruno Randolf <br1@einfach.org>

Tested-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/alchemy/mtx-1/board_setup.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/alchemy/mtx-1/board_setup.c
> b/arch/mips/alchemy/mtx-1/board_setup.c index a9f0336..52d883d 100644
> --- a/arch/mips/alchemy/mtx-1/board_setup.c
> +++ b/arch/mips/alchemy/mtx-1/board_setup.c
> @@ -67,8 +67,6 @@ static void mtx1_power_off(void)
> 
>  void __init board_setup(void)
>  {
> -	alchemy_gpio2_enable();
> -
>  #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
>  	/* Enable USB power switch */
>  	alchemy_gpio_direction_output(204, 0);
> @@ -117,11 +115,11 @@ mtx1_pci_idsel(unsigned int devsel, int assert)
> 
>  	if (assert && devsel != 0)
>  		/* Suppress signal to Cardbus */
> -		gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
> +		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
>  	else
> -		gpio_set_value(1, 1);	/* set EXT_IO3 ON */
> +		alchemy_gpio_set_value(1, 1);	/* set EXT_IO3 ON */
> 
> -	au_sync_udelay(1);
> +	udelay(1);
>  	return 1;
>  }
