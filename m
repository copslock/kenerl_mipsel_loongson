Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2017 19:22:08 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:35291 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990845AbdDSRWCWbgB7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2017 19:22:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=97NWYIPReoQCVcT3gMxrSOmh/ZlaX/CoR+caZucPlE8=; b=C0su7zdyuqRlFXg21n/psCdvv
        I7O2CMTb9HILoTYQSXCOK61cVk7F5B+g6cGVC/qnUNsSPOKjM+z6kYsWjEeLq3tJXrrhF0OQ7OhZx
        Z3oqodmBzLz4e4sNP//BSIl1McjBhzgsJEujgK7rX88AQjQ5RkCncC0fFcSSCfjqKsPX4dMWmmOcm
        hSpimYk1iL9HspIg7dywfnOSK4cfSlGtCwC8HqxnkCv7KR/zuGh5KHnofv8PgbPXcf7rVgVe7Ufln
        IiNu8pJifstuTsddsu/lXMpISCVv0cz+kadhoSau7goz392Wtk/MOJVx1bjNE/eKgFPch4NcCHH0P
        OyE2X3B3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1d0tIT-0007P3-F5; Wed, 19 Apr 2017 17:21:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 858D7203AA6C7; Wed, 19 Apr 2017 19:21:39 +0200 (CEST)
Date:   Wed, 19 Apr 2017 19:21:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20170419172139.hipylcdsarhvnsby@hirez.programming.kicks-ass.net>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419131341.76bc7634@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Wed, Apr 19, 2017 at 01:13:41PM -0400, Steven Rostedt wrote:
> On Thu, 21 Apr 2016 13:48:42 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > printk() takes some locks and could not be used a safe way in NMI context.
> 
> I just found a problem with this solution. It kills ftrace dumps from
> NMI context :-(
> 
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-_raw_spin_lock
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime: comm=cc1 pid=67423 runtime=96858 [ns] vruntime=11924198270 [ns]
> [ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: ffffffff81c5c940 read rcu_read_lock
> [ 1295.168497]
> [ 1295.168498] Lost 4890096 message(s)!
> [ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
> [ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x27/0x40)
> [ 1296.811553] Call Trace:
> [ 1296.811553]  <NMI>
> 
> I was hoping to see a cause of a hard lockup by enabling
> ftrace_dump_on_oops. But as NMIs now have a very small buffer that
> gets flushed, we need to find a new way to print out the full ftrace
> buffer over serial.
> 
> Thoughts?

early_printk ;-)
