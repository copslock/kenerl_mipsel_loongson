Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 23:07:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55112 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821089AbaFEVHXw-03g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jun 2014 23:07:23 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s55L7KoQ002983;
        Thu, 5 Jun 2014 23:07:20 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s55L7JW3002982;
        Thu, 5 Jun 2014 23:07:19 +0200
Date:   Thu, 5 Jun 2014 23:07:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: gcc warning in my trace_benchmark() code
Message-ID: <20140605210718.GV17197@linux-mips.org>
References: <20140605121204.18ee5f2d@gandalf.local.home>
 <5390A4F0.3000601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5390A4F0.3000601@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40445
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

On Thu, Jun 05, 2014 at 10:12:16AM -0700, David Daney wrote:

> >vim +84 kernel/trace/trace_benchmark.c
> >
> >     78		if (bm_cnt > 1) {
> >     79			/*
> >     80			 * Apply Welford's method to calculate standard deviation:
> >     81			 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
> >     82			 */
> >     83			stddev = (u64)bm_cnt * bm_totalsq - bm_total * bm_total;
> >   > 84			do_div(stddev, bm_cnt);
> >   > 85			do_div(stddev, bm_cnt - 1);
> >     86		} else
> >     87			stddev = 0;
> >     88	
> >
> >
> >
> >Is there something special with do_div in mips that I should be aware
> >of?
> 
> Yes.  MIPS is using the implementation in asm-generic/div64.h,
> which per the comments in that file has a useless pointer compare to
> find just this type of issue.

And it's not the only warning it's picking up.

> Ralf:  As a side note, while looking at
> arch/mips/include/asm/div64.h, I saw that the implementation of
> __div64_32 in that file will be unused, and is also completely
> broken due to the first parameter never being used.

Seems I broke c21004cd5b4cb7d479514d470a62366e8307412c "MIPS: Rewrite
<asm/div64.h> to work with gcc 4.4.0."  Took only five years until
somebody noticed ...

  Ralf
