Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 13:29:01 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:40071 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491013Ab1EPL26 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 13:28:58 +0200
Received: by wyb28 with SMTP id 28so4232826wyb.36
        for <linux-mips@linux-mips.org>; Mon, 16 May 2011 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=ZVVcnNZ69qHM4MQegNgwmpTPvW9uoORG88mXf4bgPRs=;
        b=mBI5mYKK9cs9vkPXEUJireUhIdnHAo9wuruVJ7OfUndHXrjBK+bof0ZTOlLNWwiwl5
         oi/qOHKHwGEY7xJDFsteNFFF3WR5bsaSEuJZVtvLs1Np/byF9Pi9TatYKOXKuq6KffLE
         1Mzvk85so8n//b9W0/dCJ2S6OSanDXTSk9jZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=q8jeWvyqeSZbG7BIYMqHx2LL3pAjVNWUMvmZYyxwjYaQovQt1hD1erDPk/O6fg2y9L
         5BkV5s6up2nmLxLBTrYUSJeFYhB47BvU0pRBWDHDZ9t1FpzgYF3pcGUkk5YgQt/Z6yUT
         0wFXeHSZ36tGfO0X/N1GrIcYxV/eaL0FYn210=
Received: by 10.227.174.79 with SMTP id s15mr2510462wbz.76.1305545332671;
        Mon, 16 May 2011 04:28:52 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id o6sm3083790wbo.3.2011.05.16.04.28.51
        (version=SSLv3 cipher=OTHER);
        Mon, 16 May 2011 04:28:51 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: reference to non-existent CONFIG_HAVE_GPIO_LIB variable?
Date:   Mon, 16 May 2011 13:33:20 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6> <201105161023.33072.florian@openwrt.org> <alpine.DEB.2.00.1105160533590.7414@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.00.1105160533590.7414@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201105161333.20981.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello,

On Monday 16 May 2011 11:36:46 Robert P. J. Day wrote:
> On Mon, 16 May 2011, Florian Fainelli wrote:
> > Hello,
> > 
> > On Sunday 15 May 2011 01:05:58 Robert P. J. Day wrote:
> > >   the current kernel source contains a Makefile reference to the above
> > > 
> > > Kconfig variable that does not appear to be defined anywhere.
> > 
> > It would help if you mention which Makefile references this Kconfig
> > variable along with the changeset which introduced it.
> 
>   quite so, my bad.  here's the changeset:

Thank you. I think the author rather meant ARCH_WANT_OPTIONAL_GPIOLIB instead, 
can you build test a patch with this and submit it if you are happy with it?

> 
> $ git show 9fa32c6b
> commit 9fa32c6b0275ab1e8b19f74fbfa3ed8411345db6
> Author: Patrick Glass <patrickglass@gmail.com>
> Date:   Mon Aug 18 14:41:30 2008 -0700
> 
>     MIPS: PMC MSP71XX gpio drivers
> 
>     This new gpio driver for PMC-Sierra's MSP71xx SoC allows
>     standard api calls for access to the general and extended
>     gpio's.
> 
>     Signed-off-by: Patrick Glass <patrickglass@gmail.com>
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>      create mode 100755 arch/mips/pmc-sierra/msp71xx/gpio.c
>      create mode 100755 arch/mips/pmc-sierra/msp71xx/gpio_extended.c
>      create mode 100755 include/asm-mips/pmc-sierra/msp71xx/gpio.h
> 
> diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile
> b/arch/mips/pmc-sierra/msp71xx/Make
> index 4bba79c..e107f79 100644
> --- a/arch/mips/pmc-sierra/msp71xx/Makefile
> +++ b/arch/mips/pmc-sierra/msp71xx/Makefile
> @@ -3,6 +3,7 @@
>  #
>  obj-y += msp_prom.o msp_setup.o msp_irq.o \
>          msp_time.o msp_serial.o msp_elb.o
> +obj-$(CONFIG_HAVE_GPIO_LIB) += gpio.o gpio_extended.o
>  obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
>  obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
>  obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
> ... etc etc ...
> 
>   but there is no Kconfig file that defines the HAVE_GPIO_LIB variable
> that i can see.
> 
> rday
