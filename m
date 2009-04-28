Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 20:18:03 +0100 (BST)
Received: from hall.aurel32.net ([88.191.82.174]:59518 "EHLO hall.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025680AbZD1TR5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 20:17:57 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1LysoR-00045B-0L; Tue, 28 Apr 2009 21:17:51 +0200
Date:	Tue, 28 Apr 2009 21:17:50 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	"Joseph S. Myers" <joseph@codesourcery.com>
Cc:	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090428191750.GZ4902@hall.aurel32.net>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk> <20090418123815.GA21240@linux-mips.org> <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Sat, Apr 18, 2009 at 05:32:48PM +0000, Joseph S. Myers wrote:
> On Sat, 18 Apr 2009, Ralf Baechle wrote:
> 
> > On Wed, Apr 15, 2009 at 08:19:33PM +0000, Joseph S. Myers wrote:
> > 
> > > >  Here is code to implement the getcontext API for MIPS.  This glibc patch 
> > > > is sent to the linux-mips mailing list, because it makes use of an 
> > > > internal syscall which has not been designated as a part of the public 
> > > > ABI.  I am writing to request this syscall to become fixed as a part of 
> > > > the ABI or to seek for an alternative.  See below for the rationale.
> > > 
> > > Was there any conclusion about whether the assumptions this patch makes 
> > > about the kernel are OK (and so it can go in) or not?
> > 
> > I've probably not spelled it out clearly enough in an earlier email on
> > this topic but yes, I think it's ok.  In all reality the stackframe has
> > de facto become a part of the ABI that needs to be kept stable.
> 
> Thanks - I've now committed the patch.
> 

Note that this code does not compile on mips64, I get the following
error from binutils (2.19.1):
../ports/sysdeps/unix/sysv/linux/mips/getcontext.S: Assembler messages:
../ports/sysdeps/unix/sysv/linux/mips/getcontext.S:102: Error: illegal operands `s.d fs6,(30*8+296)($4)'
../ports/sysdeps/unix/sysv/linux/mips/getcontext.S:103: Error: illegal operands `s.d fs7,(31*8+296)($4)'

The corresponding code lines are:

 98        s.d     fs2, (26 * SZREG + MCONTEXT_FPREGS)(a0)
 99        s.d     fs3, (27 * SZREG + MCONTEXT_FPREGS)(a0)
100        s.d     fs4, (28 * SZREG + MCONTEXT_FPREGS)(a0)
101        s.d     fs5, (29 * SZREG + MCONTEXT_FPREGS)(a0)
102        s.d     fs6, (30 * SZREG + MCONTEXT_FPREGS)(a0)
103        s.d     fs7, (31 * SZREG + MCONTEXT_FPREGS)(a0)

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
