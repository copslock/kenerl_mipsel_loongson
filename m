Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 15:12:04 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993901AbdDTNL6BmiVG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Apr 2017 15:11:58 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1F0CAB45;
        Thu, 20 Apr 2017 13:11:56 +0000 (UTC)
Date:   Thu, 20 Apr 2017 15:11:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in
 NMI
Message-ID: <20170420131154.GL3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420033112.GB542@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57744
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

On Thu 2017-04-20 12:31:12, Sergey Senozhatsky wrote:
> Hello Steven,
> 
> On (04/19/17 13:13), Steven Rostedt wrote:
> > > printk() takes some locks and could not be used a safe way in NMI context.
> > 
> > I just found a problem with this solution. It kills ftrace dumps from
> > NMI context :-(
> > 
> > [ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-_raw_spin_lock
> > [ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime: comm=cc1 pid=67423 runtime=96858 [ns] vruntime=11924198270 [ns]
> > [ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: ffffffff81c5c940 read rcu_read_lock
> > [ 1295.168497]
> > [ 1295.168498] Lost 4890096 message(s)!
> > [ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
> > [ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x27/0x40)
> > [ 1296.811553] Call Trace:
> > [ 1296.811553]  <NMI>
> > 
> > I was hoping to see a cause of a hard lockup by enabling
> > ftrace_dump_on_oops. But as NMIs now have a very small buffer that
> > gets flushed, we need to find a new way to print out the full ftrace
> > buffer over serial.
> > 
> > Thoughts?
> 
> hmmm... a really tough one.
> 
> well, someone has to say this:
>  the simplest thing is to have a bigger PRINTK_SAFE_LOG_BUF_SHIFT value :)
> 
> 
> just thinking (well, sort of) out loud. the problem is that we can't tell if
> we already hold any printk related locks ("printk related locks" is not even
> well defined term). so printk from NMI can deadlock or it can be OK, we
> never know. but looking and vprintk_emit() and console_unlock() it seems that
> we have some sort of a hint now, which is this_cpu_read(printk_context) - if
> we are not in printk_safe context then we can say that _probably_ (and that's
> a Russian roulette) doing "normal" printk() will work. that is a *very-very*
> risky (and admittedly dumb) thing to assume, so we will move in a slightly
> different direction. checking this_cpu_read(printk_context) only assures us
> that we don't hold `logbuf_lock' on this CPU. and that is sort of something,
> at least we can be sure that doing printk_deferred() from this CPU is safe.
> printk_deferred() means that your NMI messages will end up in the logbuf,
> which is a) bigger in size than per-CPU buffer and b) some other CPU can
> immediately print those messages (hopefully).
> 
> we also switch to printk_safe mode for call_console_drivers() in
> console_unlock(). but we can't make any solid assumptions there - serial
> console lock can already be acquired, we don't have any markers for that.
> it may be reasonable to assume that if we are not in printk_safe mode on
> this CPU then serial console is not locked from this CPU, but there is
> nothing that can assure us.

Good analyze. I would summarize it that we need to be careful of:

  + logbug_lock
  + PRINTK_SAFE_CONTEXT
  + locks used by console drivers

The first two things are easy to check. Except that a check for logbuf_lock
might produce false negatives. The last check is very hard.

> so at the moment what I can think of is something like
> 
>   -- check this_cpu_read(printk_context) in NMI prink
> 
> 	-- if we are NOT in printk_safe on this CPU, then do printk_deferred()
> 	   and bypass `nmi_print_seq' buffer

I would add also a check for logbuf_lock.

> 	-- if we are in printk_safe
> 	  -- well... bad luck... have a bigger buffer.

Yup, we do the best effort while still trying to stay on the safe
side.

I have cooked up a patch based on this. It uses printk_deferred()
in NMI when it is safe. Note that console_flush_on_panic() will
try to get them on the console when a kdump is not generated.
I believe that it will help Steven.
