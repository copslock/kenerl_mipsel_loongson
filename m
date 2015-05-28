Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 20:36:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32777 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007627AbbE1SgjTTKry (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 May 2015 20:36:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4SIafpe012125;
        Thu, 28 May 2015 20:36:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4SIafR1012124;
        Thu, 28 May 2015 20:36:41 +0200
Date:   Thu, 28 May 2015 20:36:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: strnlen_user.S: Fix a CPU_DADDI_WORKAROUNDS
 regression
Message-ID: <20150528183640.GE7012@linux-mips.org>
References: <alpine.LFD.2.11.1505271631400.21603@eddie.linux-mips.org>
 <20150528171817.GD7012@linux-mips.org>
 <alpine.LFD.2.11.1505281829400.21603@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1505281829400.21603@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47716
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

On Thu, May 28, 2015 at 06:51:27PM +0100, Maciej W. Rozycki wrote:

> On Thu, 28 May 2015, Ralf Baechle wrote:
> 
> > >  The jump to the delay slot combined with the unusual register usage 
> > > convention taken here made it trickier than it would normally be to make a 
> > > fix that does not regress -- in terms of code size -- unaffected microMIPS 
> > > systems.  I tried several versions and eventually I came up with this one 
> > > that I believe produces the best code in all cases, at the cost of these 
> > > #ifdefs.  I hope they are acceptable.
> > 
> > I think it's all a hint to rewrite the thing in a language that
> > transparently handles the DADDIU issue.  Such as C.  Which would also
> > make using a better algorithm easier.
> 
>  Probably.  One concern that bothers me is the ability of GCC to make 
> alternative entry points into frameless leaf functions.
> 
>  Here we have `__strnlen_kernel_asm' that falls through to 
> `__strnlen_kernel_nocheck_asm'.  That's a nice optimisation (we could 
> probably schedule that `move $v0, $a0' into its preceding delay slot too, 
> even though one might consider it hilarious to have a function's entry 
> point in a delay slot).
> 
>  It would likely be lost in a conversion to C.  But perhaps GCC can get 
> better, or maybe it already has?  I haven't been tracking what's been 
> happening recently on that front.
> 
>  What I have in mind is that given:
> 
> bar() { blah; }
> 
> foo() { blah_blah; bar(); }
> 
> in a single compilation unit, rather than making `foo' tail-jump to `bar' 
> GCC would inline `bar' into `foo' entirely and merely export an additional 
> `bar' entry point in the middle of `foo', where the original body of `bar' 
> begins.

In this particular case we might move the access_ok() in to the
strnlen_user function, something like:

static inline long strnlen_user(const char __user *s, long n)
{
        long res;

        might_fault();

	if (!access_ok(VERIFY_READ, s, 0))
		return 0;

        if (segment_eq(get_fs(), get_ds())) {
                __asm__ __volatile__(
                        "move\t$4, %1\n\t"
                        "move\t$5, %2\n\t"
                        __MODULE_JAL(__strnlen_kernel_nocheck_asm)
                        "move\t%0, $2"
                        : "=r" (res)
                        : "r" (s), "r" (n)
                        : "$2", "$4", "$5", __UA_t0, "$31");
        } else {
                __asm__ __volatile__(
                        "move\t$4, %1\n\t"
                        "move\t$5, %2\n\t"
                        __MODULE_JAL(__strnlen_kernel_nocheck_asm)
                        "move\t%0, $2"
                        : "=r" (res)
                        : "r" (s), "r" (n)
                        : "$2", "$4", "$5", __UA_t0, "$31");
        }

        return res;
}

I'd not be surprised if GCC can optimize that better than the existing
code.

  Ralf
