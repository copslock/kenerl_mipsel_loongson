Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 20:35:13 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:45254 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816383AbaDCSfIhEpM3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2014 20:35:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id F1CBD19C02D;
        Thu,  3 Apr 2014 21:35:06 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id Rv9OHcMGLl9z; Thu,  3 Apr 2014 21:35:00 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 834615BC016;
        Thu,  3 Apr 2014 21:34:59 +0300 (EEST)
Date:   Thu, 3 Apr 2014 21:30:54 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS/loongson2_cpufreq: fix CPU clock rate setting
Message-ID: <20140403183053.GA9247@drone.musicnaut.iki.fi>
References: <1396465624-21661-1-git-send-email-aaro.koskinen@iki.fi>
 <CAKohpokxg=UsiXyq1kJAqgVyj6qYoiQfryfpXGebPtB4f253FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKohpokxg=UsiXyq1kJAqgVyj6qYoiQfryfpXGebPtB4f253FQ@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Thu, Apr 03, 2014 at 09:51:41AM +0530, Viresh Kumar wrote:
> On 3 April 2014 00:37, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Loongson2 has been using (incorrectly) kHz for cpu_clk rate. This has
> > been unnoticed, as loongson2_cpufreq was the only place where the rate
> > was set/get. After commit 652ed95d5fa6074b3c4ea245deb0691f1acb6656
> > (cpufreq: introduce cpufreq_generic_get() routine) things however broke,
> > and now loops_per_jiffy adjustments are incorrect (1000 times too long).
> > The patch fixes this by changing cpu_clk rate to Hz.
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/mips/loongson/lemote-2f/clock.c | 7 +++++--
> >  drivers/cpufreq/loongson2_cpufreq.c  | 4 ++--
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/mips/loongson/lemote-2f/clock.c b/arch/mips/loongson/lemote-2f/clock.c
> > index aed32b8..699f388 100644
> > --- a/arch/mips/loongson/lemote-2f/clock.c
> > +++ b/arch/mips/loongson/lemote-2f/clock.c
> > @@ -91,6 +91,7 @@ EXPORT_SYMBOL(clk_put);
> >
> >  int clk_set_rate(struct clk *clk, unsigned long rate)
> >  {
> > +       unsigned int rate_khz;
> 
> Initialize rate_khz here only instead of doing it separately..

Ok.

> From here:
> 
> >         for (i = 0; loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END;
> >              i++) {
> >                 if (loongson2_clockmod_table[i].frequency ==
> >                     CPUFREQ_ENTRY_INVALID)
> >                         continue;
> > -               if (rate == loongson2_clockmod_table[i].frequency)
> > +               if (rate_khz == loongson2_clockmod_table[i].frequency)
> >                         break;
> >         }
> > -       if (rate != loongson2_clockmod_table[i].frequency)
> > +       if (rate_khz != loongson2_clockmod_table[i].frequency)
> >                 return -ENOTSUPP;
> 
> To here:
> 
> All this code is junk and not required anymore as rate is guaranteed
> to be in loongson2_clockmod_table[].. Probably you need value of
> 'i' here and you can pass that directly from loongson2_cpufreq_target().

But then we couldn't use clk_set_rate()? Anyway I think that should
be done with separate patch(es), which probably would not qualify
for 3.14-stable or 3.15-rc.

A.
