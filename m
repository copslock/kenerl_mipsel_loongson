Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 16:52:51 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:11910 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20026009AbZC2Pwm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 16:52:42 +0100
Received: (qmail 24685 invoked from network); 29 Mar 2009 17:52:07 +0200
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 29 Mar 2009 17:52:07 +0200
Date:	Sun, 29 Mar 2009 17:52:43 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Alchemy: platform updates
Message-ID: <20090329175243.04ebfd56@scarran.roarinelk.net>
In-Reply-To: <1238340466.28598.4.camel@kh-d820>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
	<49CF5CE6.1070003@ru.mvista.com>
	<20090329143802.0a09baca@scarran.roarinelk.net>
	<49CF71BE.2070109@ru.mvista.com>
	<1238340466.28598.4.camel@kh-d820>
Organization: Private
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Sun, 29 Mar 2009 10:27:46 -0500
Kevin Hickey <khickey@rmicorp.com> wrote:

> On Sun, 2009-03-29 at 17:03 +0400, Sergei Shtylyov wrote:
> >   Single kernel binary? If it's at all possible, I am all for it.
> 
> On some level, I agree but not at the expense of a larger kernel or
> longer boot times.  Maybe I'm just not following how your implementation
> works but it seems to me that runtime checks will add to boot time.
> More importantly it adds to the kernel memory footprint as the tables of
> constants for multiple CPUs will have to be compiled in.  If I'm
> designing a board with an Au1250 in it, I don't care about the interrupt
> numbers for Au1100 or Au1500.  This problem compounds when we introduce
> Au1300 - several of its subsystems (like the interrupt controller) are
> new requiring not only a new table of constants but a new object as
> well.  In the desktop space I can understand this approach, but in the
> embedded space it seems like an unnecessary resource burden.  
> 
> Please enlighten me :)

You're right, from a single-cpu-board POV it doesn't make sense.
However if you have a few boards which mostly differ in the Alchemy
chip used (and not much else difference in board support code), I find
this to be highly beneficial.  If I can have a single binary for the
folks testing these boards, all the better!

Yes, increased binary size is to be expected, but I don't expect it to
be in the megabyte range.

I'm primarily doing this for company-internal purposes; I just thought
I'd share the final result, maybe someone else might find it useful.

	Manuel Lauss
