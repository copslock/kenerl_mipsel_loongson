Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 11:59:32 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:11474
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20028866AbYGPK7a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 11:59:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6GAxSwT002852;
	Wed, 16 Jul 2008 11:59:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6GAxRIP002850;
	Wed, 16 Jul 2008 11:59:27 +0100
Date:	Wed, 16 Jul 2008 11:59:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.26-gitX: insane number of section headers
Message-ID: <20080716105927.GA8206@linux-mips.org>
References: <20080716075246.GA3184@roarinelk.homelinux.net> <20080716081532.GB3184@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080716081532.GB3184@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 10:15:32AM +0200, Manuel Lauss wrote:

> On Wed, Jul 16, 2008 at 09:52:46AM +0200, Manuel Lauss wrote:
> > Hello,
> > 
> > Todays 2.6.26-git kernel produces an insane amout of section headers in the
> > vmlinux file, one for every function. Is that intentional, or a toolchain
> > problem on my side (binutils-2.18, gcc-4.2.4)?
> 
> I see Ralf added -ffunction-sections with commit
> 372a775f50347f5c1dd87752b16e5c05ea965790.

I consider that an experimental commit.  It's meant to solve the problems
we're having on a few very large compilation units with the limited length
of branches.  But if the cure turns out to be worse than the illness I'm
ready to pull it again.

A more proper patchset should modify the linker scripts to avoid the
excessive large number of sections you've noticed.  Somebody else is
currently working on a patchset to allow the --gc-sections ld option so
I decieded to take the path of least resistance for now.

  Ralf
