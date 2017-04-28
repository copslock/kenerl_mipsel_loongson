Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 15:58:40 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:56253 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991672AbdD1N6crxr4Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 15:58:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GabnOm0leRKlEqLqoCvqHkVbywyFNaGPTYZi12hzbp4=; b=kSMbUl/FfnLITF0A2tJZKL2lh
        Vus4DuFTu7bm6MFA3BNq6NLYe9pI6nJuKsLi50mGmkf1eUD4MZeV5vGd5FS3+h1bZ6r4QuByUUw6a
        jc2+8L+3bZVWa+zdL1tuj9zBQorHVehURMxmKX42j0hNV7AsIYoCkzF25zPItx8JwCmaSTp1smMCn
        htpjhWEvKe93XKT/KuDzM00zW0SEUUAp49M73XcxG83q6Ag9JKy9X+Jea38QbhevYR+iUWUZY0b2l
        2GDY1yM0VfpsHKPGBYzb86+4q+ApJiFoB/Z5IKEdUysLqS2KmK7ezDbN18bkw+TLKXW3kDo3RFP5R
        /xQLZ/SbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1d46PU-0006Px-Lm; Fri, 28 Apr 2017 13:58:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7ADF202682A3; Fri, 28 Apr 2017 15:58:10 +0200 (CEST)
Date:   Fri, 28 Apr 2017 15:58:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20170428135810.gljrbuwgrypu5jkn@hirez.programming.kicks-ass.net>
References: <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
 <20170428090226.qqoe6qbewjeo57kd@hirez.programming.kicks-ass.net>
 <20170428134423.GB3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428134423.GB3452@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57815
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

On Fri, Apr 28, 2017 at 03:44:23PM +0200, Petr Mladek wrote:
> On Fri 2017-04-28 11:02:26, Peter Zijlstra wrote:
> > On Thu, Apr 27, 2017 at 03:38:19PM +0200, Petr Mladek wrote:
> > > Also we need to look for alternatives. There is a chance
> > > to create crashdump and get the ftrace messages from it.
> > > Also this might be scenario when we might need to suggest
> > > the early_printk() patchset from Peter Zijlstra.
> > 
> > I'd be happy to repost those. I still carry them in my tree.
> 
> You do not need to if they are still the same as
> https://lkml.kernel.org/r/20161018170830.405990950@infradead.org

More or less, I think I fixed an intermediate compile fail reported by
you and the 0-day thing and I wrote a few comments in the last patch.

They live here fwiw:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/tmp

> I rather do not promise anything but I would like to look at them
> within next few weeks (after the merge window).

Sure, I'll post them again during/after the merge window.
