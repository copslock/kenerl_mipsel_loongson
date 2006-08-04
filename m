Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2006 06:59:23 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:34754 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133443AbWHDF7O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Aug 2006 06:59:14 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id 750B8333;
	Fri,  4 Aug 2006 07:59:04 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 8DAB41BC081;
	Fri,  4 Aug 2006 07:59:05 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id ECF981A18A9;
	Fri,  4 Aug 2006 07:59:05 +0200 (CEST)
Date:	Fri, 4 Aug 2006 07:59:06 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	Mayuresh Chitale <mchitale@gmail.com>, linux-mips@linux-mips.org
Subject: Re: pointers for writing BSP
Message-ID: <20060804055906.GV31105@domen.ultra.si>
References: <1154473955.7785.9.camel@sandbar.kenati.com> <d096a3ee0608020230l13158c4dg5623b6c83eb35625@mail.gmail.com> <1154641759.7594.6.camel@sandbar.kenati.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154641759.7594.6.camel@sandbar.kenati.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 03/08/06 14:49 -0700, Ashlesha Shintre wrote:
> I have a query about the following:
> 
> u32 pin_func;
> 
>         pin_func = 0;
>         /* not valid for 1550 */
> #ifdef CONFIG_AU1X00_USB_DEVICE
>         // 2nd USB port is USB device
>         pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x8000); 
>         au_writel(pin_func, SYS_PINFUNC);
> 
> 
> Now SYS_PINFUNC is defined as 0xB190002C
> the (u32)(~0x8000) means 0xB190002C & 0xFFFF1FFF right?

Not really.
It means value-from-address-0xB190002C & 0xFFFF7FFF
And the result is then wrote back to that address.

(bit 15 of SYS_PINFUNC register is cleared)


	Domen
> 
> Then the original value of SYS_PINFUNC remains unchanged..so what is the
> purpose of the above code?
> 
> 
> Thanks
> Ashlesha.
> 
> On Wed, 2006-08-02 at 15:00 +0530, Mayuresh Chitale wrote:
> > Hi Ashlesha,
> > 
> > The kernel starts from head.S. This present for each architechture.
> > E.g for mips there is arch/mips/kernel/head.S. There it does some very
> > low level init and jumps to start_kernel which is defined in
> > init/main.c. You can browse the code in start_kernel to understand how
> > system init is done.
> > 
> > You could compare your new bsp with some existing bsp in the source
> > and see the code flow for that starting with start_kernel. Tracing the
> > same path for your bsp should work.
> > 
> > Thanks,
> > Mayuresh.
> > 
> > On 8/2/06, Ashlesha Shintre <ashlesha@kenati.com> wrote:
> > > Hi Mayuresh,
> > >
> > > I was wondering if you could point me in the right direction with
> > > respect to writing the board support software for the Ampro EncoreM3
> > > board.
> > >
> > > So far, I looked at the websites you suggested and got as far as
> > > configuring the kernel.  I am still stuck with respect to the order of
> > > system initialisation in the 2.6 kernel.  By my understanding in the 2.4
> > > kernel, following is the order:
> > >
> > > 1) Setting up interrupt tables
> > > 2) Activating the Timer Interrupt
> > > 3) Initialising the console and memory data structures etc.
> > >
> > > I have available the 2.4 bsp code available, but do not understand,
> > > where the kernel starts-- is it the init.c file from the encm3 directory
> > > or is it the generic linux/init/init.c file?  Neither have the main()
> > > function defined in them!
> > >
> > > I really appreciate your help,
> > > Thank you,
> > >
> > > Ashlesha.
> > >
> > >
> 
