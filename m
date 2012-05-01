Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 02:23:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47343 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903722Ab2EAAXw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 02:23:52 +0200
Date:   Tue, 1 May 2012 01:23:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, sjhill@realitydiluted.com
Subject: Re: [PATCH 1/5] MIPS: Add support for the 1074K core.
In-Reply-To: <CAOiHx=nRxy-RPhpbZhbMD++qnM2Uqf6=oP9JMvc+6HcciW8ang@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1204300417070.19691@eddie.linux-mips.org>
References: <1333735064-15672-1-git-send-email-sjhill@mips.com> <CAOiHx=nRxy-RPhpbZhbMD++qnM2Uqf6=oP9JMvc+6HcciW8ang@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-archive-position: 33103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, 7 Apr 2012, Jonas Gorski wrote:

> > diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> > index bda8eb2..a08e75d 100644
> > --- a/arch/mips/mm/c-r4k.c
> > +++ b/arch/mips/mm/c-r4k.c
> > @@ -977,7 +977,7 @@ static void __cpuinit probe_pcache(void)
> >                        c->icache.linesz = 2 << lsize;
> >                else
> >                        c->icache.linesz = lsize;
> > -               c->icache.sets = 64 << ((config1 >> 22) & 7);
> > +               c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);
> 
> Why this change? According to the 1074K datasheet it is still 64 *
> 2^S, so to me it looks like the previous version was correct. Also
> adding first and then masking looks really wrong, and will produce
> wrong results for 0x7.

 FWIW the change looks correct to me.  The 3-bit field means 32 for 7, 64 
for 0, 128 for 1, etc., up to 4096 for 6.  It used to be reserved for 7 in 
older versions of the architecture spec (rev. 3.05 referred here).  
Likewise the data cache.

 Of course it should be sent as a separate change too, even if the 1074K 
relies on it (which I suppose is why it's been included here).

  Maciej
