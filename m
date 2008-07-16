Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 12:04:00 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:12510 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20040310AbYGPLD6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 12:03:58 +0100
Received: (qmail 5681 invoked by uid 1000); 16 Jul 2008 13:03:57 +0200
Date:	Wed, 16 Jul 2008 13:03:57 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.26-gitX: insane number of section headers
Message-ID: <20080716110357.GA5093@roarinelk.homelinux.net>
References: <20080716075246.GA3184@roarinelk.homelinux.net> <20080716081532.GB3184@roarinelk.homelinux.net> <20080716105927.GA8206@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080716105927.GA8206@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 11:59:27AM +0100, Ralf Baechle wrote:
> On Wed, Jul 16, 2008 at 10:15:32AM +0200, Manuel Lauss wrote:
> 
> > On Wed, Jul 16, 2008 at 09:52:46AM +0200, Manuel Lauss wrote:
> > > Hello,
> > > 
> > > Todays 2.6.26-git kernel produces an insane amout of section headers in the
> > > vmlinux file, one for every function. Is that intentional, or a toolchain
> > > problem on my side (binutils-2.18, gcc-4.2.4)?
> > 
> > I see Ralf added -ffunction-sections with commit
> > 372a775f50347f5c1dd87752b16e5c05ea965790.
> 
> I consider that an experimental commit.  It's meant to solve the problems
> we're having on a few very large compilation units with the limited length
> of branches.  But if the cure turns out to be worse than the illness I'm
> ready to pull it again.

If it fixes bugs for people, then by all means leave it in.  I was just
curious because my self-written bootloader complained about it.

Thanks for the explanation.

Manuel Lauss
