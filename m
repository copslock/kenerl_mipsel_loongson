Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 15:05:57 +0000 (GMT)
Received: from web25102.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.50]:602
	"HELO web25102.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225225AbULPPFx>; Thu, 16 Dec 2004 15:05:53 +0000
Received: (qmail 83371 invoked by uid 60001); 16 Dec 2004 15:05:36 -0000
Message-ID: <20041216150536.83369.qmail@web25102.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25102.mail.ukl.yahoo.com via HTTP; Thu, 16 Dec 2004 16:05:36 CET
Date: Thu, 16 Dec 2004 16:05:36 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Kernel located in KSEG2 or KSEG3.
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20041215133851.GD27935@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

> It's not.  The 4kc processor when running with the
> BEV bit in the status
> register cleared will try to find it's exception
> vectors at address
> KSEG0, so there would have to be *some* code mapped
> there.  With BEV=1
> exception vectors would be located in the firmware
> as pointed out by
> Steve in his answer.  Firmware means something like
> flashmemory and running
> uncached, so will be prohibitivly slow.  I just
> can't believe a system to
> be that missdesigned!

Well actually I have memories that can be accessed by
KSEG0, but they are very limited:

start        size      type
----------------------------
0x00000000 - 128Ko    - RAM
0x01000000 - 128Ko    - FLASH
0x1fc00000 - 128Ko    - ROM

Therefore I could use this internal RAM to store
exception vectors.

My fears are on running kernel in KSEG2.

I'm thinking of trying this configuration:

I'm going to use 2 TLB entries to map definetively
kernel in KSEG1:
    * 1 entry to map kernel code in FLASH (16Mo), 
    * 1 entry to map kernel data in SDRAM (8Mo).

space    virtual-add    physical-add    size
----------------------------------------------
Code     0xC0000000     0x30000000      16Mo
Data     0xC1000000     0x20000000       8Mo

I will set PAGE_OFFSET to 0xA1000000, therefore all
physicall address convertion will result in SDRAM.
Hopefully, this macro is only used to make translation
between physical and virtual spaces. I grep it and it
seems to be the case.

Do you think that I can dig at this way ?

Thanks,

   Francis



	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
