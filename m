Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 07:59:11 +0100 (BST)
Received: from mail.domino-uk.com ([193.131.116.193]:5138 "EHLO
	vMimePS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S8133392AbWGTG67 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Jul 2006 07:58:59 +0100
Received: from emea-exchange3.emea.dps.local (EMEA-EXCHANGE3) by 
    vMimePS1.domino-printing.com (Clearswift SMTPRS 5.2.3) with ESMTP id 
    <T79975ba7b4c18374c1128@vMimePS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Thu, 20 Jul 2006 08:00:09 +0100
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Thu, 20 Jul 2006 08:58:53 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: pseudo 32 bit physical addresses and the real 36 bit world
Date:	Thu, 20 Jul 2006 08:58:52 +0200
User-Agent: KMail/1.9.1
References: <20060719155804.GB5162@dusktilldawn.nl>
In-Reply-To: <20060719155804.GB5162@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607200858.52837.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 20 Jul 2006 06:58:53.0354 (UTC) 
    FILETIME=[F62CB8A0:01C6ABC9]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Wednesday 19 July 2006 17:58, Freddy Spierenburg wrote:
> The AU1100 processor uses internally a 36-bit address bus. The
> kernel (32 bits) is only able to work with 32-bit addresses.
> Well, there must exist some sort of scheme for the kernel to work
> with these 36-bit addresses, but I don't quiet get it yet. Is
> anybody willing to give me some insight?
[...]
> I expect
> from reading the au1100 databook and 'See MIPS Run (chapter 6)
> that the TLB is involved, but I'm not yet able to link it
> altogether.

As others already said, the TLB is involved. However, there are two modes in 
which you can compile the kernel, with 32 and 64 bit physical addresses. For 
the 32 bit case (which is a bit hackish) its "physical addresses" are not 
always what the real physical addresses are for the Alchemy CPU, there is a 
functions called fixup or so that converts some parts of this range when 
creating real physical addresses for the TLB.

> I'm looking at the pcmcia implementation at this moment and I
> don't get it. If I look at drivers/pcmcia/au1000_generic.h I see
> AU1X_SOCK0_IO defines as 0xF00000000 (note the 36 bit length).
> This one is used in drivers/pcmcia/au1000_generic.c
> au1x00_pcmcia_socket_probe() where it get cast to phys_t. phys_t
> is a typedef from include/asm-mips/types.h as an unsigned long.
> Of course the compiler warns us during compilation of
> drivers/pcmcia/au1000_generic.c:
>
> drivers/pcmcia/au1000_generic.c:403: warning: integer constant is too large
> for "long" type drivers/pcmcia/au1000_generic.c:406: warning: integer
> constant is too large for "long" type drivers/pcmcia/au1000_generic.c:414:
> warning: integer constant is too large for "long" type

This is possibly an error. I know there are some cases where this causes  
runtime errors when you don't have 64 bit physical addresses, but I thought 
the configuration ("make config" & Co) had been fixed to not allow this case. 
I had also proposed to add a preprocessor check that generates an error but 
that was refused, I hope this is not the case where it would have fired here.

Turn on 64 bit physical addresses when in doubt.

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

I didn't check above values, but inside the kernel you simply need to 
ioremap() or ioremap_nocache() the range you want to access, specified by the 
physical address of the device (this address is probably not AE000000!).

ioremap() gives you a pointer to a virtual address (32 bit, regardless of 
physical address size) which you can use to access the UARTs. Note that this 
doesn't map to the addresses AE000000 and AE040000 but selects a virtual 
address itself, but you shouldn't depend on that. If you do, you will need to 
take different measures.

Uli

****************************************************
Visit our website at <http://www.domino-printing.com/>
****************************************************
This Email and any files transmitted with it are intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any reading, redistribution, disclosure or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient please contact the sender immediately and delete the material from your computer.

E-mail may be susceptible to data corruption, interception, viruses and unauthorised amendment and Domino UK Limited does not accept liability for any such corruption, interception, viruses or amendment or their consequences.
****************************************************
