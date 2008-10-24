Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 21:34:57 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:24471 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22314753AbYJXUes (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 21:34:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9OKYhrE031798;
	Fri, 24 Oct 2008 21:34:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9OKYgIY031796;
	Fri, 24 Oct 2008 21:34:42 +0100
Date:	Fri, 24 Oct 2008 21:34:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Zhang Le <r0bertz@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] defined a macro for lemote 2e box IO base
Message-ID: <20081024203442.GI25297@linux-mips.org>
References: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org> <20081022202812.GB10625@linux-mips.org> <20081024072745.GA14652@adriano.hkcable.com.hk> <alpine.LFD.1.10.0810242119430.31223@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810242119430.31223@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 24, 2008 at 09:24:05PM +0100, Maciej W. Rozycki wrote:

> > Thanks for the comment.
> > I have checked how other platforms handle this problem.
> > Many have used CKSEG1ADDR.
> 
>  Please note long-term we want CKSEG1ADDR() to go away from board/platform 
> code and possibly only keep it for some generic use if at all.  Have you 
> considered using ioremap()?  With a literal physical address it should get 
> optimised to the same code as the use of CKSEG1ADDR() produces, yet keep 
> the source portable and in line with the rest of the kernel.  I try to 
> remove references to CKSEG1ADDR() as I come across them myself too.

We should probably start removing them all over the source so people have
less bad examples to copy from.  The reason why KSEG0ADDR() and all the
other macros exist is that all the other UNIX operating systems before were
using something like it also.  But in Linux it has two disadvantages -
it duplicates the functionality of a generic interface in arch code which
is making for example the live of kernel janitors who don't know about
MIPSisms harder.  And it's not a terribly nice interface for dealing with
32-bit vs. 64-bit addresses.

  Ralf
