Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 22:43:07 +0100 (CET)
Received: from Galois.linutronix.de ([146.0.238.70]:53784 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992990AbcKIVnAvR7P1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 22:43:00 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1c4ac2-00007y-Kc; Wed, 09 Nov 2016 22:40:54 +0100
Date:   Wed, 9 Nov 2016 22:40:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        k@vodka.home.kg
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
In-Reply-To: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611092227200.3501@nanos>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Wed, 9 Nov 2016, Jason A. Donenfeld wrote:
> But for the remaining platforms, such as MIPS, this is still a
> problem. In an effort to work around this in my code, rather than
> having to invoke kmalloc for what should be stack-based variables, I
> was thinking I'd just disable preemption for those functions that use
> a lot of stack, so that stack-hungry softirq handlers don't crush it.
> This is generally unsatisfactory, so I don't want to do this
> unconditionally. Instead, I'd like to do some cludge such as:
> 
>     #ifndef CONFIG_HAVE_SEPARATE_IRQ_STACK
>     preempt_disable();

That preempt_disable() prevents merily preemption as the name says, but it
wont prevent softirq handlers from running on return from interrupt. So
what's the point?

> However, for this to work, I actual need that config variable. Would
> you accept a patch that adds this config variable to the relavent
> platforms?

It might have been a good idea, to cc all relevant arch maintainers on
that ...

> If not, do you have a better solution for me (which doesn't
> involve using kmalloc or choosing a different crypto primitive)?

What's wrong with using kmalloc?

Thanks,

	tglx
