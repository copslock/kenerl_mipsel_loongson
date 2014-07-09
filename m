Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 21:49:46 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:49363 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861351AbaGITtntdxrE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 21:49:43 +0200
Received: by mail-oa0-f49.google.com with SMTP id i7so8640455oag.22
        for <multiple recipients>; Wed, 09 Jul 2014 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1/zDLVIIeopZE5KofWxNIaq0ORlqXWZNzD8V5pfEs08=;
        b=AB30+kAP/y7qONPfPH7oFB8wjV0mktKqMGIQxHk0WE9SMf91Ah+Tw2Wbk6oe4fMriL
         OpRcLw9uxdggQ/0cgeke1Tr+xh3dM79j+CMAR5kMvlfVn6BCEdREIqb2bCpeuCYV/hF4
         +EL4iUg15YXdJ4i2pL7zvBmriJpdiIpR28vsthtQGoHAd2/L+Oxm3ayRh5+JaPO6xs7d
         SgyYlPdfX6+DVeWaqZbu+60Osx6bXmnjPWfPBKSmK7RIPssR1AlE7Z/k1tLfRfIkRf4y
         QYtQYWDfbqKSFldUii90a2jn8Zzk4a8W7ZPxiYGJCUVBjF9C2OCClA+4JC1KhuL4UFjH
         0FHA==
X-Received: by 10.182.44.197 with SMTP id g5mr50082261obm.18.1404935376923;
 Wed, 09 Jul 2014 12:49:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.9.82 with HTTP; Wed, 9 Jul 2014 12:48:56 -0700 (PDT)
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 9 Jul 2014 12:48:56 -0700
X-Google-Sender-Auth: h9KWjjzMQXeCJ8s8May3H8_M8V4
Message-ID: <CAGVrzcbeLiAawsa0_frhogZdgBeUpf-q2rfZ4X2L3+t54H+j-g@mail.gmail.com>
Subject: Re: [PATCH 0/8] MIPS: BCM63XX: remove !RUNTIME_DETECT support
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41107
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

2014-07-08 7:53 GMT-07:00 Jonas Gorski <jogo@openwrt.org>:
> The advantages compared to the added maintaince burden of ensuring
> that changes don't break the single-soc support with !RUNTIME_DETECT
> are rather small, so remove it.
>
> The only place where it might have any impact might be the irq code.
> But even then replacing it with UASM might be a better choice, as it
> would then profit all targets.
>
> P.S: there is a small lie in 7/8, but since BCM6318 support isn't
> yet upstream, it is valid for the current code. BCM6318 has only
> a BCM3300 CPU, but it does have dc aliases (at least according to
> the bootlog).

Looks good to me, thanks Jonas!

Acked-by: Florian Fainelli <florian@openwrt.org>

>
> Jonas Gorski (8):
>   MIPS: BCM63XX: remove !RUNTIME_DETECT code from register sets
>   MIPS: BCM63XX: remove !RUNTIME_DETECT from irq setup code
>   MIPS: BCM63XX: remove !RUNTIME_DETECT from reset code
>   MIPS: BCM63XX: remove !RUNTIME_DETECT code from gpio code
>   MIPS: BCM63XX: remove !RUNTIME_DETECT from spi code
>   MIPS: BCM63XX: remove !RUNTIME_DETECT usage from enet code
>   MIPS: BCM63XX: remove !RUNTIME_DETECT in cpu-feature-overrides
>   MIPS: BCM63XX: remove !RUNTIME_DETECT code for bcmcpu_get_id
>
>  arch/mips/bcm63xx/cpu.c                            |  11 +-
>  arch/mips/bcm63xx/dev-enet.c                       |   4 -
>  arch/mips/bcm63xx/dev-spi.c                        |   4 -
>  arch/mips/bcm63xx/gpio.c                           |  14 --
>  arch/mips/bcm63xx/irq.c                            | 109 ------------
>  arch/mips/bcm63xx/reset.c                          |  60 -------
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   | 198 ++++-----------------
>  .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    |  46 -----
>  .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |  31 ----
>  .../asm/mach-bcm63xx/cpu-feature-overrides.h       |   2 +-
>  10 files changed, 39 insertions(+), 440 deletions(-)
>
> --
> 2.0.0



-- 
Florian
