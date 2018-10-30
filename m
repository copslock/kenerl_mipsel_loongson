Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 17:25:50 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992280AbeJ3QZqZ7djg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 17:25:46 +0100
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6886B2080A;
        Tue, 30 Oct 2018 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540916739;
        bh=BpLXbgTMoCldlPE49gLx+51rh2pGgzQahB1P37hnd9U=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=rQRqoyaBejiwKND+T3zpb6a/wkDAA83hHVKopz0SsFRGTpH8vNDoC6q8DMS1+/trA
         0vr5gH+jwQ7+a3hIPaQ1dREDL5R46yDJ/Vr2znRg+8taDhIf3RBO48Pg1qJnAnCPSa
         ZDTBQ7caSy80Tev2GUqqro7CNv1ddL8FJkmKuk78=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     wang.yi59@zte.com.cn
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <201810301413240217200@zte.com.cn>
Cc:     paul.burton@mips.com, mturquette@baylibre.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        up2wing@163.com
References: 1540801907-31544-1-git-send-email-wang.yi59@zte.com.cn,
 154083382731.98144.10932242759017894372@swboyd.mtv.corp.google.com
 <201810301413240217200@zte.com.cn>
Message-ID: <154091673873.98144.2128870769302542417@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: =?utf-8?q?Re=3A=C2=A0Re=3A_=5BPATCH_v2=5D_clk=3A_boston=3A_fix_possible_m?=
 =?utf-8?q?emory_leak_in_clk=5Fboston=5Fsetup=28=29?=
Date:   Tue, 30 Oct 2018 09:25:38 -0700
Return-Path: <sboyd@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@kernel.org
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

Quoting wang.yi59@zte.com.cn (2018-10-29 23:13:24)
> > Quoting Yi Wang (2018-10-29 01:31:47)
> > > 'onecell' is malloced in clk_boston_setup(), but is not freed
> > > before leaving from the error handling cases.
> >
> > How did you find this? Visual inspection? Some coccinelle script?
> 
> Smatch report this:
> drivers/clk/imgtec/clk-boston.c:76 clk_boston_setup() warn: possible memory leak of 'onecell'
> drivers/clk/imgtec/clk-boston.c:83 clk_boston_setup() warn: possible memory leak of 'onecell'
> drivers/clk/imgtec/clk-boston.c:90 clk_boston_setup() warn: possible memory leak of 'onecell'

Ok. Please include those details in the commit text.

> 
> >
> > >
> > > Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > > ---
> > > v2: fix syntax issue in comment, thanks to  Sergei.
> > >
> > >  drivers/clk/imgtec/clk-boston.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
> > > index 15af423..f5d54a6 100644
> > > --- a/drivers/clk/imgtec/clk-boston.c
> > > +++ b/drivers/clk/imgtec/clk-boston.c
> > > @@ -73,27 +73,32 @@ static void __init clk_boston_setup(struct device_node *np)
> > >         hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
> > >         if (IS_ERR(hw)) {
> > >                 pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
> > > -               return;
> > > +               goto error;
> > >         }
> > >         onecell->hws[BOSTON_CLK_INPUT] = hw;
> > >
> > >         hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
> > >         if (IS_ERR(hw)) {
> > >                 pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
> > > -               return;
> > > +               goto error;
> > >         }
> > >         onecell->hws[BOSTON_CLK_SYS] = hw;
> > >
> > >         hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
> > >         if (IS_ERR(hw)) {
> > >                 pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
> > > -               return;
> > > +               goto error;
> > >         }
> > >         onecell->hws[BOSTON_CLK_CPU] = hw;
> > >
> > >         err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
> > >         if (err)
> > >                 pr_err("failed to add DT provider: %d\n", err);
> > > +
> > > +       return;
> > > +
> > > +error:
> > > +       kfree(onecell);
> >
> > Ok, sure. But then clks are still left registered on failure?
> 
> Yeah, but this patch does not change the original flow of the function, so I suppose
> if you deem this is not proper, it's better to improve that in another patch, what do
> you think?
> 

I think we should attempt to fix all the theoretical problems with the
driver instead of just fixing some things to make static checkers happy.
It looks like this driver was written with the assumption that if things
go bad we give up all hope. It would be better to clean everything up
properly if things go bad and have better code.
