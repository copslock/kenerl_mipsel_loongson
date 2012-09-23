Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2012 15:56:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42599 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903360Ab2IWN4o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Sep 2012 15:56:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8NDufa6021491;
        Sun, 23 Sep 2012 15:56:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8NDuZP1021490;
        Sun, 23 Sep 2012 15:56:35 +0200
Date:   Sun, 23 Sep 2012 15:56:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thierry Reding <thierry.reding@avionic-design.de>,
        Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH v2 0/3] MIPS: JZ4740: Move PWM driver to PWM framework
Message-ID: <20120923135635.GB13842@linux-mips.org>
References: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
 <20120922074144.GC2538@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20120922074144.GC2538@avionic-0098.mockup.avionic-design.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Sep 22, 2012 at 09:41:45AM +0200, Thierry Reding wrote:

> Have you had a chance to look at this? It is the last remaining PWM
> driver that isn't moved to the PWM framework yet. All the others are
> either in linux-next already and queued for 3.7 or have recently got
> Acked-by the respective maintainers (Unicore32). Patches 2 and 3 were
> already acked and tested by Lars-Peter who did the initial porting.
> Patch 1 can probably be dropped since I seem to be the only one running
> into that issue.
> 
> I really want to take this in for 3.7 so I can use the 3.7 cycle to
> transition from the legacy API to the new API and possibly even get rid
> of the legacy parts altogether. However I don't want to do this without
> the Acked-by from the MIPS maintainer.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

for 2/3 and 3/3.

I now can reproduce the build error that 1/3 is supposed to fix.  The issue
is not as first suspected an odd bug in just your compiler.  The tree
(I was testing on today's -next) is building fine when compiling in-tree
but fails out of tree:

  CC      arch/mips/jz4740/irq.o
In file included from /home/ralf/src/linux/linux-jz4740/arch/mips/include/asm/irq.h:18:0,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/irq.h:27,
                 from /home/ralf/src/linux/linux-jz4740/include/asm-generic/hardirq.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/include/asm/hardirq.h:16,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/hardirq.h:7,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/interrupt.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:19:
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.h:20:39: error: ‘struct irq_data’ declared inside parameter list [-Werror]
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.h:20:39: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.h:21:38: error: ‘struct irq_data’ declared inside parameter list [-Werror]
In file included from /home/ralf/src/linux/linux-jz4740/include/linux/irq.h:356:0,
                 from /home/ralf/src/linux/linux-jz4740/include/asm-generic/hardirq.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/include/asm/hardirq.h:16,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/hardirq.h:7,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/interrupt.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:19:
/home/ralf/src/linux/linux-jz4740/include/linux/irqdesc.h:73:33: error: ‘NR_IRQS’ undeclared here (not in a function)
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c: In function ‘jz4740_cascade’:
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:49:39: error: ‘JZ4740_IRQ_BASE’ undeclared (first use in this function)
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:49:39: note: each undeclared identifier is reported only once for each function it appears in
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c: At top level:
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:62:6: error: conflicting types for ‘jz4740_irq_suspend’
In file included from /home/ralf/src/linux/linux-jz4740/arch/mips/include/asm/irq.h:18:0,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/irq.h:27,
                 from /home/ralf/src/linux/linux-jz4740/include/asm-generic/hardirq.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/include/asm/hardirq.h:16,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/hardirq.h:7,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/interrupt.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:19:
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.h:20:13: note: previous declaration of ‘jz4740_irq_suspend’ was here
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:68:6: error: conflicting types for ‘jz4740_irq_resume’
In file included from /home/ralf/src/linux/linux-jz4740/arch/mips/include/asm/irq.h:18:0,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/irq.h:27,
                 from /home/ralf/src/linux/linux-jz4740/include/asm-generic/hardirq.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/include/asm/hardirq.h:16,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/hardirq.h:7,
                 from /home/ralf/src/linux/linux-jz4740/include/linux/interrupt.h:12,
                 from /home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:19:
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.h:21:13: note: previous declaration of ‘jz4740_irq_resume’ was here
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c: In function ‘arch_init_irq’:
/home/ralf/src/linux/linux-jz4740/arch/mips/jz4740/irq.c:91:41: error: ‘JZ4740_IRQ_BASE’ undeclared (first use in this function)

Which (while your patch is probably fine, I haven't tested) this seems to
be a build system issue, so should be preferably be fixed there.

Marek, the whole email exchange is archived at
http://www.linux-mips.org/archives/linux-mips/2012-09/threads.html

  Ralf
