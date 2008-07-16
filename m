Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 12:28:09 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:22996 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28580179AbYGPL2H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 12:28:07 +0100
Received: (qmail 5860 invoked by uid 1000); 16 Jul 2008 13:28:05 +0200
Date:	Wed, 16 Jul 2008 13:28:05 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.26-gitX: insane number of section headers
Message-ID: <20080716112805.GA5848@roarinelk.homelinux.net>
References: <20080716075246.GA3184@roarinelk.homelinux.net> <20080716081532.GB3184@roarinelk.homelinux.net> <20080716105927.GA8206@linux-mips.org> <20080716110357.GA5093@roarinelk.homelinux.net> <20080716110848.GB8206@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080716110848.GB8206@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 12:08:48PM +0100, Ralf Baechle wrote:
> On Wed, Jul 16, 2008 at 01:03:57PM +0200, Manuel Lauss wrote:
> 
> > > I consider that an experimental commit.  It's meant to solve the problems
> > > we're having on a few very large compilation units with the limited length
> > > of branches.  But if the cure turns out to be worse than the illness I'm
> > > ready to pull it again.
> > 
> > If it fixes bugs for people, then by all means leave it in.  I was just
> > curious because my self-written bootloader complained about it.
> 
> I wonder why your bootloader cares about sections.  Normally a bootloader
> only ever should think about segments and the number of segments the
> sections are getting mapped to should be unchanged by my patch.

It doesn't -- I just thought that if the number ever gets bigger than what
used to be the norm in alchemy-land then a) flash is erased, or b) something
broke.

 
> > Thanks for the explanation.
> 
> Immer doch :-)

Vielen Dank!

Manuel Lauss
