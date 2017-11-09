Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 17:57:20 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:51075
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990765AbdKIQ5Jg-mxl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 17:57:09 +0100
Received: by mail-pf0-x244.google.com with SMTP id b6so4672364pfh.7;
        Thu, 09 Nov 2017 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BfU2rEY1OUotKgGD+oAyWw9QCO+WEGHpIg10YzCVftY=;
        b=cM5R1fwnol3qWL+r/dBPKwLo85u+qAZXPdRx0WwtJz2+Kg6+DhKuuxDdRG3z+ilGqS
         +Qw5dK0YhXf8r0YpyfwmYKtj/NC9jVR+Ud0YiTM6hb0ITM285xqw2Veqyh/xPxxUCvuE
         uZ980nR2otpFa8rmN5C7WWSZFlrLl/uD9pOg5J3N2e2FkQ7N9MX438bNp0cyJOmj3l3J
         OqciwPcHYczZHKYTWDMKIpnjrqbfsgo4cg2VoG+7EpzemwEahVZ/p/BS/kFtOB7Si5pI
         c+3p7ImtNgaOskDCpJSC4DoElMyBDVTjcUVHUVer7gqsGFNfazdEw44FKg02c2QlU1/s
         Ax/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BfU2rEY1OUotKgGD+oAyWw9QCO+WEGHpIg10YzCVftY=;
        b=msrABPGrAnlrrVn56rmd+ne683qAfl25A3oE5dibVXF6VlNLuaahpFXtBiUwX39kcg
         VWH202ZELnoxra/ghofK3koJKmJZGqgu9BsjNilJ9tPMJEFf+17pjNpJRtN5TimHWJy9
         wDpBmc3RPQ82HDSL4qPOJiuOy7oCsienSZtjzyc14dRWKmnF6pbDnoJhCu0nTNmUBnYw
         N4g0oiBurGQWHd9/Ksr6qjROOdU1vIwwREgIIFqYjSR2RKbMZnS7mMUGmrYu4W71ZyFg
         /AAQIY3Cd2fQIb3OEg1ZJ2JcQq2Esm9ok5B2ERQUUl2+CCisVH6DVUMrbHNg/3Wey0pH
         ASoQ==
X-Gm-Message-State: AJaThX70zRhMyzF2infQWrWIC563OI90qc8AQG2o18wbjgGht2KKTSW4
        zqAnD+d9A5m6v7mDzOHsgmA=
X-Google-Smtp-Source: ABhQp+TNXDgsfWBBVNGE+a/91i0CpHVnGwbo6NT5hX3eZAOi73Gqd4I8smxmk6TMy4+qiVB+pwWQLg==
X-Received: by 10.84.143.195 with SMTP id 61mr1012071plz.357.1510246623086;
        Thu, 09 Nov 2017 08:57:03 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o15sm4205289pfi.110.2017.11.09.08.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2017 08:57:01 -0800 (PST)
Date:   Thu, 9 Nov 2017 08:57:00 -0800
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
Message-ID: <20171109165700.GA23671@roeck-us.net>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
 <20171109074718.GR15260@jhogan-linux>
 <20171109160147.GB19959@roeck-us.net>
 <20171109164342.GR15235@jhogan-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109164342.GR15235@jhogan-linux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60813
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

On Thu, Nov 09, 2017 at 04:43:43PM +0000, James Hogan wrote:
> On Thu, Nov 09, 2017 at 08:01:47AM -0800, Guenter Roeck wrote:
> > On Thu, Nov 09, 2017 at 07:47:19AM +0000, James Hogan wrote:
> > > Hi Wim,
> > > 
> > > On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> > > > This driver works for jz4740 & jz4780
> > > > 
> > > > Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> > > > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > > 
> > > I just noticed that though Ralf applied the other two patches in this
> > > series (defconfig + dt), he hadn't applied this patch.
> > > 
> > > Please can we have an ack from a watchdog maintainer so this can get
> > > into 4.15 via the MIPS tree? It could alternatively go via the watchdog
> > > tree if you prefer.
> > > 
> > 
> > FWIW, according to my logs I did send out a Reviewed-by: some time ago,
> > which normally means that I expect it to go through the watchdog tree.
> > I wasn't aware that you wanted the patch to go through the mips tree.
> > Sorry if I missed that earlier. For the record,
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > since I don't care one way or another.
> 
> Okay thanks, I wasn't sure and don't much mind which way it goes.
> 
> > 
> > I assume you want me to drop this and the related patches from my own
> > watchdpog-next tree to prevent it from showing up in Wim's tree (if
> > it isn't already there). Is that correct ?
> 
> I haven't seen this patch in linux-next, or I wouldn't have mentioned
> it. If its already in some staging tree for 4.15 that I've missed then
> it may as well stay there, otherwise I'll just take it through the MIPS
> tree with your ack.
> 
Looks like none of the patches I reviewed since the last release cycle
made it into watchdog-next, meaning they might all miss the next release.
Guess Wim is busy. Nothing I can do there.

Guenter
