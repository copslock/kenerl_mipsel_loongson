Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 21:20:27 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:41478 "EHLO
	mail.codesourcery.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025719AbZD1UUN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 21:20:13 +0100
Received: (qmail 24215 invoked from network); 28 Apr 2009 20:20:04 -0000
Received: from unknown (HELO tp.orcam.me.uk) (macro@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 28 Apr 2009 20:20:04 -0000
Date:	Tue, 28 Apr 2009 21:19:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@codesourcery.com>
To:	Aurelien Jarno <aurelien@aurel32.net>
cc:	"Joseph S. Myers" <joseph@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: <20090428191750.GZ4902@hall.aurel32.net>
Message-ID: <alpine.DEB.1.10.0904282114540.8828@tp.orcam.me.uk>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk> <20090418123815.GA21240@linux-mips.org> <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk>
 <20090428191750.GZ4902@hall.aurel32.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Tue, 28 Apr 2009, Aurelien Jarno wrote:

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

 This code was validated with all the three ABIs before submission.  Does 
your problem happen with vanilla upstream or your locally-modified 
sources?  If the latter, then please make sure you've got all the 
necessary updates applied.

  Maciej
