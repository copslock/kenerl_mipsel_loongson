Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2016 19:47:34 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32878 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992509AbcHDRr04hmXv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2016 19:47:26 +0200
Received: by mail-oi0-f65.google.com with SMTP id l9so26546715oih.0;
        Thu, 04 Aug 2016 10:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f0ejoFGXNicr7U08FlTiGIVQlpJ/r9dvoQ72a6+86FM=;
        b=YmYci9UbhAhKRvIvz6DmQkn95++GbReN1tblxJpRzpmm+m7cqeEzY1MVZKmJLoymjs
         86KvEKXY8MxFFczpjiqdx1bGB5K/SUjORXj14558aYxSaR2khjObnzvYJrgbn/y7epZz
         5IptLd7HQv3eYG6bsiwgL8+zvVyimqFg2Tcp2bTFlvs7jZ0oJVhmTJxiFQSC+azYA5LX
         pBr9afD2411HYb6NywXro4ng0sy40YReUDk+XvYZwUQhlbCmqBxfqv0JDBAF5vUzOmkY
         kjZ7qS8Hlw5YYuC5sDMqbEkNwu18uVx6cXqMxcvFIKj0A9qGbxYLUXM+IVa9Oj6pNxnw
         GbJQ==
X-Gm-Message-State: AEkoouvAQanJ8Ms9ONoLf/toklYEw0MMYOaRl6SSjJRIcRK2lt2wS6wIx5/yY+bbqN5fRQ==
X-Received: by 10.202.72.70 with SMTP id v67mr40783353oia.143.1470332841093;
        Thu, 04 Aug 2016 10:47:21 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id z189sm6686516oig.29.2016.08.04.10.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2016 10:47:20 -0700 (PDT)
Date:   Thu, 4 Aug 2016 12:47:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu, john@phrozen.org
Subject: Re: [PATCH v2 4/7] MIPS: BMIPS: Add BCM3368 support
Message-ID: <20160804174719.GA24679@rob-hp-laptop>
References: <1470218310-2978-4-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1470218310-2978-4-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Aug 03, 2016 at 11:58:27AM +0200, Álvaro Fernández Rojas wrote:
> BCM3368 has a shared TLB which conflicts with current SMP support, so it must
> be disabled for now.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>  arch/mips/bmips/setup.c                             | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> index 4a7e030..65bc572 100644
> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> @@ -2,7 +2,7 @@
>  
>  Required properties:
>  
> -- compatible: "brcm,bcm3384", "brcm,bcm33843"
> +- compatible: "brcm,bcm3368", "brcm,bcm3384", "brcm,bcm33843"

No need to respin just for this, but please make this one valid 
combination per line if you respin the series.

Acked-by: Rob Herring <robh@kernel.org>

>                "brcm,bcm3384-viper", "brcm,bcm33843-viper"
>                "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
>                "brcm,bcm63168", "brcm,bcm63268",
