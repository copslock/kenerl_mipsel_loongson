Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 22:47:55 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:45572 "EHLO
	mail.codesourcery.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20021675AbZD1Vrs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 22:47:48 +0100
Received: (qmail 5543 invoked from network); 28 Apr 2009 21:47:41 -0000
Received: from unknown (HELO tp.orcam.me.uk) (macro@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 28 Apr 2009 21:47:41 -0000
Date:	Tue, 28 Apr 2009 22:47:32 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@codesourcery.com>
To:	Aurelien Jarno <aurelien@aurel32.net>
cc:	"Joseph S. Myers" <joseph@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: <20090428205303.GA4902@hall.aurel32.net>
Message-ID: <alpine.DEB.1.10.0904282237570.8828@tp.orcam.me.uk>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk> <20090418123815.GA21240@linux-mips.org> <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk> <20090428191750.GZ4902@hall.aurel32.net>
 <alpine.DEB.1.10.0904282114540.8828@tp.orcam.me.uk> <20090428205303.GA4902@hall.aurel32.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Tue, 28 Apr 2009, Aurelien Jarno wrote:

> >  This code was validated with all the three ABIs before submission.  Does 
> > your problem happen with vanilla upstream or your locally-modified 
> > sources?  If the latter, then please make sure you've got all the 
> > necessary updates applied.
> > 
> 
> I am sorry, I should have said I was using the patch backported to the
> 2.9 sources. Indeed, as pointed out by Philippe Vachon, I was missing a
> part of the patch. Sorry for the noise.

 No problem; I suppose my accompanying note about the dependency included 
with the patch must have been lost in transit.  This piece of code is 
actually generic enough and self-contained it should work as it is or with 
minimal porting effort for several versions of the library back.

  Maciej
