Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 15:34:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38278 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818018Ab3A3OexyIykt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jan 2013 15:34:53 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0UEYqmo025561;
        Wed, 30 Jan 2013 15:34:52 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0UEYpat025560;
        Wed, 30 Jan 2013 15:34:51 +0100
Date:   Wed, 30 Jan 2013 15:34:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Distincting very similar CPUs in cpu-probe.c
Message-ID: <20130130143451.GA19182@linux-mips.org>
References: <CACna6ryTefwz2McxQOaafwsGJJA7Kf46TYAP+BqGLxirYrEP7A@mail.gmail.com>
 <CACna6rxRDreFEVMMrrHtMg+NB5mtzCuOQeppq7=qFKRHRvPGmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rxRDreFEVMMrrHtMg+NB5mtzCuOQeppq7=qFKRHRvPGmQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35638
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jan 30, 2013 at 11:03:12AM +0100, Rafał Miłecki wrote:

> 2013/1/30 Rafał Miłecki <zajec5@gmail.com>:
> > I can see current code in cpu-probe.c handles some (very slightly)
> > different CPUs in the same way:
> >
> > case PRID_IMP_24K:
> > case PRID_IMP_24KE:
> >         c->cputype = CPU_24K;
> >         __cpu_name[cpu] = "MIPS 24Kc";
> >         break;
> >
> > There is almost nothing wrong about this, but setting the same name is
> > a little confusing for users. I wish to see different names in
> > /proc/cpuinfo for PRID_IMP_24K==24Kc and PRID_IMP_24KE==24KEc.
> >
> > Is there a preferred way of handling this? The simplest one seems to
> > be using separated "cases" while still using CPU_24K:
> > case PRID_IMP_24K:
> >         c->cputype = CPU_24K;
> >         __cpu_name[cpu] = "MIPS 24Kc";
> >         break;
> > case PRID_IMP_24KE:
> >         c->cputype = CPU_24K;
> >         __cpu_name[cpu] = "MIPS 24KEc";
> >         break;
> >
> > What do you think about this? Is this acceptable?
> >
> > For some reason I'm not aware of you may prefer adding CPU_24KE at the
> > same time. Does it make any sense?
> 
> Yet another option would be to use
> __cpu_name[cpu] = "MIPS 24Kc / MIPS 24KEc";
> 
> User still won't know which CPU he has, but at least we won't make
> aware MIPS 24KEc owners confused.

Yes, the MIPS naming is confusing.  A 1004K is basically a bunch of 34Ks,
a 1074K a bunch of 74Ks.  1004K/1074K is more the product name of the
whole cluster of CPUs so what should we call the individual CPU cores,
would 34K / 74K be better?

Unfortunately marketing-based naming has a long history in the MIPS world.
>From a software perspective the R4000 and R4400 are virtually identical
processors except the different (8kB vs 16kB) primary caches.  Then again
more significant changes to a core happened that were not reflected in a
change of the marketing name, for example there are MIPS32 R1 and R2
variants of 4K series cores.

Maybe we should use the marketing-names in /proc/cpuinfo primarily for human
consumption but software should rather rely on ISA, ASE and other features
indicates elsewhere.  The patch to export the cp0 config registers in sysfs
by Steven Hill is a good step into that direction.

  Ralf
