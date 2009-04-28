Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 21:53:15 +0100 (BST)
Received: from hall.aurel32.net ([88.191.82.174]:48221 "EHLO hall.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025734AbZD1UxI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 21:53:08 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1LyuIZ-0005nK-4a; Tue, 28 Apr 2009 22:53:03 +0200
Date:	Tue, 28 Apr 2009 22:53:03 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	"Maciej W. Rozycki" <macro@codesourcery.com>
Cc:	"Joseph S. Myers" <joseph@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090428205303.GA4902@hall.aurel32.net>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk> <20090418123815.GA21240@linux-mips.org> <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk> <20090428191750.GZ4902@hall.aurel32.net> <alpine.DEB.1.10.0904282114540.8828@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0904282114540.8828@tp.orcam.me.uk>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Tue, Apr 28, 2009 at 09:19:54PM +0100, Maciej W. Rozycki wrote:
> On Tue, 28 Apr 2009, Aurelien Jarno wrote:
> 
> > Note that this code does not compile on mips64, I get the following
> > error from binutils (2.19.1):
> > ../ports/sysdeps/unix/sysv/linux/mips/getcontext.S: Assembler messages:
> > ../ports/sysdeps/unix/sysv/linux/mips/getcontext.S:102: Error: illegal operands `s.d fs6,(30*8+296)($4)'
> > ../ports/sysdeps/unix/sysv/linux/mips/getcontext.S:103: Error: illegal operands `s.d fs7,(31*8+296)($4)'
> > 
> > The corresponding code lines are:
> > 
> >  98        s.d     fs2, (26 * SZREG + MCONTEXT_FPREGS)(a0)
> >  99        s.d     fs3, (27 * SZREG + MCONTEXT_FPREGS)(a0)
> > 100        s.d     fs4, (28 * SZREG + MCONTEXT_FPREGS)(a0)
> > 101        s.d     fs5, (29 * SZREG + MCONTEXT_FPREGS)(a0)
> > 102        s.d     fs6, (30 * SZREG + MCONTEXT_FPREGS)(a0)
> > 103        s.d     fs7, (31 * SZREG + MCONTEXT_FPREGS)(a0)
> 
>  This code was validated with all the three ABIs before submission.  Does 
> your problem happen with vanilla upstream or your locally-modified 
> sources?  If the latter, then please make sure you've got all the 
> necessary updates applied.
> 

I am sorry, I should have said I was using the patch backported to the
2.9 sources. Indeed, as pointed out by Philippe Vachon, I was missing a
part of the patch. Sorry for the noise.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
