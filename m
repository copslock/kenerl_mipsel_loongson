Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 16:52:04 +0100 (BST)
Received: from smtp003.bizmail.yahoo.com ([IPv6:::ffff:216.136.130.195]:59034
	"HELO smtp003.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226008AbVEFPvr>; Fri, 6 May 2005 16:51:47 +0100
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp003.bizmail.yahoo.com with SMTP; 6 May 2005 15:51:44 -0000
Subject: Re: USB hangs on AU1100
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <20050506142719.GA13148@enneenne.com>
References: <20050505155435.GA28227@enneenne.com>
	 <1115311361.1614.6.camel@localhost.localdomain>
	 <20050506142719.GA13148@enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 06 May 2005 08:51:45 -0700
Message-Id: <1115394705.5785.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-05-06 at 16:27 +0200, Rodolfo Giometti wrote:
> On Thu, May 05, 2005 at 09:42:41AM -0700, Pete Popov wrote:
> > It sounds like this is a custom Au1100 based board? What boot code are
> > you running?  I'm guessing the SOC isn't setup correctly or you have a
> > HW problem.
> 
> Yes, you was right, I missing to setup USB clock... I just added this
> code to the board init function (board_setup() function) and now USB
> works:
> 
>     #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_AU1X00_USB_DEVICE)
> 	    /* zero and disable FREQ2 */
> 	    sys_freqctrl = au_readl(SYS_FREQCTRL0);
> 	    sys_freqctrl &= ~0xFFF00000;
> 	    au_writel(sys_freqctrl, SYS_FREQCTRL0);
>     
> 	    /* zero and disable USBH/USBD/IrDA clock */
> 	    sys_clksrc = au_readl(SYS_CLKSRC);
> 	    sys_clksrc &= ~0x0000001F;
> 	    au_writel(sys_clksrc, SYS_CLKSRC);
>     
> 	    sys_freqctrl = au_readl(SYS_FREQCTRL0);
> 	    sys_freqctrl &= ~0xFFF00000;
>     
> 	    sys_clksrc = au_readl(SYS_CLKSRC);
> 	    sys_clksrc &= ~0x0000001F;
>     
> 	    /* FREQ2 = aux/2 = 48 MHz */
> 	    sys_freqctrl |= ((0<<22) | (1<<21) | (1<<20));
> 	    au_writel(sys_freqctrl, SYS_FREQCTRL0);
>     
> 	    /* Route 48MHz FREQ2 into USBH/USBD/IrDA */
> 	    sys_clksrc |= ((4<<2) | (0<<1) | 0 );
> 	    au_writel(sys_clksrc, SYS_CLKSRC);
>     
> 	    /* setup the static bus controller */
> 	    au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
> 	    au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
> 	    au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
>     
> 	    /* Get USB Functionality pin state (device vs host drive pins) */
> 	    pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x8000);
>     #ifndef CONFIG_AU1X00_USB_DEVICE
> 	    /* 2nd USB port is USB host */
> 	    pin_func |= 0x8000;
>     #endif
> 	    au_writel(pin_func, SYS_PINFUNC);
>     #endif /* defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE) */
> 
> But don't you think is better to put this code into USB driver (file
> ohci-au1xxx.c) during probing stage? In this manner each platforms may
> don't worry about clock initialization...

Seems too board specific since the clocks can be routed differently on
each board. 

Pete
