Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 15:44:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36040 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009125AbaLROoZ3XM2Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Dec 2014 15:44:25 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBIEiOxh002150;
        Thu, 18 Dec 2014 15:44:24 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBIEiO76002149;
        Thu, 18 Dec 2014 15:44:24 +0100
Date:   Thu, 18 Dec 2014 15:44:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: fixup #include's (sparse)
Message-ID: <20141218144424.GA1943@linux-mips.org>
References: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
 <20141218130203.GC25711@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141218130203.GC25711@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44734
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

On Thu, Dec 18, 2014 at 02:02:03PM +0100, Ralf Baechle wrote:

> > 
> >   arch/mips/jz4740/irq.c:63:6: warning: symbol 'jz4740_irq_suspend' was not declared. Should it be static?
> >   arch/mips/jz4740/irq.c:69:6: warning: symbol 'jz4740_irq_resume' was not declared. Should it be static?
> > 
> > Also, I've seen some elusive build errors on my automated build test
> > where JZ4740_IRQ_BASE and NR_IRQS are missing, but I can't reproduce
> > them manually for some reason. Anyway, mach-jz4740/irq.h should help us
> > avoid relying on some implicit include.
> 
> Patch is looking good.
> 
> There is a known issue building jz in a separate build directory; building
> in the source directory itself will succeed.  Could that be why you can't
> seem to reproduce the build issue?

With your patch applied I still can reproduce that build issue issue:

[...]
  CC      arch/mips/jz4740/irq.o
In file included from /home/ralf/src/linux/linux-mips/include/linux/irq.h:392:0,
                 from /home/ralf/src/linux/linux-mips/include/asm-generic/hardirq.h:12,
                 from /home/ralf/src/linux/linux-mips/arch/mips/include/asm/hardirq.h:16,
                 from /home/ralf/src/linux/linux-mips/include/linux/hardirq.h:8,
                 from /home/ralf/src/linux/linux-mips/include/linux/interrupt.h:12,
                 from /home/ralf/src/linux/linux-mips/arch/mips/jz4740/irq.c:19:
/home/ralf/src/linux/linux-mips/include/linux/irqdesc.h:92:33: error: ‘NR_IRQS’ undeclared here (not in a function)
 extern struct irq_desc irq_desc[NR_IRQS];
                                 ^
make[4]: *** [arch/mips/jz4740/irq.o] Error 1
make[3]: *** [arch/mips/jz4740] Error 2
make[2]: *** [arch/mips] Error 2
make[1]: *** [sub-make] Error 2
make: *** [__sub-make] Error 2
make: Leaving directory `/home/ralf/src/linux/obj/qi_lb60-build'

I haven't looked into depth at this but the issue appears to be that the
search order for include files is different between building in the source
directory and the object directory and that there are multiple include
files with the same name, that is irq.h. are involved.

So changing the name of the header file should fix this issue but really
this also is a kbuild bug.

  Ralf
