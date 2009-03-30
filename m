Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 17:36:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14281 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20029139AbZC3QgW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2009 17:36:22 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2UGNwVv009739;
	Mon, 30 Mar 2009 18:23:59 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2UGNqrE009736;
	Mon, 30 Mar 2009 18:23:52 +0200
Date:	Mon, 30 Mar 2009 18:23:52 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Kevin Hickey <khickey@rmicorp.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Alchemy: platform updates
Message-ID: <20090330162352.GA4164@linux-mips.org>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net> <49CF5CE6.1070003@ru.mvista.com> <20090329143802.0a09baca@scarran.roarinelk.net> <49CF71BE.2070109@ru.mvista.com> <1238340466.28598.4.camel@kh-d820> <20090329175243.04ebfd56@scarran.roarinelk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090329175243.04ebfd56@scarran.roarinelk.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 29, 2009 at 05:52:43PM +0200, Manuel Lauss wrote:
> From: Manuel Lauss <mano@roarinelk.homelinux.net>
> Date: Sun, 29 Mar 2009 17:52:43 +0200
> To: Kevin Hickey <khickey@rmicorp.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>,
> 	Linux-MIPS <linux-mips@linux-mips.org>
> Subject: Re: [PATCH 0/3] Alchemy: platform updates
> Content-Type: text/plain; charset=US-ASCII
> 
> On Sun, 29 Mar 2009 10:27:46 -0500
> Kevin Hickey <khickey@rmicorp.com> wrote:
> 
> > On Sun, 2009-03-29 at 17:03 +0400, Sergei Shtylyov wrote:
> > >   Single kernel binary? If it's at all possible, I am all for it.
> > 
> > On some level, I agree but not at the expense of a larger kernel or
> > longer boot times.  Maybe I'm just not following how your implementation
> > works but it seems to me that runtime checks will add to boot time.
> > More importantly it adds to the kernel memory footprint as the tables of
> > constants for multiple CPUs will have to be compiled in.  If I'm
> > designing a board with an Au1250 in it, I don't care about the interrupt
> > numbers for Au1100 or Au1500.  This problem compounds when we introduce
> > Au1300 - several of its subsystems (like the interrupt controller) are
> > new requiring not only a new table of constants but a new object as
> > well.  In the desktop space I can understand this approach, but in the
> > embedded space it seems like an unnecessary resource burden.  
> > 
> > Please enlighten me :)
> 
> You're right, from a single-cpu-board POV it doesn't make sense.
> However if you have a few boards which mostly differ in the Alchemy
> chip used (and not much else difference in board support code), I find
> this to be highly beneficial.  If I can have a single binary for the
> folks testing these boards, all the better!
> 
> Yes, increased binary size is to be expected, but I don't expect it to
> be in the megabyte range.
> 
> I'm primarily doing this for company-internal purposes; I just thought
> I'd share the final result, maybe someone else might find it useful.

In the past the Alchemy code has frequently suffered from small silly
bugs that were affecting only a part of the Alchemy platforms.  If
code was more generic there would be the additional benefit of improved
test coverage without more testing.

I frequently see people still optimizing code as if the problem was
still squeezing a program into a 2716 EPROM for an 8085.  Trading a
few bytes or microseconds of startup time for sanity is a really good
thing!

  Ralf
