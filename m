Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 14:57:40 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:53612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991672AbdD1M531Z0hb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Apr 2017 14:57:29 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4A08ACB7;
        Fri, 28 Apr 2017 12:57:28 +0000 (UTC)
Date:   Fri, 28 Apr 2017 14:57:25 +0200
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
Message-ID: <20170428125725.GA3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170427121458.2be577cc@gandalf.local.home>
 <20170428013532.GB383@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428013532.GB383@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57812
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

On Fri 2017-04-28 10:35:32, Sergey Senozhatsky wrote:
> On (04/27/17 12:14), Steven Rostedt wrote:
> [..]
> > I tried this patch. It's better because I get the end of the trace, but
> > I do lose the beginning of it:
> > 
> > ** 196358 printk messages dropped ** [  102.321182]     perf-5981    0.... 12983650us : d_path <-seq_path
>
> many thanks!
> 
> so we now drop messages from logbuf, not from per-CPU buffers. that
> "queue printk_deferred irq_work on every online CPU when we bypass per-CPU
> buffers from NMI" idea *probably* might help here - we need someone to emit
> messages from the logbuf while we printk from NMI. there is still a
> possibility that we can drop messages, though, since log_store() from NMI
> CPU can be much-much faster than call_console_drivers() on other CPU.

ftrace log is dumped via trace_panic_notifier. It is done after
smp_send_stop(). It means that only a single CPU is available and
it is NMI context at the moment.

One possibility might be to put printk into a special mode and
drop the last messages instead of the first ones. But this would
need to be configurable.

Of course, if the problem is reproducible, the easiest solution
is to use bigger main log buffer, for example boot with
log_buf_len=32M.

Best Regards,
Petr
