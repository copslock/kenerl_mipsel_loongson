Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Dec 2004 18:13:29 +0000 (GMT)
Received: from web25104.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.52]:10076
	"HELO web25104.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225321AbULMSNY>; Mon, 13 Dec 2004 18:13:24 +0000
Received: (qmail 23076 invoked by uid 60001); 13 Dec 2004 18:12:53 -0000
Message-ID: <20041213181252.23074.qmail@web25104.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25104.mail.ukl.yahoo.com via HTTP; Mon, 13 Dec 2004 19:12:52 CET
Date: Mon, 13 Dec 2004 19:12:52 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Kernel located in KSEG2 or KSEG3.
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Hi,

Sorry if you find this post stupid, but I'm quite new
in Linux.

To learn on Linux kernel, I've decided to port it on 
particular board with (very) limited resources and
based with a 4KC processor core. As far I see, I need
at least a couple of mega bytes of memory to achieve
my goal. 
Unfortunately the only way to get this amount of mem
is
to execute linux in memory that can only be accessed
through KSEG2 and KSEG3 !

Here is my board's mapping:

Physical Memory Map:

start        size       type
-----------------------------
0x20000000 - 8MB    - SDRAM
0x30000000 - 16MB   - FLASH
0x40000000 - 16MB   - FLASH
0x50000000 - 2MB    - SRAM


I looked into the memory init code and I don't think
that it's possible to run linux in a segment different
from KSEG0. Am I wrong ?

I've noticed a CONFIG_MAPPED_KERNEL macro but it seems
that it's only used to replicate kernel from mapped
memory to KSEG0...

Thanks for your answers.



	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/ 
 
Avec Yahoo! faites un don et soutenez le Téléthon en cliquant sur http://www.telethon.fr/030-Don/10-10_Don.asp
