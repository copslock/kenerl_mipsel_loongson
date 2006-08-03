Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 22:43:57 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:6296 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S8133930AbWHCVns (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Aug 2006 22:43:48 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 99938E404D;
	Thu,  3 Aug 2006 14:59:30 -0700 (PDT)
Subject: Re: pointers for writing BSP
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Mayuresh Chitale <mchitale@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <d096a3ee0608020230l13158c4dg5623b6c83eb35625@mail.gmail.com>
References: <1154473955.7785.9.camel@sandbar.kenati.com>
	 <d096a3ee0608020230l13158c4dg5623b6c83eb35625@mail.gmail.com>
Content-Type: text/plain
Date:	Thu, 03 Aug 2006 14:49:19 -0700
Message-Id: <1154641759.7594.6.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

I have a query about the following:

u32 pin_func;

        pin_func = 0;
        /* not valid for 1550 */
#ifdef CONFIG_AU1X00_USB_DEVICE
        // 2nd USB port is USB device
        pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x8000); 
        au_writel(pin_func, SYS_PINFUNC);


Now SYS_PINFUNC is defined as 0xB190002C
the (u32)(~0x8000) means 0xB190002C & 0xFFFF1FFF right?

Then the original value of SYS_PINFUNC remains unchanged..so what is the
purpose of the above code?


Thanks
Ashlesha.

On Wed, 2006-08-02 at 15:00 +0530, Mayuresh Chitale wrote:
> Hi Ashlesha,
> 
> The kernel starts from head.S. This present for each architechture.
> E.g for mips there is arch/mips/kernel/head.S. There it does some very
> low level init and jumps to start_kernel which is defined in
> init/main.c. You can browse the code in start_kernel to understand how
> system init is done.
> 
> You could compare your new bsp with some existing bsp in the source
> and see the code flow for that starting with start_kernel. Tracing the
> same path for your bsp should work.
> 
> Thanks,
> Mayuresh.
> 
> On 8/2/06, Ashlesha Shintre <ashlesha@kenati.com> wrote:
> > Hi Mayuresh,
> >
> > I was wondering if you could point me in the right direction with
> > respect to writing the board support software for the Ampro EncoreM3
> > board.
> >
> > So far, I looked at the websites you suggested and got as far as
> > configuring the kernel.  I am still stuck with respect to the order of
> > system initialisation in the 2.6 kernel.  By my understanding in the 2.4
> > kernel, following is the order:
> >
> > 1) Setting up interrupt tables
> > 2) Activating the Timer Interrupt
> > 3) Initialising the console and memory data structures etc.
> >
> > I have available the 2.4 bsp code available, but do not understand,
> > where the kernel starts-- is it the init.c file from the encm3 directory
> > or is it the generic linux/init/init.c file?  Neither have the main()
> > function defined in them!
> >
> > I really appreciate your help,
> > Thank you,
> >
> > Ashlesha.
> >
> >
