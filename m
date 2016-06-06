Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 15:58:46 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34605 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042637AbcFFN6mFXMJV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2016 15:58:42 +0200
Received: by mail-oi0-f67.google.com with SMTP id r4so5514496oib.1;
        Mon, 06 Jun 2016 06:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9RN7X/VFmrFENHE8ClYbed9uebGv1jWsK3MciELymDM=;
        b=Xhv15W8SRMtQ0MkDabrk/r4VYNbkFHCNmB1d8NRp+sxpAAb9MhknJ+DoYUD97VIOcp
         D3OX7tax7Burjsa7Da6q/+hhLguNwiQF7G3WTD83vCf/f20JfgCI8YdLQTPMc+ya3RH4
         D7ZNolsdWX186UFTCwUV826vKEvVNNuZyODk1ots197HAln31wMH5Yk1bIGh5wdZNVxf
         EPZcsbxErTi0t3Z+bhw0QAwbZiiNtHM82JdfzB8IcmCA610rDr+/NVsfpR553B4BCWik
         P6uFME67T2Q0j36nMpI5lIOaYc+M/AlAnRMUBZplts7tQN2J6/bEhSeVBQZtwJ0ej2mK
         /VdQ==
X-Gm-Message-State: ALyK8tJiim2lONNuZRsmd7QFFhFF+jgqwxPONpVIQ81v3B7T0RyrTXk8VujuGtgWr8p++g==
X-Received: by 10.202.44.201 with SMTP id s192mr2436730ois.122.1465221516246;
        Mon, 06 Jun 2016 06:58:36 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id f39sm10462298otb.25.2016.06.06.06.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 06:58:35 -0700 (PDT)
Date:   Mon, 6 Jun 2016 08:58:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu
Subject: Re: [PATCH 2/3] MIPS: BMIPS: Add BCM6345 support
Message-ID: <20160606135834.GA28996@rob-hp-laptop>
References: <1464941524-3992-1-git-send-email-noltari@gmail.com>
 <1464941524-3992-2-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1464941524-3992-2-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53888
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

On Fri, Jun 03, 2016 at 10:12:03AM +0200, Álvaro Fernández Rojas wrote:
> BCM6345 has only one CPU, so SMP support must be disabled.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>  arch/mips/bmips/setup.c                             | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> index 4a7e030..1936e8a 100644
> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> @@ -4,7 +4,7 @@ Required properties:
>  
>  - compatible: "brcm,bcm3384", "brcm,bcm33843"
>                "brcm,bcm3384-viper", "brcm,bcm33843-viper"
> -              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
> +              "brcm,bcm6328", "brcm,bcm6345", "brcm,bcm6358", "brcm,bcm6368",
>                "brcm,bcm63168", "brcm,bcm63268",
>                "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
>                "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"

Are these all mutually exclusive? Please make that clear.
