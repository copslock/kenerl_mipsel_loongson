Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 17:02:08 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:56317
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbdKIQB53INvX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 17:01:57 +0100
Received: by mail-pf0-x241.google.com with SMTP id 17so4542394pfn.12;
        Thu, 09 Nov 2017 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m9P0cbt9R8rwpkpBGORlcC8/XVPv0ENWKFbpcAK3Jms=;
        b=Ft+Y2o5ZOWsi2TNL90mSVzMiUOUXsspgF/PRxz8y4soqNhdo/XcnQCAVCCVz/GJKlj
         J/RC40QmX4FjZqjC+NNAXZe80/34X30BMJJ6sc8g3SGMHs5anNVmv5eU0FDcgN02WE08
         h72F7Yy7qduoyr4hnLYAU9P9CeyhyCffaX02LfqG78J1F3i0uE7fAYFAtwYMzASb5phW
         O3bluvBLGOOC9u1+lD6vNufOVwiZRP7J1yoqSr3wVlMVKwpJ1bR1nhIxgErxjKGXJbzr
         gXdboBGAKOl86kuN7l/PVlR9GwA8g7NWAgez73UluLRUMTA5jcmn2ExKtvEUNaRnO6xW
         Y7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9P0cbt9R8rwpkpBGORlcC8/XVPv0ENWKFbpcAK3Jms=;
        b=CArHiZDaYrAYA8WxwyIjBP5w2XauBQ9dBm8QQ/l3N+o0i5fBuUPgHha3a4NnW58wEq
         zBnR1XaNrZySDdktIJdk4F4l32xnltW6cQp3HxpYRTFqhvsawLK/FsyVv/DxISjZE3aw
         NdncMbnjHMT/Rn+X6vCV90ZE5n8FBCYNyziHt7H4GpGXPPrUmqAipcqHHIo8T/sRkeYR
         iQdXlWrHmzekLguWQYrnQyTiP+0P9gdf4X64Ytbn7di3oiGakV7w2I95JGi2Mdvynz9S
         fTm1v/0L36RYYPdaD+XSQv7ubkAbfK2lla42TVJEl94cfxkW4taXzExON7s0GEHEZCU/
         /Apw==
X-Gm-Message-State: AJaThX77u41AILOCAfq5RSWXW8cWy6d9bT4U5blNdURH1kZzeg7uzOuI
        ytQVZwObRQTXDsB+fjo34Yg=
X-Google-Smtp-Source: ABhQp+ST3C4jZ/RZLnKZV6dKxpfNL3XY+hhvfKUguj/gkqLd6YnPXaLt1vucgatgFjr5/NpNISNBpg==
X-Received: by 10.98.103.93 with SMTP id b90mr988663pfc.2.1510243309007;
        Thu, 09 Nov 2017 08:01:49 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f24sm15582977pfk.183.2017.11.09.08.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2017 08:01:48 -0800 (PST)
Date:   Thu, 9 Nov 2017 08:01:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <james.hogan@mips.com>
Cc:     Wim Van Sebroeck <wim@iguana.be>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
Message-ID: <20171109160147.GB19959@roeck-us.net>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
 <20171109074718.GR15260@jhogan-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109074718.GR15260@jhogan-linux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Thu, Nov 09, 2017 at 07:47:19AM +0000, James Hogan wrote:
> Hi Wim,
> 
> On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> > This driver works for jz4740 & jz4780
> > 
> > Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> 
> I just noticed that though Ralf applied the other two patches in this
> series (defconfig + dt), he hadn't applied this patch.
> 
> Please can we have an ack from a watchdog maintainer so this can get
> into 4.15 via the MIPS tree? It could alternatively go via the watchdog
> tree if you prefer.
> 

FWIW, according to my logs I did send out a Reviewed-by: some time ago,
which normally means that I expect it to go through the watchdog tree.
I wasn't aware that you wanted the patch to go through the mips tree.
Sorry if I missed that earlier. For the record,

Acked-by: Guenter Roeck <linux@roeck-us.net>

since I don't care one way or another.

I assume you want me to drop this and the related patches from my own
watchdpog-next tree to prevent it from showing up in Wim's tree (if
it isn't already there). Is that correct ?

Guenter

> Thanks
> James
> 
> > ---
> >  drivers/watchdog/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index c722cbfdc7e6..ca200d1f310a 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1460,7 +1460,7 @@ config INDYDOG
> >  
> >  config JZ4740_WDT
> >  	tristate "Ingenic jz4740 SoC hardware watchdog"
> > -	depends on MACH_JZ4740
> > +	depends on MACH_JZ4740 || MACH_JZ4780
> >  	select WATCHDOG_CORE
> >  	help
> >  	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
> > -- 
> > 2.11.0
> > 
> > 
