Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 16:27:14 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:53901 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007599AbbLDP1NOQ057 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 16:27:13 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B521AB12;
        Fri,  4 Dec 2015 15:27:11 +0000 (UTC)
Date:   Fri, 4 Dec 2015 16:27:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
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
Message-ID: <20151204152709.GA20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151201234437.GA8644@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

On Tue 2015-12-01 23:44:37, Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2015 at 12:09:30PM +0100, Petr Mladek wrote:
> > What we can do, though, is to zap all printk locks. We already do this
> > when a printk recursion is detected. This should be safe because
> > the system is crashing and there shouldn't be any printk caller
> > that would cause the deadlock.
> 
> What about serial consoles which may call out to subsystems like the
> clk subsystem to enable a clock, which would want to take their own
> spinlocks in addition to the serial console driver?

Yes, there might be more locks used by the serial console but I do
not know how to handle them all easily. IMHO, this patch is just better
than nothing.

> I don't see bust_spinlocks() dealing with any of these locks, so IMHO
> trying to make this work in NMI context strikes me as making the
> existing solution more unreliable on ARM systems.

bust_spinlocks() calls printk_nmi_flush() that would call printk()
that would zap "lockbuf_lock" and "console_sem" when in Oops and NMI.
Yes, there might be more locks blocked but we try to break at least
the first two walls. Also zapping is allowed only once per 30 seconds,
see zap_locks(). Why do you think that it might make things more
unreliable, please?


Thanks for looking,
Petr
