Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 10:19:26 +0000 (GMT)
Received: from web25109.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.57]:57518
	"HELO web25109.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8224948AbULVKTV>; Wed, 22 Dec 2004 10:19:21 +0000
Received: (qmail 27139 invoked by uid 60001); 22 Dec 2004 10:19:06 -0000
Message-ID: <20041222101906.27137.qmail@web25109.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25109.mail.ukl.yahoo.com via HTTP; Wed, 22 Dec 2004 11:19:06 CET
Date: Wed, 22 Dec 2004 11:19:06 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Problem registering interrupt
To: linux-mips@linux-mips.org, sebastient@otii.com
In-Reply-To: <41C947CC.20709@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips


> CPU 0 Unable to handle kernel paging request at
> virtual address 00000004, epc =4

Well it suggests me that your driver is trying to 
access a really nasty pointer: 0x00000004...
How did you get this address ? From user space ?

   Francis


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
