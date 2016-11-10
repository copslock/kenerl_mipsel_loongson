Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 10:05:55 +0100 (CET)
Received: from Galois.linutronix.de ([146.0.238.70]:55238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993021AbcKJJFsi22pu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2016 10:05:48 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1c4lGm-0004qh-9h; Thu, 10 Nov 2016 10:03:40 +0100
Date:   Thu, 10 Nov 2016 10:03:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        k@vodka.home.kg
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
In-Reply-To: <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611100959040.3501@nanos>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com> <alpine.DEB.2.20.1611092227200.3501@nanos> <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55767
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

On Thu, 10 Nov 2016, Jason A. Donenfeld wrote:

> Hey Thomas,
> 
> On Wed, Nov 9, 2016 at 10:40 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > That preempt_disable() prevents merily preemption as the name says, but it
> > wont prevent softirq handlers from running on return from interrupt. So
> > what's the point?
> 
> Oh, interesting. Okay, then in that case the proposed define wouldn't
> be useful for my purposes.

If you want to go with that config, then you need
local_bh_disable()/enable() to fend softirqs off, which disables also
preemption.

> What clever tricks do I have at my disposal, then?

Make MIPS use interrupt stacks.
 
> >> If not, do you have a better solution for me (which doesn't
> >> involve using kmalloc or choosing a different crypto primitive)?
> >
> > What's wrong with using kmalloc?
> 
> It's cumbersome and potentially slow. This is crypto code, where speed
> matters a lot. Avoiding allocations is usually the lowest hanging
> fruit among optimizations. To give you some idea, here's a somewhat
> horrible solution using kmalloc I hacked together: [1]. I'm not to
> happy with what it looks like, code-wise, and there's around a 16%
> slowdown, which isn't nice either.

Does the slowdown come from the kmalloc overhead or mostly from the less
efficient code?

If it's mainly kmalloc, then you can preallocate the buffer once for the
kthread you're running in and be done with it. If it's the code, then bad
luck.

Thanks,

	tglx
