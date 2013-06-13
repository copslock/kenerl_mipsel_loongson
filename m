Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 11:50:09 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40184 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827445Ab3FMJuH2HlU5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 11:50:07 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa11so7813652pad.5
        for <multiple recipients>; Thu, 13 Jun 2013 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=0zITrVjFVTy9kS2j2rgDPke2YJWlLgCPcVWhmaZc4Dc=;
        b=AobVoFOZ1oGQoKijDR+1SYYlOK+XTEM4I5DonYT7t0TasL+gwjfhPIDJkCvcATFiyB
         ARQ+1SdXjFtYJNAOaLfIIJQq3Bj4S46bFLxBMTPmLuvwcWlaH5a/UQPzrCy3zTo+PZsi
         rit/24p6DZe2mk6jsM40n1xSXgE3Oed1iJhs4uhlK6JT+V3eKHJhl9229oUAWUJeNbi2
         3/TrAINjUiJGJ9Afk3RWPvazMBrvR+orhibhpB5PDs8ZU6cd/Uq7iO78tl3kbPfs4Qi/
         zPQcMh9h+tvWsyddAS8YcM0Xm8PrhLtq9ggMeKPCSWtjjBsIqwts0wAKOZIpXeZO4Glq
         fRZA==
X-Received: by 10.68.162.133 with SMTP id ya5mr49315pbb.110.1371117000694;
 Thu, 13 Jun 2013 02:50:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.69.17.33 with HTTP; Thu, 13 Jun 2013 02:49:18 -0700 (PDT)
In-Reply-To: <20130613.022524.568792627006552244.davem@davemloft.net>
References: <1371066785-17168-1-git-send-email-florian@openwrt.org>
 <20130613.014450.1434692343011842828.davem@davemloft.net> <CAGVrzcYE4VDWtL_Uj1DrkZ6GqX6ghqPAXPpyLptc6PGwReixSQ@mail.gmail.com>
 <20130613.022524.568792627006552244.davem@davemloft.net>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 13 Jun 2013 10:49:18 +0100
X-Google-Sender-Auth: 3BKusIS9R10h3KbmGGtvRZ0S8z0
Message-ID: <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
Subject: Re: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345 Ethernet
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, ralf@linux-mips.org,
        John Crispin <blogic@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        mbizon <mbizon@freebox.fr>, jogo@openwrt.org,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2013/6/13 David Miller <davem@davemloft.net>
>
> From: Florian Fainelli <florian@openwrt.org>
> Date: Thu, 13 Jun 2013 09:58:34 +0100
>
> > 2013/6/13 David Miller <davem@davemloft.net>:
> >> From: Florian Fainelli <florian@openwrt.org>
> >> Date: Wed, 12 Jun 2013 20:53:05 +0100
> >>
> >>> +#ifdef BCMCPU_RUNTIME_DETECT
> >>
> >> I want the MIPS folks to fix this brain damange.
> >>
> >> This runtime detect thing is just a big mess in a header file
> >> using hundreds of lines of CPP stuff to express what is fundamentally
> >> a simple (albeit sizable) Kconfig dependency.
> >
> > The codebase supporting the Broadcom BCM63xx SoC supports about 6-7
>
> You don't need to explain it to me, I read the code and understand
> what it's trying to accomplish.
>
> I reject the implementation of it, only.
>
> > No, the ifdefs are kept in the arch/mips/bcm63xx portions of the code
> > specifically for that reason. The driver just needs to take into account a
> > new set of platform_data properties to deal with this.
>
> Fine, it's still terrible.

We are in the slow process to switch to Device Tree to precisely
eliminate all of this (although not everyone agrees yet on the
details). Hopefully you should not see such things in the future.

Thanks
