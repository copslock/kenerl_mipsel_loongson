Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 20:21:48 +0100 (BST)
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:55975 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025683AbZD1TVl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 20:21:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 7C2ED5840BC;
	Tue, 28 Apr 2009 15:21:35 -0400 (EDT)
Received: from stout.engsoc.carleton.ca ([127.0.0.1])
	by localhost (stout.engsoc.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eM5WuFogiING; Tue, 28 Apr 2009 15:21:35 -0400 (EDT)
Received: from mobius.cowpig.ca (cowpig.ca [134.117.69.79])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 5DFA85840AF;
	Tue, 28 Apr 2009 15:21:35 -0400 (EDT)
Received: by mobius.cowpig.ca (Postfix, from userid 1000)
	id 949FA16018C; Tue, 28 Apr 2009 15:21:20 -0400 (EDT)
Date:	Tue, 28 Apr 2009 15:21:20 -0400
From:	Philippe Vachon <philippe@cowpig.ca>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	"Joseph S. Myers" <joseph@codesourcery.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090428192120.GA8066@cowpig.ca>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk> <20090418123815.GA21240@linux-mips.org> <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk> <20090428191750.GZ4902@hall.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090428191750.GZ4902@hall.aurel32.net>
User-Agent: Mutt/1.5.9i
Return-Path: <philippe@cowpig.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe@cowpig.ca
Precedence: bulk
X-list: linux-mips

Hi, 

On Tue, Apr 28, 2009 at 09:17:50PM +0200, Aurelien Jarno wrote:
> Note that this code does not compile on mips64, I get the following
> error from binutils (2.19.1):
> ../ports/sysdeps/unix/sysv/linux/mips/getcontext.S: Assembler messages:
> ../ports/sysdeps/unix/sysv/linux/mips/getcontext.S:102: Error: illegal operands `s.d fs6,(30*8+296)($4)'
> ../ports/sysdeps/unix/sysv/linux/mips/getcontext.S:103: Error: illegal operands `s.d fs7,(31*8+296)($4)'
> 
> The corresponding code lines are:
> 
>  98        s.d     fs2, (26 * SZREG + MCONTEXT_FPREGS)(a0)
>  99        s.d     fs3, (27 * SZREG + MCONTEXT_FPREGS)(a0)
> 100        s.d     fs4, (28 * SZREG + MCONTEXT_FPREGS)(a0)
> 101        s.d     fs5, (29 * SZREG + MCONTEXT_FPREGS)(a0)
> 102        s.d     fs6, (30 * SZREG + MCONTEXT_FPREGS)(a0)
> 103        s.d     fs7, (31 * SZREG + MCONTEXT_FPREGS)(a0)
> 

You're missing one of the patches in the series (the additional changes
to the floating point register names). Once you apply that, you should
be good to go.

Cheers,
Phil
