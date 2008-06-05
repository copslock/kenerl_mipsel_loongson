Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 22:51:57 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:30389 "HELO
	relay01.mx.bawue.net") by ftp.linux-mips.org with SMTP
	id S28575467AbYFEVvz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 22:51:55 +0100
Received: from lagash (88-106-136-149.dynamic.dsl.as9105.com [88.106.136.149])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 5603448916;
	Thu,  5 Jun 2008 23:51:54 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1K4NNA-0001ea-8L; Thu, 05 Jun 2008 22:51:52 +0100
Date:	Thu, 5 Jun 2008 22:51:52 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>
Cc:	Theodore Tso <tytso@MIT.EDU>, Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org, linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080605215152.GB15504@networkno.de>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com> <20080513045028.GC22226@linux-mips.org> <20080528070637.GA10393@deprecation.cyrius.com> <20080605111148.GA4483@deprecation.cyrius.com> <1212664977.4840.6.camel@sd048.hel.movial.fi> <20080605183854.GN25477@mit.edu> <38408.84.249.59.97.1212701650.squirrel@webmail.movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38408.84.249.59.97.1212701650.squirrel@webmail.movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Vorobiev Dmitri wrote:
> Theodore Tso wrote:
> >
> > If you really insist I suppose we could have a MIPS specific patch
> > where we allocate a 4k page and zero it, so we can use it from our
> > kernel code because you don't want to export and make available the
> > ZERO_PAGE that gets used by the rest of the kernel, but that seems
> > awfully silly, and would be a waste of 4k of memory.....  Someone from
> > MIPS land would have to test it, as well, as I dont think any of the
> > ext4 developers have access to a MIPS platform.
> 
> Ted, Ralf seems to be unwilling to accept the ZERO_PAGE() export. If you
> send the MIPS-specific patch, I can do the testing for you as I have a
> MIPS Malta board at my disposal.

AFAIU the problematic case are systems with R4000/R4400 SC/MC CPUs
since they use 8 zero pages of different color. Have a look at
arch/mips/mm/init.c:setup_zero_pages.


Thiemo
