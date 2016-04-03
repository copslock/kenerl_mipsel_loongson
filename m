Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 16:41:33 +0200 (CEST)
Received: from proxima.lp0.eu ([81.2.80.65]:41090 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007080AbcDCOlciVrW1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Apr 2016 16:41:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu
        ; s=exim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T85EpemU+/Nw3iM/EUpm+z72+tiWQ5+fxD6Nmu9gvrw=; b=jC6kswQY+sBl1so1eacQXQD09s
        SZQHcnvUDTZjKfwclsSVdfSWv4HxX8S5FQpF89W5jujk66jaHqKPXcDRHK0jTybnu5oRn05lxdkQM
        On4YR+CBCxHY2DKe671yGW0DodHl8mSatp9Fh5ZF2EtUvk4glUHf1LVKOsY1t9x1gY2iZG+vEdq/D
        qql7oSHjTWficiKbZ2VDxLdzeZgjjGLORV87Ed1sD02/1G30wgbhExAcmTEPr1hdwgwH2O1yR9D8+
        ZN5ZyXQP1yUrlddOQh92ut54mDE2KYKyFz0EJ8ixYugIoEP81wpuKhGYuio3rBCZ06MWcPKqIIr6y
        lpaZeTnA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:41116)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (TLSv1.2:ECDHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1amjDQ-0003L7-Fs (Exim); Sun, 03 Apr 2016 15:41:25 +0100
Subject: Re: [PATCH] bmips: rename BCM63168 to BCM63268
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
References: <1459684846-11308-1-git-send-email-noltari@gmail.com>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <57012B92.6040102@simon.arlott.org.uk>
Date:   Sun, 3 Apr 2016 15:41:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459684846-11308-1-git-send-email-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 03/04/16 13:00, Álvaro Fernández Rojas wrote:
> BCM63168 and BCM63268 are very similar and Broadcom refers to them as BCM63268

They are practically the same but they both exist.

> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index 38b5bd5..bfee6ea 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -112,10 +112,10 @@ static void bcm6368_quirks(void)
>  static const struct bmips_quirk bmips_quirk_list[] = {
>  	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
>  	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
> +	{ "brcm,bcm63268",		&bcm6368_quirks			},
>  	{ "brcm,bcm6328",		&bcm6328_quirks			},
>  	{ "brcm,bcm6358",		&bcm6358_quirks			},
>  	{ "brcm,bcm6368",		&bcm6368_quirks			},
> -	{ "brcm,bcm63168",		&bcm6368_quirks			},

You can add "brcm,bcm63268" but you can't remove support for
"brcm,bcm63168".

>  	{ },
>  };
>  
> 

-- 
Simon Arlott
