Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 10:04:46 +0000 (GMT)
Received: from web25103.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.51]:11379
	"HELO web25103.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8224948AbULVKEm>; Wed, 22 Dec 2004 10:04:42 +0000
Received: (qmail 33170 invoked by uid 60001); 22 Dec 2004 10:04:23 -0000
Message-ID: <20041222100423.33168.qmail@web25103.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25103.mail.ukl.yahoo.com via HTTP; Wed, 22 Dec 2004 11:04:23 CET
Date: Wed, 22 Dec 2004 11:04:23 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: port on exotic board.
To: Manish Lachwani <m_lachwani@yahoo.com>, Jun Sun <jsun@junsun.net>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20041222053651.1246.qmail@web52805.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

> ....
> 
> Maybe you can do the same for this board as well
> 

I don't think so, because at the boot time, before
running the very first lines of linux code, the kernel
must be mapped through the TLB. Used TLB entries
should
never be modified, because linux uses them to run
itself, even at boot time !

   Francis


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
