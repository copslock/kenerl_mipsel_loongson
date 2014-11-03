Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2014 21:18:29 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:36916 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010884AbaKCUS11tik0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Nov 2014 21:18:27 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XlO50-0002cT-99; Mon, 03 Nov 2014 21:18:22 +0100
Date:   Mon, 3 Nov 2014 21:18:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        jason@lakedaemon.net, ralf@linux-mips.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 00/14] genirq endian fixes; bcm7120/brcmstb IRQ
 updates
In-Reply-To: <2217077.1aQXS9nJph@wuerfel>
Message-ID: <alpine.DEB.2.11.1411032117050.5308@nanos>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com> <2217077.1aQXS9nJph@wuerfel>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Mon, 3 Nov 2014, Arnd Bergmann wrote:
> On Saturday 01 November 2014 18:03:47 Kevin Cernekee wrote:
> > V2->V3:
> > 
> >  - Move updated irq_reg_{readl,writel} functions back into <linux/irq.h>
> >    so they can be called by irqchip drivers
> > 
> >  - Add gc->reg_{readl,writel} function pointers so that irqchip
> >    drivers like arch/sh/boards/mach-se/{7343,7722}/irq.c can override them
> > 
> >  - CC: linux-sh list in lieu of Paul's defunct linux-sh.org email address
> > 
> >  - Fix handling of zero L2 status in bcm7120-l2.c
> > 
> >  - Rebase on Linus' head of tree
> 
> Looks all great. I also looked at the series now and am very happy
> about how it turned out.

Does that translate to an Acked-by on the whole lot?

Jason, can you please pick that lot up with an Acked-by-me on the
changes to the existing infrastructure?

Thanks,

	tglx
