Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2016 03:26:32 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35324 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008373AbcCEC0aGygdy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2016 03:26:30 +0100
Received: by mail-pa0-f42.google.com with SMTP id bj10so44629470pad.2;
        Fri, 04 Mar 2016 18:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HCXvgL4KOvyny/eXy1WFg7+0423RyCDQEo3Xewg3m0U=;
        b=LELBsLQSZKjTcL0bane/heFhcb4CaQCRPxOEEDobZhj1JTXZM5TPDLwX0SskZkRRSv
         DNhXQVBN7sjQUrjEqGqnLpWgh1TWB+SS7XrTcslwEdnyK55XKVx4aUCHSihVVRs8uxaO
         g0EqeT9ibWDeIfDL0o5TKngs61q/BuEI3KYWkIsCyOGHpa5WxeddpMuel02GeszaB65X
         +WfAuJMO/PJal7ywPjT9yYB8TRp4nqk58d71ibE9BhdAd7oZcl4QjWea4Dz06njD25yt
         6/Cf19CcSdy4ixS1UHzm+vcxJVuK5ztaFjuXo6OPYrmeoloA8UDrgellqMuGLlJTl9ZY
         bRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HCXvgL4KOvyny/eXy1WFg7+0423RyCDQEo3Xewg3m0U=;
        b=kJT97RvyyXxjXhIUZnSgIAmMA3oWqRp9QEz1AqnOK70T2wPr3u8BRcZJfTP3rqf4DL
         dSrzysdhIXAVzTCZoFF3d5uKRhGBjNSm7M9Tu+hWILZNb11Q9opyv8hbTQ9TC8RPMdIl
         KoQWEnxHambtxfFvCygblJLGugwR9ADAQfWw/5rFNX0z7RMPfic8Co+A+0csp1sU9zXU
         fu1TkgAzBAXdDHFrAQtYN1/IrbwulriWmJ5K2yZri1fb3N27dgskziz2swiemjxzXHX6
         BCtPQ9JjuuQQOZP3+Kp2Drj5XP0NrbopPLNZawQRftWglq107cJOsLtPymfH/2LXXKtn
         3icg==
X-Gm-Message-State: AD7BkJLB4Rex/W616k3Lp0zjQcAEaWIrdGIEG5xo2C/EXdlA8EoTnn7jRFEDsCqbKZwf5A==
X-Received: by 10.66.159.232 with SMTP id xf8mr605884pab.71.1457144784249;
        Fri, 04 Mar 2016 18:26:24 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:388b:a816:9e96:dcd8])
        by smtp.gmail.com with ESMTPSA id h85sm8326076pfj.52.2016.03.04.18.26.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 18:26:23 -0800 (PST)
Date:   Fri, 4 Mar 2016 18:26:21 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 16/52] mtd: nand: use mtd_set_ecclayout() where
 appropriate
Message-ID: <20160305022621.GN55664@google.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
 <1456448280-27788-17-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456448280-27788-17-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Fri, Feb 26, 2016 at 01:57:24AM +0100, Boris Brezillon wrote:
> Use the mtd_set_ecclayout() helper instead of directly assigning the
> mtd->ecclayout field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/nand_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 17504f2..5093a3c 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -4288,7 +4288,7 @@ int nand_scan_tail(struct mtd_info *mtd)
>  		ecc->write_oob_raw = ecc->write_oob;
>  
>  	/* propagate ecc info to mtd_info */
> -	mtd->ecclayout = ecc->layout;
> +	mtd_set_ecclayout(mtd, ecc->layout);

I'm having trouble applying this one. For the life of me, I can't figure
out where you got this context from. This block only appears much later
in nand_scan_tail()...

Do you think you could post a git tree with your intended changes? I may
just try to pull something in like that instead.

BTW, I'm not sure the OMAP refactorings are going to come in time, but I
was planning to pull those directly from the TI folks (i.e., they won't
be rebased on l2-mtd.git), since there's some intermingling of platform
changes there. I think I can fix the conflicts fine, but FYI.

Brian

>  	mtd->ecc_strength = ecc->strength;
>  	mtd->ecc_step_size = ecc->size;
>  
> -- 
> 2.1.4
> 
