Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 22:31:12 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:40653 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010101AbaJ2VbL3gKda (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 22:31:11 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Xjapf-0004kN-BC; Wed, 29 Oct 2014 22:31:07 +0100
Date:   Wed, 29 Oct 2014 22:31:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/11] irqchip: Allow irq_reg_{readl,writel} to use
 __raw_{readl_writel}
In-Reply-To: <22478002.kqKBdeLAKz@wuerfel>
Message-ID: <alpine.DEB.2.11.1410292226050.5308@nanos>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <5338153.4SY4TFtus9@wuerfel> <CAJiQ=7C7SzT2ngQzP=dQqdQz=+ShJ_Jf0z4kwFgvUKg1G3vrAw@mail.gmail.com> <22478002.kqKBdeLAKz@wuerfel>
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
X-archive-position: 43726
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

On Wed, 29 Oct 2014, Arnd Bergmann wrote:
> On Wednesday 29 October 2014 13:09:47 Kevin Cernekee wrote:
> > generic-chip.c already has a fair amount of indirection, with pointers
> > to saved masks, user-specified register offsets, and such.  Is there a
> > concern that introducing, say, a pair of readl/writel function
> > pointers, would cause an unacceptable performance drop?
> 
> I don't know. Thomas' reply suggests that it isn't. Doing byteswap
> in software at a register access is usually free in terms of CPU
> cycles, but an indirect function call can be noticeable if we do
> that a lot.

I did not say that it is free. I merily said that I prefer to have
this solved at the core level rather than at the driver level. So you
have several options to do so:

1) Indirections

2) Different functions for the different access modes

3) Alternatives

#1 Is the simplest solution, but imposes the overhead of an indirect
   function call for something trivial

#2 The most efficient and flexible way if you have to provide
   different access modes for different drivers. But it comes with the
   price of increasing the text foot print.

#3 Smart and efficient, but requires that on a particular system all
   drivers use the same access mode.

Thanks,

	tglx



  
