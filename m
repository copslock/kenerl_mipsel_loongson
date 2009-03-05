Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 15:35:03 +0000 (GMT)
Received: from mail.codesourcery.com ([65.74.133.4]:399 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20808979AbZCEPfA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Mar 2009 15:35:00 +0000
Received: (qmail 31753 invoked from network); 5 Mar 2009 15:34:57 -0000
Received: from unknown (HELO pl.orcam.me.uk) (macro@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 5 Mar 2009 15:34:57 -0000
Date:	Thu, 5 Mar 2009 15:34:45 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@codesourcery.com>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: <49AD6139.60209@caviumnetworks.com>
Message-ID: <alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Tue, 3 Mar 2009, David Daney wrote:

> Note the libgcc currently makes the assumption that the layout of the stack
> for signal handlers is fixed.  The DWARF2 unwinder needs this information to
> be able to unwind through signal frames (see gcc/config/mips/linux-unwind.h),
> so it is already a de facto part of the ABI.

 I do hope it was agreed upon at some point.  I certainly cannot recall a 
discussion at the linux-mips list, but I did not always follow it closely 
enough either, so I may have missed the discussion.  The interface is 
meant to be internal to Linux, so the usual rule of volatility apply.  The 
structure is not defined in a header even.

> >  Furthermore I am requesting that the kernel recognises the special meaning
> > of the value of one stored in the slot designated for the $zero register and
> > never places such a value itself there.
> 
> Seems reasonable to me as currently a zero is unconditionally stored there.

 It is, but is should be architected, not assumed.  Also contexts built 
with the *context() functions are meant to be usable by them only -- 
software will still be able to assume the value in the slot when 
constructed by the kernel.

  Maciej
