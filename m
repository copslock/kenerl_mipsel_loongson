Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 18:11:47 +0100 (BST)
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49318 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20031489AbXJWRLh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 18:11:37 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 873F4182DCA;
	Tue, 23 Oct 2007 19:13:10 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 69CC63CE5CD; Tue, 23 Oct 2007 19:12:02 +0200 (CEST)
Date:	Tue, 23 Oct 2007 19:12:02 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Discardable strings for init and exit sections
Message-ID: <20071023171201.GW30533@stusta.de>
References: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl> <20071012171938.GB6476@stusta.de> <20071012175209.GA1110@linux-mips.org> <20071012181544.GC6476@stusta.de> <Pine.LNX.4.64N.0710231753250.8693@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710231753250.8693@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 05:57:38PM +0100, Maciej W. Rozycki wrote:
> On Fri, 12 Oct 2007, Adrian Bunk wrote:
> 
> > - Most of the string annotations are (naturally) dev{init,exit}
> >   annotations, and bugs there are therefore in configurations that have
> >   only extremely low testing coverage during -rc.
> > - I'm counting 22 annotations in the driver Maciej converted as an
> >   example. When estimating the number of possible annotations based
> >   on the number of C files in the kernel I'm getting a six digit
> >   number.
> > 
> > No matter how hard it would be to teach gcc about it, when thinking of 
> > the amount of __*init*/__*exit* bugs we already have I simply can't 
> > imagine the string annotations as a maintainable solution.
> 
>  Well, it is up to the maintainer of code in question to get it right if 
> interested.  Otherwise having no annotation and leaving the relevant 
> strings resident in the memory throughout the lifespan of the system is a 
> valid and perfectly working option.

If we want to go this route users may want to have this for all code 
they are using. This is not a per-maintainer question, that's a global 
thing: If janitors start annotating all source files in the kernel the 
resulting patches can't be accepted or rejected only based on the 
personal preferences of the maintainers.

>  If you worry about the reverse case, where an annotation should be 
> removed because the containing function is no longer __*init*/__*exit*, 
> then I think `modpost' does a reasonably good job finding such places.

As long as the modpost warnings are just warnings they will often be 
missed at compile time.

And most of the annotations (also in the driver you converted as an 
example) will be dev{init,exit} annotations, and bugs there are in 
configurations virtually noone tests during -rc

>   Maciej

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
