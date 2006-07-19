Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 17:59:19 +0100 (BST)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:22353 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133477AbWGSQ7J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Jul 2006 17:59:09 +0100
Received: (qmail 92580 invoked from network); 19 Jul 2006 16:59:02 -0000
Received: from unknown (HELO ?192.168.15.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 19 Jul 2006 16:59:01 -0000
Subject: Re: pseudo 32 bit physical addresses and the real 36 bit world
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060719155804.GB5162@dusktilldawn.nl>
References: <20060719155804.GB5162@dusktilldawn.nl>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Wed, 19 Jul 2006 09:58:49 -0700
Message-Id: <1153328330.15277.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Wed, 2006-07-19 at 17:58 +0200, Freddy Spierenburg wrote:
> Hi,
> 
> The AU1100 processor uses internally a 36-bit address bus. The
> kernel (32 bits) is only able to work with 32-bit addresses.
> Well, there must exist some sort of scheme for the kernel to work
> with these 36-bit addresses, but I don't quiet get it yet. Is
> anybody willing to give me some insight?
> 
> I'm looking at the pcmcia implementation at this moment and I
> don't get it. If I look at drivers/pcmcia/au1000_generic.h I see
> AU1X_SOCK0_IO defines as 0xF00000000 (note the 36 bit length).
> This one is used in drivers/pcmcia/au1000_generic.c
> au1x00_pcmcia_socket_probe() where it get cast to phys_t. phys_t
> is a typedef from include/asm-mips/types.h as an unsigned long.
> Of course the compiler warns us during compilation of
> drivers/pcmcia/au1000_generic.c:
> 
> drivers/pcmcia/au1000_generic.c:403: warning: integer constant is too large for "long" type
> drivers/pcmcia/au1000_generic.c:406: warning: integer constant is too large for "long" type
> drivers/pcmcia/au1000_generic.c:414: warning: integer constant is too large for "long" type
> 
> And this is where I'm sort of lost. How can this scheme work? 

PCMCIA is one of the peripherals on the Au1x processors that is accessed
on a 36bit physical address. The actual phys address is 36 bit, however,
the generic Linux pcmcia layer doesn't support 36 bit phys addresses. In
order to avoid having to modify that common code, the Au1x 36 bit
support uses, in this case, 32 bit pseudo phys address. If you take a
look at ioremap(), you'll see a call to a fixup function. This function
detects the pseudo phys address and returns the real 36 bit phys address
that then gets ioremapped.

> I
> must be missing something, but I don't understand it. I expect
> from reading the au1100 databook and 'See MIPS Run (chapter 6)
> that the TLB is involved, but I'm not yet able to link it
> altogether.
> 
> I also expect more is happening with the
> AU1X_SOCK0_PSEUDO_PHYS_ATTR and AU1X_SOCK0_PSEUDO_PHYS_MEM, but
> not that I can find any clue how this appears to work.
> 
> To end this email into a happy end I shall also explain what I
> really want to do. We've built our own computer using the AU1100
> processor. We've connected two SC16C652 dual UART's, one to RCS2
> and one to RCS3. Now I want to map those UARTS at AE000000 and
> AE040000. I've configured the mem_stcfg[23], mem_sttime[23] and
> mem_staddr[23] registers in yamon:
> 
>   #define MEM_STCFG[23]   0x00000001
>   #define MEM_STTIME[23]  0x03FFC7C7
>   #define MEM_STADDR2     0x1AE03FFF
>   #define MEM_STADDR3     0x1AE07FFF
> 
> But after that I'm sort of lost in the dark. What should I do
> inside the kernel so that when I refer to AE000000 in my driver
> the processor triggers chip select 2 (RCS2)?

Assuming you've setup mem_xxxx correctly, and AE000000 does not overlap
with some other phys address already used, then you should be ioremap
that address and use it directly.

Pete
