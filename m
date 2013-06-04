Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:49:48 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:43620 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834964Ab3FDVtrValip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:49:47 +0200
Received: by mail-lb0-f182.google.com with SMTP id r11so147279lbv.13
        for <linux-mips@linux-mips.org>; Tue, 04 Jun 2013 14:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=d7gKWAfj5pPL+LXoeSwX05J+509fwD/i+C4meQ/2MuQ=;
        b=KWbuoxJHQ7qdRJ7twrKrsSp7Ag8i6U8H8XYE5PXFLUFsjK8tia4mcISMyk54Mh6611
         tqh5xmFXFZpyxKjBTNOq8UKUv5y1ml4VvVsj3yu+XvCuXWYHKdGgcTFdI3cRMQaWCXUi
         DetNmU3KskFmwG7I3qJOfgcvg9oY4fxh+SvFUedNg15X1ZYcF0opWgxPPd1i/608YU+M
         RwqWuS8BHFNmswpUqY4PdR0r5ERYej8Sb4V3zM2XTCWokj6+Vr0ZLsuDs4ER0dmu+HcN
         W6FwqDUZ3zCrumykY7iw6Nw8u4C/UXiHlsH/kVJWdUFJ+b2MHc6wHgqrA/nm3RWys2/t
         4SGg==
X-Received: by 10.112.190.42 with SMTP id gn10mr14030022lbc.82.1370382581607;
        Tue, 04 Jun 2013 14:49:41 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-94-103.pppoe.mtu-net.ru. [91.76.94.103])
        by mx.google.com with ESMTPSA id e9sm24972852lbj.3.2013.06.04.14.49.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 14:49:40 -0700 (PDT)
Message-ID: <51AE60F6.80101@cogentembedded.com>
Date:   Wed, 05 Jun 2013 01:49:42 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     davem@davemloft.net, ralf@linux-mips.org, blogic@openwrt.org,
        linux-mips@linux-mips.org, cernekee@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org
Subject: Re: [PATCH 1/3 net-next] bcm63xx_enet: implement reset autoneg ethtool
 callback
References: <1370382094-17821-1-git-send-email-florian@openwrt.org> <1370382094-17821-2-git-send-email-florian@openwrt.org>
In-Reply-To: <1370382094-17821-2-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnjWKD50akN6iiiXcplCA9zajs+miFPNpmvJJJn0ncGN84cvUAiPRHjd0c4Von2vx7+0Rse
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 06/05/2013 01:41 AM, Florian Fainelli wrote:

    Why are you not posting to netdev@vger.kernel.org?

> From: Maxime Bizon <mbizon@freebox.fr>
>
> Implement the rset_nway ethtool callback which uses libphy generic
> autonegotiation restart function.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>   drivers/net/ethernet/broadcom/bcm63xx_enet.c |   15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
> index e46466c..bc1a994 100644
> --- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
> @@ -1328,6 +1328,20 @@ static void bcm_enet_get_ethtool_stats(struct net_device *netdev,
>   	mutex_unlock(&priv->mib_update_lock);
>   }
>   
> +static int bcm_enet_nway_reset(struct net_device *dev)
> +{
> +	struct bcm_enet_priv *priv;
> +
> +	priv = netdev_priv(dev);

     Strange, why not do it in the initializer?

WBR, Sergei
