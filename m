Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 16:51:46 +0000 (GMT)
Received: from crack.them.org ([65.125.64.184]:33191 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225237AbSLKQvp>;
	Wed, 11 Dec 2002 16:51:45 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18MBxW-00078i-00; Wed, 11 Dec 2002 12:51:51 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18MA5r-00036l-00; Wed, 11 Dec 2002 11:52:19 -0500
Date: Wed, 11 Dec 2002 11:52:19 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nigel Stephens <nigel@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: GDB patch
Message-ID: <20021211165218.GA11767@nevyn.them.org>
References: <15862.15924.283825.28108@hendon.algor.co.uk> <20021210193241.GA15908@nevyn.them.org> <3DF6514E.8040100@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF6514E.8040100@mips.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 10, 2002 at 08:40:46PM +0000, Nigel Stephens wrote:
> I thought the Linux community prided itself on inventing new and 
> "non-standard" extensions to the toolchain  ;-). But yes, we should try 
> to avoid incompatible changes. As part of MIPS we will hopefully have 
> the resources to interface with the rest of the GNU community, and argue 
> for the inclusion of our patches in the CVS trees.

Actually, we've been trying to pride ourselves on not doing so :)

> Yup. SDE-MIPS 1.1 shipped in 1992. :-)

Wow...

> Yeah, that's why we dropped 'R' in our more recent gdb ports, but I 
> wasn't aware of the new use of 'r' - I'll check out that page. 

I think it's an old use, actually.  I'm not sure where it was used
though.

> Certainly 'p' is the logical inverse of 'P', so we'll change our gdb 
> remote stub to use that. So how about accepting Carsten's change, with 
> the 'R' case removed, and 'r' changed to 'p'?

Can't do it.  I strongly suspect that it will render the stub unusable
with current versions of FSF GDB.  Your tools add an explicit size to
the packet and the community tools do not; so when they probe for and
discover the P packet, they will probably try to use it and get
confused.  That's why I'd like to discuss this on the GDB list first.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
