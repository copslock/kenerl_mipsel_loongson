Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 12:08:52 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:9640
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28576155AbYGPLIu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 12:08:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6GB8mAK006058;
	Wed, 16 Jul 2008 12:08:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6GB8mtg006056;
	Wed, 16 Jul 2008 12:08:48 +0100
Date:	Wed, 16 Jul 2008 12:08:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.26-gitX: insane number of section headers
Message-ID: <20080716110848.GB8206@linux-mips.org>
References: <20080716075246.GA3184@roarinelk.homelinux.net> <20080716081532.GB3184@roarinelk.homelinux.net> <20080716105927.GA8206@linux-mips.org> <20080716110357.GA5093@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080716110357.GA5093@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 01:03:57PM +0200, Manuel Lauss wrote:

> > I consider that an experimental commit.  It's meant to solve the problems
> > we're having on a few very large compilation units with the limited length
> > of branches.  But if the cure turns out to be worse than the illness I'm
> > ready to pull it again.
> 
> If it fixes bugs for people, then by all means leave it in.  I was just
> curious because my self-written bootloader complained about it.

I wonder why your bootloader cares about sections.  Normally a bootloader
only ever should think about segments and the number of segments the
sections are getting mapped to should be unchanged by my patch.

> Thanks for the explanation.

Immer doch :-)

  Ralf
