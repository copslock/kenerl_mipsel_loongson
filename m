Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 22:41:12 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:49292 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010101AbaJ2VlKfa4Tz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 22:41:10 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue002) with ESMTP (Nemesis)
        id 0MhJ21-1XNEkg2iyf-00MKJb; Wed, 29 Oct 2014 22:41:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/11] irqchip: Allow irq_reg_{readl,writel} to use __raw_{readl_writel}
Date:   Wed, 29 Oct 2014 22:41:03 +0100
Message-ID: <3403771.J3X9ZBogqZ@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <alpine.DEB.2.11.1410292226050.5308@nanos>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <22478002.kqKBdeLAKz@wuerfel> <alpine.DEB.2.11.1410292226050.5308@nanos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:SpLLopbIA7O5G6N7YRcXn53onCCj9InN1tRKKNeHoNN
 NDSiMtDTr6drcI01qyVTDkxsQiIRCk0NQpAGTyJg29xzaom/Tw
 ZSENhZdvzKopceEWxnbbM0xqVC2/Li2f62mFNXQQrmktwdZm5f
 KnzQPRHy2WZLaAmG2ekO6fS7vZoFiKop6Xc7OuL8l0kBNkcolb
 oqsdRyblA14UoV8mbe/sn9j0XZjAQQDq+AnLHwTW8k7wzOBgqe
 bXboBMp9is42a+XBujp4sZtxmcgdt4GsYRdz71oz7IJH4JXMH2
 MaIIKisDOWjyEZ2bM3lmsHGSi7YeFZRk+bxUMRE0hXcIBO5IZv
 7UZhsZOcT3z7xMVW+NLk=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43728
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

On Wednesday 29 October 2014 22:31:06 Thomas Gleixner wrote:
> On Wed, 29 Oct 2014, Arnd Bergmann wrote:
> > On Wednesday 29 October 2014 13:09:47 Kevin Cernekee wrote:
> > > generic-chip.c already has a fair amount of indirection, with pointers
> > > to saved masks, user-specified register offsets, and such.  Is there a
> > > concern that introducing, say, a pair of readl/writel function
> > > pointers, would cause an unacceptable performance drop?
> > 
> > I don't know. Thomas' reply suggests that it isn't. Doing byteswap
> > in software at a register access is usually free in terms of CPU
> > cycles, but an indirect function call can be noticeable if we do
> > that a lot.
> 
> I did not say that it is free. I merily said that I prefer to have
> this solved at the core level rather than at the driver level.

Yes, I understood that.

> So you have several options to do so:
> 
> 1) Indirections
> 
> 2) Different functions for the different access modes
> 
> 3) Alternatives
> 
> #1 Is the simplest solution, but imposes the overhead of an indirect
>    function call for something trivial
> 
> #2 The most efficient and flexible way if you have to provide
>    different access modes for different drivers. But it comes with the
>    price of increasing the text foot print.
> 
> #3 Smart and efficient, but requires that on a particular system all
>    drivers use the same access mode.

Right. The option that I was explaining earlier basically combines #1 and
#3: For all kernels on which we know the endianess of all generic-irqchip
users at compile time, we hardcode that, and we use indirections of
some sort for the cases where we build a kernel that needs both.

	Arnd
