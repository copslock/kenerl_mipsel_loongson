Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 18:03:55 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:12928 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133593AbWG0RDo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Jul 2006 18:03:44 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id CC936469AB; Thu, 27 Jul 2006 19:03:36 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G69GL-00012R-Np; Thu, 27 Jul 2006 18:03:05 +0100
Date:	Thu, 27 Jul 2006 18:03:05 +0100
To:	David Daney <ddaney@avtrex.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
Message-ID: <20060727170305.GB4505@networkno.de>
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp> <44C8EFE2.4010102@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C8EFE2.4010102@avtrex.com>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Atsushi Nemoto wrote:
> >Instead of dump all possible address in the stack, unwind the stack
> >frame based on prologue code analysis, as like as get_chan() does.
> >While the code analysis might fail for some reason, there is a new
> >kernel option "raw_show_trace" to disable this feature.
> >
> >Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> Let me start by saying I have not analyzed how all this code works, but 
> I have done something similar in user space.
> 
> Since the kernel ABI does not use gp, many functions may not have a 
> prolog (especially when compiled with newer versions of GCC).  In the 
> user space case, most leaf functions have no prolog.  For the kernel I 
> would imagine that many non-leaf functions (simple non-leaf functions 
> that do only a tail call) would also not have a prolog.

Non-leaves have to save/restore $31 somewhere, so there should be a
prologue.


Thiemo
