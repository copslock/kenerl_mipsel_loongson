Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 19:35:13 +0200 (CEST)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:57071 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6843087AbaFERfLGylXg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 19:35:11 +0200
Received: from [67.246.153.56] ([67.246.153.56:52234] helo=gandalf.local.home)
        by cdptpa-oedge02 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id 0A/D9-30880-54AA0935; Thu, 05 Jun 2014 17:35:01 +0000
Date:   Thu, 5 Jun 2014 13:35:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: gcc warning in my trace_benchmark() code
Message-ID: <20140605133500.190eb31d@gandalf.local.home>
In-Reply-To: <5390A4F0.3000601@gmail.com>
References: <20140605121204.18ee5f2d@gandalf.local.home>
        <5390A4F0.3000601@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Thu, 05 Jun 2014 10:12:16 -0700
David Daney <ddaney.cavm@gmail.com> wrote:

> On 06/05/2014 09:12 AM, Steven Rostedt wrote:
> > I'm going through some of the warnings that Fengguang Wu's test bot has
> > discovered, and one of them is from a MIPS allmodconfig build.
> >
> > https://lists.01.org/pipermail/kbuild-all/2014-May/004751.html
> >
> >     kernel/trace/trace_benchmark.c: In function 'trace_do_benchmark':
> >>> kernel/trace/trace_benchmark.c:84:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> >>> kernel/trace/trace_benchmark.c:85:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> >     kernel/trace/trace_benchmark.c:38:6: warning: unused variable 'seedsq' [-Wunused-variable]
> >
> > vim +84 kernel/trace/trace_benchmark.c
> >
> >      78		if (bm_cnt > 1) {
> >      79			/*
> >      80			 * Apply Welford's method to calculate standard deviation:
> >      81			 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
> >      82			 */
> >      83			stddev = (u64)bm_cnt * bm_totalsq - bm_total * bm_total;
> >    > 84			do_div(stddev, bm_cnt);
> >    > 85			do_div(stddev, bm_cnt - 1);
> >      86		} else
> >      87			stddev = 0;
> >      88	
> >
> >
> >
> > Is there something special with do_div in mips that I should be aware
> > of?
> 
> Yes.  MIPS is using the implementation in asm-generic/div64.h,  which 
> per the comments in that file has a useless pointer compare to find just 
> this type of issue.

You mean this comment?

/* The unnecessary pointer compare is there
 * to check for type safety (n must be 64bit)
 */

But stddev is s64. Ah, but the compare is:

(void)(((typeof((n)) *)0) == ((uint64_t *)0));

so it's complaining about a signed verses unsigned compare, not length.
I think I can ignore this warning then.

Thoughts?

-- Steve


> 
> 
> Ralf:  As a side note, while looking at arch/mips/include/asm/div64.h, I 
> saw that the implementation of __div64_32 in that file will be unused, 
> and is also completely broken due to the first parameter never being used.
> 
> David Daney
> 
