Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 11:15:54 +0000 (GMT)
Received: from web25105.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.53]:7802
	"HELO web25105.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225192AbVATLPt>; Thu, 20 Jan 2005 11:15:49 +0000
Received: (qmail 38078 invoked by uid 60001); 20 Jan 2005 11:15:43 -0000
Message-ID: <20050120111543.38076.qmail@web25105.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25105.mail.ukl.yahoo.com via HTTP; Thu, 20 Jan 2005 12:15:43 CET
Date:	Thu, 20 Jan 2005 12:15:43 +0100 (CET)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: dcache issue...
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

hi all,

I almost done to run linux in kseg2. But I noticed a
bug
related to the cache that I can't explain. Maybe
you'll
have an idea...

I configured kseg2 to map kernel space, and to be
"uncached". So when accessing kernel space, virtual
addr > 0xc0000000, I don't use both icache and dcache.
When kernel maps a user page in user space, it uses
data cache. In this scenario, some kernel data are
corrupted. But when I map kernel space and activate
caches to access it, it seems to work.

Thanks in advance.

Francis.


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
