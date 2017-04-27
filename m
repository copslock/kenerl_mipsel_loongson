Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2017 17:28:21 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992121AbdD0P2LjEY9i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Apr 2017 17:28:11 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 722A6AB43;
        Thu, 27 Apr 2017 15:28:10 +0000 (UTC)
Date:   Thu, 27 Apr 2017 17:28:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20170427152807.GY3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
 <20170427103118.56351d30@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427103118.56351d30@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57800
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

On Thu 2017-04-27 10:31:18, Steven Rostedt wrote:
> On Thu, 27 Apr 2017 15:38:19 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > > by the way,
> > > does this `nmi_print_seq' bypass even fix anything for Steven?  
> > 
> > I think that this is the most important question.
> > 
> > Steven, does the patch from
> > https://lkml.kernel.org/r/20170420131154.GL3452@pathway.suse.cz
> > help you to see the debug messages, please?
> 
> You'll have to wait for a bit. The box that I was debugging takes 45
> minutes to reboot. And I don't have much more time to play on it before
> I have to give it back. I already found the bug I was looking for and
> I'm trying not to crash it again (due to the huge bring up time).

I see.

> When I get a chance, I'll see if I can insert a trigger to crash the
> kernel from NMI on another box and see if this patch helps.

I actually tested it here using this hack:

diff --cc lib/nmi_backtrace.c
index d531f85c0c9b,0bc0a3535a8a..000000000000
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@@ -89,8 -90,7 +90,9 @@@ bool nmi_cpu_backtrace(struct pt_regs *
        int cpu = smp_processor_id();
  
        if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
 +              if (in_nmi())
 +                      panic("Simulating panic in NMI\n");
+               arch_spin_lock(&lock);
                if (regs && cpu_in_idle(instruction_pointer(regs))) {
                        pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
                                cpu, instruction_pointer(regs));

and triggered by:

   echo  l > /proc/sysrq-trigger

The patch really helped to see much more (all) messages from the ftrace
buffers in NMI mode.

But the test is a bit artifical. The patch might not help when there
is a big printk() activity on the system when the panic() is
triggered. We might wrongly use the small per-CPU buffer when
the logbuf_lock is tested and taken on another CPU at the same time.
It means that it will not always help.

I personally think that the patch might be good enough. I am not sure
if a perfect (more comlpex) solution is worth it.

Best Regards,
Petr
