Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 23:21:31 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34885 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbcA0WV3dN3ek (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 23:21:29 +0100
Received: by mail-pf0-f196.google.com with SMTP id 66so596583pfe.2;
        Wed, 27 Jan 2016 14:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=P6ai613sYCZPQrOp3D2SeTHyElb4dvkcOUyLTLmwsqI=;
        b=bleV0oOnUdIU9fh22dXOvL1VOBsWW2k2LAZsT9ogCo7Uifsxw8tPuD04bsl1/JrFGB
         8OsvnSeW/WbDvIa5OoBBR1bF5F3mfLnp9XCdnjLl+lwAYPOouvfBzH8dhQkHPDd8B8NM
         PFsd+s//T9GHaAZu24N1EuxuPYtRDV4HHlZiFPlT494NOC9iiWQC/exe0xOR1fP5L2hT
         99ZSVWO3y+zq8sJJ3LNIKi5sMiiLGIM88MOanB4hMogEkzDZMo+pwJS+rnznArmcGEzn
         XChEnxgnEJGxhSsGLidLIIjk3hPwiNxc97Tr15iUKXAjtXLzk/2LmPtlYO2Ljn2xUqrD
         ksSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P6ai613sYCZPQrOp3D2SeTHyElb4dvkcOUyLTLmwsqI=;
        b=c25TpgjmfERJ8fHJxlx6cILZ5n+TD7w0rWY5lor6cWESi7rugvDZoMCmJ1LPFYSLS3
         s3r3yDIo9ZHpwPqPO/a6++LopUAPcGr8TB22u6z583Ci4Fi3apXnYsvNgBSn9lWAIC86
         6HQAZBfFvu6/TQS/mIW83zZjrNYwE0jGGn5jvK0aEybC0K2ostG/RvjvU3Nk1srv41tt
         vzNDmi/Em8V3mQpM+A9HHOSB/98/okWU9zKur8tY8Ma1mFJPSTRjeL7GL8AphoP2wk70
         5VJmfallJ5KYCSTOLpf+OvSFj2D+jIGdIiA34QOchCo+m2lJHGEnrq64DkAURWWO+90F
         y2BQ==
X-Gm-Message-State: AG10YORutEr9wMyftdPwAm4/5gD83kOkSWa7LX3eD0aia1DUFGKJhZKeWgqi3yLjiH/bmg==
X-Received: by 10.98.75.22 with SMTP id y22mr46773752pfa.147.1453933283319;
        Wed, 27 Jan 2016 14:21:23 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:6149:7131:eca:637b])
        by smtp.gmail.com with ESMTPSA id 26sm11258375pfo.55.2016.01.27.14.21.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 14:21:22 -0800 (PST)
Date:   Wed, 27 Jan 2016 14:21:20 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, cernekee@gmail.com,
        jogo@openwrt.org, simon@fire.lp0.eu
Subject: Re: [PATCH 2/2] MIPS: BMIPS: Enable partition parser in defconfig
Message-ID: <20160127222120.GA52540@google.com>
References: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
 <1453925596-24661-3-git-send-email-f.fainelli@gmail.com>
 <20160127202302.GB41831@google.com>
 <56A928B1.6000001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A928B1.6000001@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51496
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

On Wed, Jan 27, 2016 at 12:29:37PM -0800, Florian Fainelli wrote:
> On 27/01/16 12:23, Brian Norris wrote:
> > On Wed, Jan 27, 2016 at 12:13:16PM -0800, Florian Fainelli wrote:
> >> Enable CONFIG_MTD_BCM63XX_PARTS in arch/mips/configs/bmips_be_defconfig
> >> since this is a necessary option to parse the built-in flash partition
> >> table on BMIPS big-endian SoCs (Cable Modem and DSL).
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---

> >> --- a/arch/mips/configs/bmips_be_defconfig
> >> +++ b/arch/mips/configs/bmips_be_defconfig
> >> @@ -36,6 +36,7 @@ CONFIG_DEVTMPFS_MOUNT=y
> >>  CONFIG_PRINTK_TIME=y
> >>  CONFIG_BRCMSTB_GISB_ARB=y
> >>  CONFIG_MTD=y
> >> +CONFIG_MTD_BCM63XX_PARTS=y
> > 
> > ^^ This doens't help, AFAICT, because this config doesn't have
> > CONFIG_BCM63XX yet, which CONFIG_MTD_BCM63XX_PARTS depends on.
> > 
> > Or, is that part of what this series will help with: removing the
> > dependency on CONFIG_BCM63XX?
> 
> Yes, I was assuming this would be relative to the patch series below so
> this driver gets usable on BMIPS as well.

OK, that's fine. This patch can actually be taken independently, as this
entry will just get dropped, until the MTD patch gets merged.

In that case:

Acked-by: Brian Norris <computersforpeace@gmail.com>

This will make sure we get immediate defconfig build coverage as soon as
the CONFIG_BCM63XX dependency is relaxed in drivers/mtd/.

> I leave to you and Ralf to resolve how you want to pick up patches in
> this series and resolve the merge.

I think Ralf is now taking care of un-breaking the build, and I'll
review Simon's MTD patches soon, I expect.

> > 
> > http://lists.infradead.org/pipermail/linux-mtd/2015-December/064380.html

Thanks,
Brian
