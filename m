Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 10:00:28 +0000 (GMT)
Received: from web25101.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.49]:54404
	"HELO web25101.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8224802AbULVKAY>; Wed, 22 Dec 2004 10:00:24 +0000
Received: (qmail 42979 invoked by uid 60001); 22 Dec 2004 10:00:06 -0000
Message-ID: <20041222100006.42977.qmail@web25101.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25101.mail.ukl.yahoo.com via HTTP; Wed, 22 Dec 2004 11:00:06 CET
Date: Wed, 22 Dec 2004 11:00:06 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: port on exotic board.
To: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <41C8D6F5.2080007@total-knowledge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

> CPHYSADDR gives you physical address from an address
> that lies in
> one of compatibility "unmapped" spaces.
> "compatibility" in this case refers
> to 32bit MIPS view of memory space.
> 
> As such, CPHYSADDR macro generally should not be
> used.

Well I still don't understand, why it has been
created...
Why does it should replaced "__pa" in particular time
?

Thanks

   Francis


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
