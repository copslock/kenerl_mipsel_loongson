Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 09:17:30 +0000 (GMT)
Received: from web25107.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.55]:1905
	"HELO web25107.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225275AbVANJR0>; Fri, 14 Jan 2005 09:17:26 +0000
Received: (qmail 47320 invoked by uid 60001); 14 Jan 2005 09:17:15 -0000
Message-ID: <20050114091715.47318.qmail@web25107.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25107.mail.ukl.yahoo.com via HTTP; Fri, 14 Jan 2005 10:17:15 CET
Date: Fri, 14 Jan 2005 10:17:15 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: initrd support.
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Hi,

I'm going to use initrd to mount my root fs, but I was
wondering what its status...
I have noticed in boot directory addinitrd program
that seems to add an initrd image right after the
kernel.
But there's also a section in kernel/vmlinux.lds.S
called
.initrd that includes initrd image during kernel 
compilation.

Why are there two different ways of using initrd ?
Which one I should use ?

Thanks for your answers.

Francis.


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
