Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2009 18:33:15 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:52441 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20022417AbZDRRdH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Apr 2009 18:33:07 +0100
Received: (qmail 11228 invoked from network); 18 Apr 2009 17:32:58 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 18 Apr 2009 17:32:58 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.69)
	(envelope-from <joseph@codesourcery.com>)
	id 1LvEPI-00040B-K8; Sat, 18 Apr 2009 17:32:48 +0000
Date:	Sat, 18 Apr 2009 17:32:48 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: <20090418123815.GA21240@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
 <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk>
 <20090418123815.GA21240@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Sat, 18 Apr 2009, Ralf Baechle wrote:

> On Wed, Apr 15, 2009 at 08:19:33PM +0000, Joseph S. Myers wrote:
> 
> > >  Here is code to implement the getcontext API for MIPS.  This glibc patch 
> > > is sent to the linux-mips mailing list, because it makes use of an 
> > > internal syscall which has not been designated as a part of the public 
> > > ABI.  I am writing to request this syscall to become fixed as a part of 
> > > the ABI or to seek for an alternative.  See below for the rationale.
> > 
> > Was there any conclusion about whether the assumptions this patch makes 
> > about the kernel are OK (and so it can go in) or not?
> 
> I've probably not spelled it out clearly enough in an earlier email on
> this topic but yes, I think it's ok.  In all reality the stackframe has
> de facto become a part of the ABI that needs to be kept stable.

Thanks - I've now committed the patch.

-- 
Joseph S. Myers
joseph@codesourcery.com
