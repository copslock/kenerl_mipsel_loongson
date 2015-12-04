Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 18:13:40 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45902 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013222AbbLDRNiNzTS6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2015 18:13:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=F7uHtHem+vWKKWw2mq+bWZJ0U8ANEP49CY4YTQ9wnUo=;
        b=azwC2J4x9zQawE1WEzlM4VWtJvuSzzg2auyWHOmuwHM++ZuGEYi1i7fbhKlx5v95TglfDdDqMLGPCgAgnhTtJxWCENOjpm0sKQu6IEuoIEK/S7O/fggZ3xI2XvwhhKZK0CHnQHV91ATScRr66c4Lx7XUe8eMAnADMKDEItCcTN8=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:45020)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1a4tum-0000jT-1i; Fri, 04 Dec 2015 17:13:00 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1a4tuh-0002u0-Go; Fri, 04 Dec 2015 17:12:55 +0000
Date:   Fri, 4 Dec 2015 17:12:55 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI
 context
Message-ID: <20151204171255.GZ8644@n2100.arm.linux.org.uk>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151204152709.GA20935@pathway.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Fri, Dec 04, 2015 at 04:27:09PM +0100, Petr Mladek wrote:
> On Tue 2015-12-01 23:44:37, Russell King - ARM Linux wrote:
> > On Fri, Nov 27, 2015 at 12:09:30PM +0100, Petr Mladek wrote:
> > > What we can do, though, is to zap all printk locks. We already do this
> > > when a printk recursion is detected. This should be safe because
> > > the system is crashing and there shouldn't be any printk caller
> > > that would cause the deadlock.
> > 
> > What about serial consoles which may call out to subsystems like the
> > clk subsystem to enable a clock, which would want to take their own
> > spinlocks in addition to the serial console driver?
> 
> Yes, there might be more locks used by the serial console but I do
> not know how to handle them all easily. IMHO, this patch is just better
> than nothing.

I have a slightly different view...

> > I don't see bust_spinlocks() dealing with any of these locks, so IMHO
> > trying to make this work in NMI context strikes me as making the
> > existing solution more unreliable on ARM systems.
> 
> bust_spinlocks() calls printk_nmi_flush() that would call printk()
> that would zap "lockbuf_lock" and "console_sem" when in Oops and NMI.
> Yes, there might be more locks blocked but we try to break at least
> the first two walls. Also zapping is allowed only once per 30 seconds,
> see zap_locks(). Why do you think that it might make things more
> unreliable, please?

Take the scenario where CPU1 is in the middle of a printk(), and is
holding its lock.

CPU0 comes along and decides to trigger a NMI backtrace.  This sends
a NMI to CPU1, which takes it in the middle of the serial console
output.

With the existing solution, the NMI output will be written to the
temporary buffer, and CPU1 has finished handling the NMI it resumes
the serial console output, eventually dropping the lock.  That then
allows CPU0 to print the contents of all buffers, and we get NMI
printk output.

With this solution, as I understand it, we'll instead end up with
CPU1's printk trying to output direct to the console, and although
we've busted a couple of locks, we won't have busted the serial
console locks, so CPU1 will deadlock - and that will stop any output
what so ever.

If this is correct, then the net result is that we go from NMI with
serial console producing output to NMI with serial console being
less reliable at producing output.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
