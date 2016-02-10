Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 09:39:06 +0100 (CET)
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34331 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010149AbcBJIjEczxl6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 09:39:04 +0100
Received: by mail-lf0-f42.google.com with SMTP id j78so7162118lfb.1
        for <linux-mips@linux-mips.org>; Wed, 10 Feb 2016 00:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=diPjly4ORFETd5evRyJVNvUHkRW1zhQARz9Dnqoy5Rs=;
        b=tNk1YLvK52C54MlhkOAmmOVDpnR1G7rakSEeR+wB8ugFb8JEr/A300QL+K5/TgoEYo
         jZBBY3qkWBQQ3nesSBNBLxAr20NE2/oiuibl3COimFEouyybbDTQMYOrdCp2i+tq+bNv
         xmIR8jtPGGzZ/bqi4U+kthd5TKNtvkCCWXpgM8bUz93UfNnOcJ0yvdr6IgYdigG+vyK1
         TEAhClHDEWfIVHmua3J/xbxJkUDChM6EViOMDsZ1PlWXhYJRlumMovGVPQbpmbYvugFG
         s4aCFXDLSZs5bL+30yWW00z3KGo4ZVw+/x081lRA8f5hHLSols61vvVQIjVs/uXFekSu
         G9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=diPjly4ORFETd5evRyJVNvUHkRW1zhQARz9Dnqoy5Rs=;
        b=c2KOimXdDqnug13yGEMEOcUIIGc5uInIpsLSbZh6rJHVaKsBJp6gHSLA6REhJcEcTE
         8aoKLs8eP3ids48WPYL7IZlTI1iewkw7g1wmtFIlcMdwPRNkb763Lw9/H3uryVI5C+o0
         HNo58YVtdXqvcHb2GwypONrUkrF7rS9HD71AwtWaRrRjgQ/3/+5VKnTQtozinTcdajSY
         P0YP7Y3ZDgmLt2mzRu7CyoQSJU6x/IAJEDgvpl/EnWQVMZY/bXRDUCLuokJnWkNjFY/p
         P3UlUIuH0gIybmtxlKJWByLTyo7ofD8oBbRxkF/ojPuk7ymj5Qyxpqa2O9Jc3dZFWhSD
         7DVw==
X-Gm-Message-State: AG10YORi9vk+SsyB3XMNBkIniiHDN20VJorNXCZOD2UmJN0ygMpTM2tSO3OHekZJbubu5w==
X-Received: by 10.25.21.90 with SMTP id l87mr15434410lfi.64.1455093539123;
        Wed, 10 Feb 2016 00:38:59 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id n96sm276663lfi.45.2016.02.10.00.38.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Feb 2016 00:38:58 -0800 (PST)
Date:   Wed, 10 Feb 2016 12:04:33 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Marek Vasut <marex@denx.de>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [RFC v5 03/15] MIPS: ath79: use clk-ath79.c driver for AR933X
Message-Id: <20160210120433.5afd96256ea3614ea3f2702a@gmail.com>
In-Reply-To: <20160209230721.660ebd7b@tock>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
        <1455005641-7079-4-git-send-email-antonynpavlov@gmail.com>
        <20160209230721.660ebd7b@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Tue, 9 Feb 2016 23:07:21 +0100
Alban <albeu@free.fr> wrote:

> On Tue,  9 Feb 2016 11:13:49 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Gabor Juhos <juhosg@openwrt.org>
> > Cc: Alban Bedel <albeu@free.fr>
> > Cc: linux-mips@linux-mips.org
> > ---
> >  arch/mips/ath79/clock.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
> > index eb5117c..3c98eba 100644
> > --- a/arch/mips/ath79/clock.c
> > +++ b/arch/mips/ath79/clock.c
> > @@ -24,6 +24,7 @@
> >  #include <asm/mach-ath79/ath79.h>
> >  #include <asm/mach-ath79/ar71xx_regs.h>
> >  #include "common.h"
> > +#include "machtypes.h"
> >  
> >  #define AR71XX_BASE_FREQ	40000000
> >  #define AR724X_BASE_FREQ	5000000
> > @@ -441,7 +442,9 @@ static void __init qca955x_clocks_init(void)
> >  
> >  void __init ath79_clocks_init(void)
> >  {
> > -	if (soc_is_ar71xx())
> > +	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
> > +		/* pass */
> > +	} else if (soc_is_ar71xx())
> 
> This will break all non AR9330 SoC as their clock won't be properly
> initialized, so this is not acceptable.

Actually this can't broke non-OF board.
This breaks only OF AR9132-based board WR1043DN just because I have not
included AR9132-related patches into RFC v5 patcheseries.

But after adding these patches the problem will disappear.

> I would also really prefer if we can avoid having two completely
> different implementation for legacy and OF platforms. Ideally both
> legacy and OF should use the same core code, just with 2 different
> wrappers. The OF wrapper would just need to get the parent clock from
> DT and call the core setup. The legacy code path would need to create
> the fixed rate parent clock with the current hard coded value, call the
> core setup, then register the clkdev and alias mapping.
> 
> I find it important to avoid code duplication because that mean double
> the amount of testing work. But in practice that generally mean that
> only one half get tested as no one wants to do double the work.

I'm completely agreed your plan. The RFC v5 patchseries was intended
to proof of-clk driver implementation. Please not that it's a RFC series.

> > @@ -484,7 +487,6 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
> >  CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
> >  CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
> >  CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
> > -CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
> >  CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
> >  CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
> >  #endif
> 
> This should have been part of the new driver, otherwise this will break
> bisecting as there would be a version with 2 CLK_OF_DECLARE for ar9330.

No, it can't break a bisection because there is no defconfig that enables both simultaneously.
Of cause you always prepare special configuration by hand :) if you wish intentionally
break your bisection.
If I have missed something then please explain exactly the situation then a bisection
can be broken.
 
-- 
Best regards,
  Antony Pavlov
