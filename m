Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 20:53:52 +0200 (CEST)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:3621 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6843087AbaFESxroPriR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 20:53:47 +0200
Received: from [67.246.153.56] ([67.246.153.56:50554] helo=gandalf.local.home)
        by cdptpa-oedge02 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id F4/0F-30880-4BCB0935; Thu, 05 Jun 2014 18:53:40 +0000
Date:   Thu, 5 Jun 2014 14:53:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: gcc warning in my trace_benchmark() code
Message-ID: <20140605145339.57c5be79@gandalf.local.home>
In-Reply-To: <5390BA9D.3090402@gmail.com>
References: <20140605121204.18ee5f2d@gandalf.local.home>
        <5390A4F0.3000601@gmail.com>
        <20140605133500.190eb31d@gandalf.local.home>
        <5390BA9D.3090402@gmail.com>
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
X-archive-position: 40444
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

On Thu, 05 Jun 2014 11:44:45 -0700
David Daney <ddaney.cavm@gmail.com> wrote:

> > But stddev is s64. Ah, but the compare is:
> >
> > (void)(((typeof((n)) *)0) == ((uint64_t *)0));
> >
> > so it's complaining about a signed verses unsigned compare, not length.
> > I think I can ignore this warning then.
> 
> The pedant in me thinks that you should fix your code if using do_div() 
> on a signed object is undefined.  But if you aren't planning on merging 
> the code, then it probably doesn't matter.

It's undefined on signed 64 numbers? Where is that documented. I don't
see it in the comments, and I don't see anything in the Documentation
directory. It only states that n must be 64bit. It doesn't say unsigned
64 bit.

And yes I do plan on merging this. It's in my 3.16 queue right now and
in linux-next. But it's just a benchmark tracepoint that requires a
config option to enable it. It will show up in your allmodconfig builds
but nothing important.

Worse comes to worse, I can add a (u64) to the call to do_div() I guess.

> 
> >
> > Thoughts?
> 
> I think I will have lunch now...
> 

I just came back from lunch. It was quite delicious!

-- Steve
