Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 09:55:35 +0000 (GMT)
Received: from web25101.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.49]:38275
	"HELO web25101.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8224802AbULVJza>; Wed, 22 Dec 2004 09:55:30 +0000
Received: (qmail 41876 invoked by uid 60001); 22 Dec 2004 09:55:14 -0000
Message-ID: <20041222095514.41874.qmail@web25101.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25101.mail.ukl.yahoo.com via HTTP; Wed, 22 Dec 2004 10:55:14 CET
Date: Wed, 22 Dec 2004 10:55:14 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: port on exotic board.
To: Jun Sun <jsun@junsun.net>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20041222012715.GA13782@gw.junsun.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips


> Since nobody else is replying I am giving it a shot.
>  Hope it helps.

yes it helps, thanks for replying !

> Setting WIRED to zero is just part of kernel
> start-up initialization.
> I think
> this needs to be fixed.  A couple of boards should
> be broken because of this.

yes and anyway the default value for WIRED is zero
after a reset.

> > Why this assumption ?
> > 
> 
> Because all other boards have phys memory starting
> from 0?  It simplies code for sure.

Well, a part of the kernel seems to support this
feature but not all, specially mips specific code...
That make me think that it would not so hard to change
it...
I look at arm-arch code, and at the definition of
"page_to_pfn" and it does what I need:
      (((page) - mem_map) + PHYS_PFN_OFFSET)
I can't believe that I'm the first one on mips 
architecture who is trying to run kernel code located
at a physicall address different from 0 !

> > Are these pages going be used when the Linux is
> > running ?
> 
> Not much in MIPS case I suppose.

If these pages are not used during kernel life, it
could save space to not map kernel code in "mem_map".
PFN 0 could be the first page that map kernel data.

This is specialy true if code starts at 0x20000000.

> 
> > I noticed CPHYSADDR macro. This macro only works
> if
> > PAGE_OFFSET is equal to 0x80000000. Why does this 
> > macro exist ? Why not using __pa macro ?
> 
> Don't know much about this one.
> 

It is a typically mips specific code that prevents
kernel code to start at address different from 0.


> BTW, once there was a board whose memory starts from
> 0x90000000.  It had
> similar problems as yours, but I think it ran in the
> end.  Try to search
> the mailing list.

I can't find it in mailing list archive :(

   Francis


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
