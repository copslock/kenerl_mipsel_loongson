Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 13:12:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42453 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027194AbXJZMMc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Oct 2007 13:12:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9QCCSlk002418;
	Fri, 26 Oct 2007 13:12:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9QCCRG0002372;
	Fri, 26 Oct 2007 13:12:27 +0100
Date:	Fri, 26 Oct 2007 13:12:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc1: au1xxx and clocksource
Message-ID: <20071026121226.GB32421@linux-mips.org>
References: <20071024183135.GA23096@roarinelk.homelinux.net> <20071025175914.GB27616@linux-mips.org> <20071026061835.GA1267@roarinelk.homelinux.net> <20071026112455.GA2792@roarinelk.homelinux.net> <4721D5E6.4010107@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4721D5E6.4010107@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 26, 2007 at 03:56:22PM +0400, Sergei Shtylyov wrote:

> >Setting mips_hpt_frequency to processor speed gives me a booting kernel.
> 
>    I thought it's done in arch/mips/au1000/common/time.c...

The function plat_timer_setup which does it is not getting invoked anymore.
So there will be a similar issue in the following:

arch/mips/basler/excite/excite_setup.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/dec/time.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/gt64120/wrppmc/time.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/kernel/smtc.c:         * plat_timer_setup has already have been invoked by init/main
arch/mips/kernel/time.c: * 3) plat_timer_setup() -
arch/mips/kernel/time.c:void __init __weak plat_timer_setup(struct irqaction *irq)
arch/mips/lasat/setup.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/mips-boards/generic/time.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/mipssim/sim_time.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/philips/pnx8550/common/time.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/pmc-sierra/msp71xx/msp_time.c:void __init plat_timer_setup(struct irqaction *irq)
arch/mips/sni/time.c:void __init plat_timer_setup(struct irqaction *irq)
include/asm-mips/time.h:extern void plat_timer_setup(struct irqaction *irq);

I'll turn the weak definition of plat_timer_setup() in time.c into a strong
one to force people to look at it when there is a linker error.

  Ralf
