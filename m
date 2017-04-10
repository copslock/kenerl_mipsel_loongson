Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 13:05:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58240 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993920AbdDJLFOPj70I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 13:05:14 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3AB5CPj026787;
        Mon, 10 Apr 2017 13:05:12 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3AB5Bmw026784;
        Mon, 10 Apr 2017 13:05:11 +0200
Date:   Mon, 10 Apr 2017 13:05:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        wuzhangjin@gmail.com, linux-mips@linux-mips.org,
        tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()
Message-ID: <20170410110511.GE24214@linux-mips.org>
References: <20170404154957.19678-1-bigeasy@linutronix.de>
 <20170410103153.GK24555@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410103153.GK24555@vireshk-i7>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Apr 10, 2017 at 04:01:53PM +0530, Viresh Kumar wrote:

> On 04-04-17, 17:49, Sebastian Andrzej Siewior wrote:
> > It is pure mystery to me why we need to be on a specific CPU while
> > looking up a value in an array.
> > My best shot at this is that before commit d4019f0a92ab ("cpufreq: move
> > freq change notifications to cpufreq core") it was required to invoke
> > cpufreq_notify_transition() on a special CPU.
> > 
> > Since it looks like a waste, remove it.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  drivers/cpufreq/loongson2_cpufreq.c | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> > index 6bbdac1065ff..9ac27b22476c 100644
> > --- a/drivers/cpufreq/loongson2_cpufreq.c
> > +++ b/drivers/cpufreq/loongson2_cpufreq.c
> > @@ -51,19 +51,12 @@ static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
> >  static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
> >  				     unsigned int index)
> >  {
> > -	unsigned int cpu = policy->cpu;
> > -	cpumask_t cpus_allowed;
> >  	unsigned int freq;
> >  
> > -	cpus_allowed = current->cpus_allowed;
> > -	set_cpus_allowed_ptr(current, cpumask_of(cpu));
> > -
> >  	freq =
> >  	    ((cpu_clock_freq / 1000) *
> >  	     loongson2_clockmod_table[index].driver_data) / 8;
> >  
> > -	set_cpus_allowed_ptr(current, &cpus_allowed);
> > -
> >  	/* setting the cpu frequency */
> >  	clk_set_rate(policy->clk, freq * 1000);
> 
> It was Zhangjin who wrote the first version and he may be able to
> answer the questions we have. Anyway, it is safe to apply this patch
> right now.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for the ack, patch applied.

I noticed some of the other cpufreq drivers seem to be using similar
constructs.

  Ralf
