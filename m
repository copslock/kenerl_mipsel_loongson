Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2004 10:04:17 +0000 (GMT)
Received: from web25107.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.55]:28505
	"HELO web25107.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225212AbULNKEN>; Tue, 14 Dec 2004 10:04:13 +0000
Received: (qmail 92684 invoked by uid 60001); 14 Dec 2004 10:03:56 -0000
Message-ID: <20041214100356.92682.qmail@web25107.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25107.mail.ukl.yahoo.com via HTTP; Tue, 14 Dec 2004 11:03:56 CET
Date: Tue, 14 Dec 2004 11:03:56 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Kernel located in KSEG2 or KSEG3.
To: sjhill@realitydiluted.com
Cc: linux-mips@linux-mips.org
In-Reply-To: <E1CdvUh-0002B1-MR@real.realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

 --- sjhill@realitydiluted.com a écrit : 
> > Here is my board's mapping:
> > 
> > Physical Memory Map:
> > 
> > start        size       type
> > -----------------------------
> > 0x20000000 - 8MB    - SDRAM
> > 0x30000000 - 16MB   - FLASH
> > 0x40000000 - 16MB   - FLASH
> > 0x50000000 - 2MB    - SRAM
> > 
> are you sure there is no device mapped in the
> physical
> address range of 0x1fc00000-0x1fffffff? I highly
> doubt
> your board would boot otherwise, since a MIPS
> processor
> coming out of reset jumps to physical address
> 0x1fc00000.
  
only a small piece of ROM...

here is my internal memory mapping:

start        size      type
-----------------------------
0x1fc00000 - 128Ko    - ROM
0x01000000 - 128Ko   - FLASH

At boot time ROM code do some init and then jump
into the internal flash mem.

I think there's no possibilities to run linux except
in KSEG2 and KSEG3...Do you think it's possible ?

By the way why Linux memory management need to care
about physical addresses ?

Francis.




>  


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/ 
 
Avec Yahoo! faites un don et soutenez le Téléthon en cliquant sur http://www.telethon.fr/030-Don/10-10_Don.asp
