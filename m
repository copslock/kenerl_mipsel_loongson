Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 20:14:30 +0000 (GMT)
Received: from crack.them.org ([IPv6:::ffff:65.125.64.184]:63400 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8224939AbTBMUO3>;
	Thu, 13 Feb 2003 20:14:29 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18jRdY-0006r4-00; Thu, 13 Feb 2003 16:15:20 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18jPkP-0003B8-00; Thu, 13 Feb 2003 15:14:17 -0500
Date: Thu, 13 Feb 2003 15:14:17 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Long Li <long21st@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: memcpy embedded in gcc?
Message-ID: <20030213201417.GA12200@nevyn.them.org>
References: <20030213200757.92340.qmail@web40411.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213200757.92340.qmail@web40411.mail.yahoo.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 13, 2003 at 12:07:57PM -0800, Long Li wrote:
> Hi,
> 
> I am using a gcc 3.0.4 MIPS crosscompiler on Redhat. I
> found something interesting: when I use specifly -O1
> for compilation, and I can use memcpy function even I
> did not tell the compiler where I declard it or define
> it. However, when I specify -O0, then the compiler
> tells me undefined reference to this memcpy function.
> So my questions are:
> 
> 1. Is memcpy a built-in function for gcc? But why not
> for optimization level 0?

Because using it is an optimization.

> 2. Besides memcpy, is there any other functions built
> in too?

Lots.  The list varies depending on the GCC version; see the manual.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
