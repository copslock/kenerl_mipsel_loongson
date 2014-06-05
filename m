Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2014 00:17:19 +0200 (CEST)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:52370 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6832290AbaFEWRQVJyzC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jun 2014 00:17:16 +0200
Received: from [67.246.153.56] ([67.246.153.56:53614] helo=gandalf.local.home)
        by cdptpa-oedge01 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id 79/44-06582-46CE0935; Thu, 05 Jun 2014 22:17:09 +0000
Date:   Thu, 5 Jun 2014 18:17:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: gcc warning in my trace_benchmark() code
Message-ID: <20140605181708.7affae05@gandalf.local.home>
In-Reply-To: <5390E788.2030702@gmail.com>
References: <20140605121204.18ee5f2d@gandalf.local.home>
        <5390A4F0.3000601@gmail.com>
        <20140605133500.190eb31d@gandalf.local.home>
        <5390BA9D.3090402@gmail.com>
        <20140605145339.57c5be79@gandalf.local.home>
        <5390E788.2030702@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40448
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

On Thu, 05 Jun 2014 14:56:24 -0700
David Daney <ddaney.cavm@gmail.com> wrote:

 
> Evidently it is.
> 
> The top of asm-generic/div64.h has:
> 
> .
> .
> .
>   * The semantics of do_div() are:
>   *
>   * uint32_t do_div(uint64_t *n, uint32_t base)
>   * {

That's somewhat lacking. Does this mean that we have no consistent way
to divide a s64 number?

> .
> .
> .
> 
> do_div() really passes the first parameter by reference, and C doesn't 
> have by reference parameters, so the example is not quite right.  But it 
> does seem to imply the thing should be an *unsigned* 64-bit wide variable.
> 
> It has been like this since the beginning of the git epoch.
> 
> > Where is that documented.
> 
> The code is the documentation.
> 
> > I don't
> > see it in the comments, and I don't see anything in the Documentation
> > directory. It only states that n must be 64bit. It doesn't say unsigned
> > 64 bit.
> 
> The handful of call sites I examined, seem to all use u64 or unsigned 
> long long.

and u64 and unsigned long long are usually the standard type to use for
64 bits.

> 
> I get:
> 
>    $ grep -r do_div Documentation | wc
>        0       0       0
> 
> So it would seem that most of the do_div() documentation actually is the 
> code.
> 

Which means there isn't documentation for it.

Anyway, this probably can be safely converted to an unsigned. As I'm
not sure standard deviation can ever be negative.

-- Steve
