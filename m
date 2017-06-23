Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 19:11:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38362 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993857AbdFWRLTE0FzH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Jun 2017 19:11:19 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5NHBC8X011001;
        Fri, 23 Jun 2017 19:11:12 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5NHB3L8010990;
        Fri, 23 Jun 2017 19:11:03 +0200
Date:   Fri, 23 Jun 2017 19:11:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V7 8/9] MIPS: Add __cpu_full_name[] to make CPU names
 more human-readable
Message-ID: <20170623171103.GH6306@linux-mips.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-9-git-send-email-chenhc@lemote.com>
 <20170623151507.GC31455@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623151507.GC31455@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58766
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

On Fri, Jun 23, 2017 at 04:15:07PM +0100, James Hogan wrote:

> On Thu, Jun 22, 2017 at 11:06:55PM +0800, Huacai Chen wrote:
> > diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> > index 4eff2ae..78db63a 100644
> > --- a/arch/mips/kernel/proc.c
> > +++ b/arch/mips/kernel/proc.c
> 
> > @@ -62,6 +63,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >  	seq_printf(m, fmt, __cpu_name[n],
> >  		      (version >> 4) & 0x0f, version & 0x0f,
> >  		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
> > +	if (__cpu_full_name[n])
> > +		seq_printf(m, "model name\t\t: %s @ %uMHz\n",
> > +		      __cpu_full_name[n], mips_hpt_frequency / 500000);
> 
> If the core frequency is useful (I can imagine it being useful for
> humans), maybe it should be on a separate line.
> 
> This also assumes that the mips_hpt_frequency is half the core
> frequency, which may not universally be the case. Perhaps that should be
> abstracted too (at some point, I suppose it doesn't matter right away).

Indeed, there is a number of cores where the counter is incrementing at
the full clock rate and some - I think this was the IDT 5230/5260 class
of devices where the clock rate can be configured through a cold reset
time bitstream but the rate in use can not be detected by software in
a configuration register, so it has to be meassured by comparing to
another known clock.  Whops..

Making the clock part of the name is probably sensible on x86 where there
seem to be different CPU packages being marketed for different clock
rates, so this is more of a marketing name in contrast to an actual
core type.

It's not like on MIPS we're not suffering from creative CPU naming as
well.  It all started in '91 with when the R4000 with its 8k primary
caches was upgraded and then primarily due to its 16k caches sold as
the R4400.  From a software perspective there isn't much of a difference
so calling the R4400 an R4000 is sensible but users might miss an inch
or two if their R4400 is called a lowly R4000 ;-)

  Ralf
