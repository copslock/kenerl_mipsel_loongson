Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2008 09:52:17 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:17039 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20021379AbYE1IwO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 May 2008 09:52:14 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1K1HOH-0003pa-00; Wed, 28 May 2008 10:52:13 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 28620C2BBC; Wed, 28 May 2008 10:50:34 +0200 (CEST)
Date:	Wed, 28 May 2008 10:50:34 +0200
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Malta build errors with 2.6.26-rc1
Message-ID: <20080528085033.GA6250@alpha.franken.de>
References: <20080512163107.GA19052@deprecation.cyrius.com> <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com> <20080528071240.GB10393@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080528071240.GB10393@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, May 28, 2008 at 09:12:40AM +0200, Martin Michlmayr wrote:
> * Dmitri Vorobiev <dmitri.vorobiev@gmail.com> [2008-05-12 23:46]:
> > > Some Malta build errors:
> > >
> > >  cc1: warnings being treated as errors
> > >  arch/mips/mips-boards/malta/malta_int.c: In function 'gcmp_probe':
> > >  arch/mips/mips-boards/malta/malta_int.c:408: warning: cast to pointer from integer of different size
> > >  arch/mips/mips-boards/malta/malta_int.c: In function 'arch_init_irq':
> > >  arch/mips/mips-boards/malta/malta_int.c:437: warning: cast to pointer from integer of different size
> > >  arch/mips/mips-boards/malta/malta_int.c:441: warning: cast to pointer from integer of different size
> > >  arch/mips/mips-boards/malta/malta_int.c: In function 'malta_be_handler':
> > >  arch/mips/mips-boards/malta/malta_int.c:656: warning: cast to pointer from integer of different size
> > >  arch/mips/mips-boards/malta/malta_int.c:657: warning: cast to pointer from integer of different size
> > >  arch/mips/mips-boards/malta/malta_int.c:658: warning: cast to pointer from integer of different size
> > >  arch/mips/mips-boards/malta/malta_int.c:704: warning: cast to pointer from integer of different size
> > >  make[5]: *** [arch/mips/mips-boards/malta/malta_int.o] Error 1
> > >
> > >  and:
> > >
> > >  arch/mips/mips-boards/generic/amon.c: In function 'amon_cpu_avail':
> > >  arch/mips/mips-boards/generic/amon.c:31: error: implicit declaration of function 'KSEG0ADDR'
> > >  cc1: warnings being treated as errors
> > >  arch/mips/mips-boards/generic/amon.c:31: warning: cast to pointer from integer of different size
> > >  arch/mips/mips-boards/generic/amon.c: In function 'amon_cpu_start':
> > >  arch/mips/mips-boards/generic/amon.c:56: warning: cast to pointer from integer of different size
> > >  make[4]: *** [arch/mips/mips-boards/malta] Error 2
> > >
> > 
> > Known error. Please see this thread for some suggestions (and be
> > warned that I did not try any of them):
> > http://marc.info/?t=120966332300004&r=1&w=2
> 
> Isn't that a completely different issue?  Anyway, I just tried and I
> still see the problems above (with 64 bit Malta) still after applying
> the traps.c patch from Thomas Bogendoerfer.

I didn't fix the problems above. The change to traps.c only fixes
traps.c for 64bit builds and it's a totally different issue. Looking
at the warning/errors someone needs to fix some data types and use 
CKSEG0ADDR(). I don't have the hardware, so I could only provide
an untested patch, if no one else steps forward...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
