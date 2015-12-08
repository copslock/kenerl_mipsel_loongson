Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 15:49:10 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:33775 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007050AbbLHOtIts0IU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Dec 2015 15:49:08 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 73919AAB6;
        Tue,  8 Dec 2015 14:49:07 +0000 (UTC)
Date:   Tue, 8 Dec 2015 15:49:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI
 context
Message-ID: <20151208144906.GL20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
 <20151204171255.GZ8644@n2100.arm.linux.org.uk>
 <063D6719AE5E284EB5DD2968C1650D6D1CBE68C7@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBE68C7@AcuExch.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50446
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

On Mon 2015-12-07 15:48:33, David Laight wrote:
> From: Russell King - ARM Linux
> > Sent: 04 December 2015 17:13
> ...
> > I have a slightly different view...
> > 
> > > > I don't see bust_spinlocks() dealing with any of these locks, so IMHO
> > > > trying to make this work in NMI context strikes me as making the
> > > > existing solution more unreliable on ARM systems.
> > >
> > > bust_spinlocks() calls printk_nmi_flush() that would call printk()
> > > that would zap "lockbuf_lock" and "console_sem" when in Oops and NMI.
> > > Yes, there might be more locks blocked but we try to break at least
> > > the first two walls. Also zapping is allowed only once per 30 seconds,
> > > see zap_locks(). Why do you think that it might make things more
> > > unreliable, please?
> > 
> > Take the scenario where CPU1 is in the middle of a printk(), and is
> > holding its lock.
> > 
> > CPU0 comes along and decides to trigger a NMI backtrace.  This sends
> > a NMI to CPU1, which takes it in the middle of the serial console
> > output.
> > 
> > With the existing solution, the NMI output will be written to the
> > temporary buffer, and CPU1 has finished handling the NMI it resumes
> > the serial console output, eventually dropping the lock.  That then
> > allows CPU0 to print the contents of all buffers, and we get NMI
> > printk output.
> 
> Is the traceback from inside printk() or serial console code
> likely to be useful?

It is useful if a problem is caused by the printk or serial console
code. For example, a slow serial console might cause a soft lockup
if there are too many messages to print.


> If not then why not get the stacktrace generated when the relevant
> lock is released? That should save any faffing with a special
> buffer.

Another question is how to detect that NMI interrupted printk() code.
We would either need to analyze backtrace. Or we would need to
know which CPU took the printk() or console locks. This check
should be race-safe vs. the NMI context.


Best Regards,
Petr
