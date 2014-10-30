Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 10:07:05 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:57453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012245AbaJ3JG769yws (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 10:06:59 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0MAASz-1XuRrJ1Arp-00BM3L; Thu, 30 Oct 2014 10:06:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 03/15] genirq: Generic chip: Move irq_reg_{readl,writel} accessors into generic-chip.c
Date:   Thu, 30 Oct 2014 10:06:51 +0100
Message-ID: <6552163.gt4ABVyYlA@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <alpine.DEB.2.11.1410300941290.5308@nanos>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-4-git-send-email-cernekee@gmail.com> <alpine.DEB.2.11.1410300941290.5308@nanos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:gfzDjLTecc2L7VX+0HAgY1/wdJkjqZy0Zay/zOLZhK+
 Vu0K7I+ZdhuxNrAMlbkpvua7VgTqt+8KyXnmN4YcC0WhxrGQkY
 sz9oKRqbxbNMj7665jbwkg2jqNuW2HJROWVL2PLPH6iEqhjgCp
 +cAMhwWdNhHfLrVqrCHl3CzxMmO7pni5859GKPVg5K2E/ZYvqX
 m1nrzDt1Js2pcMnxprF8D/A/CrzS7he5lJh4t0wmnX5aehJ/V8
 7lniCt7Aokd8TraRH+/Ei+ibpm9y+vYynXfn2JpzJ7KXrWOJks
 HAM8SBz4kzZypukJ/a3omRvt74bfs/PmE+XlILmnTeTswEQtw0
 VWJu55w0FDlDkzeReqnw=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 30 October 2014 09:43:02 Thomas Gleixner wrote:
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index 03f48d9..8049e93 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -639,13 +639,6 @@ void arch_teardown_hwirq(unsigned int irq);
> >  void irq_init_desc(unsigned int irq);
> >  #endif
> >  
> > -#ifndef irq_reg_writel
> > -# define irq_reg_writel(val, addr)   writel(val, addr)
> > -#endif
> > -#ifndef irq_reg_readl
> > -# define irq_reg_readl(addr)         readl(addr)
> > -#endif
> > -
> 
> Brilliant patch that.
> 
> # git grep -l irq_reg_readl drivers/irqchip/
> drivers/irqchip/irq-atmel-aic.c
> drivers/irqchip/irq-atmel-aic5.c
> drivers/irqchip/irq-sunxi-nmi.c
> drivers/irqchip/irq-tb10x.c

Patch 1/15 changes these all. I think it's still broken because patch 2/15
is wrong, but it's not /that/ obviously broken.

	Arnd
