Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 08:53:29 +0000 (GMT)
Received: from web25107.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.55]:53646
	"HELO web25107.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8224774AbULUIxX>; Tue, 21 Dec 2004 08:53:23 +0000
Received: (qmail 3011 invoked by uid 60001); 21 Dec 2004 08:53:07 -0000
Message-ID: <20041221085307.3009.qmail@web25107.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25107.mail.ukl.yahoo.com via HTTP; Tue, 21 Dec 2004 09:53:07 CET
Date: Tue, 21 Dec 2004 09:53:07 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: port on exotic board.
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Hi,

Well, I'm still trying to port Linux on my "exotic"
board...
I hope you don't mind if I ask a couple of questions,
which may be stupid for you but usefull at my level. 
If you think that linux-mips mailing list is not 
intended for these kind of questions, tell me !

So here I am:

I've mapped kernel code and kernel data in different
memories in order to save precious SDRAM memory.

Code    0xC0000000    0x30000000     16Mo    FLASH
Data    0xC1000000    0x20000000      8Mo    SDRAM

When running the kernel at the very begining, I
encounter different issues:

In "tlb_init" function, cp0 WIRED register is set to
zero, therefore the call to "local_flush_tlb_all" 
flush all TLB entries which were mapping my kernel
in the 3 first entries. Why is this necessary ?  

In different part of the kernel it is assumed that the
kernel start at physical addr 0. For instance in
"init_bootmem" fonction, argument start is set to 0.
Or the way to calculate a page frame index in mem_map
array. Why this assumption ?

Why does "mem_map" need to store page frames for
kernel
code ? Are these pages going be used when the Linux is
running ?

I noticed CPHYSADDR macro. This macro only works if
PAGE_OFFSET is equal to 0x80000000. Why does this 
macro exist ? Why not using __pa macro ?


Thanks for your answers.

   Francis.


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
