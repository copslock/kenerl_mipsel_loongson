Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 22:07:57 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:18181 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1123891AbSJZUH5>;
	Sat, 26 Oct 2002 22:07:57 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 185Y9R-0004vy-00; Sat, 26 Oct 2002 16:07:22 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 185XE5-0004A7-00; Sat, 26 Oct 2002 16:08:05 -0400
Date: Sat, 26 Oct 2002 16:08:05 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Zajerko-McKee, Nick" <nmckee@telogy.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: your mail
Message-ID: <20021026200804.GA15684@nevyn.them.org>
References: <37A3C2F21006D611995100B0D0F9B73CBFE312@tnint11.telogy.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73CBFE312@tnint11.telogy.design.ti.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 26, 2002 at 03:48:27PM -0400, Zajerko-McKee, Nick wrote:
> Hi,
> 
> I'm porting some code from x86 to mips(32) and noticed that in
> include/asm-mips/siginfo.h differs from include/asm-i386/siginfo.h in the
> order of elements of the sigchld structure.  Was this an oversight or a
> design decision?  I would think that it would be desirable to be almost the
> same as the x86 for userland ease of portability...

It's probably for compatibility with that other MIPS operating system -
IRIX.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
