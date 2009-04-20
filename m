Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 20:57:28 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:20874 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20023118AbZDTT5V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 20:57:21 +0100
Received: (qmail 6190 invoked from network); 20 Apr 2009 19:57:11 -0000
Received: from unknown (HELO tp.orcam.me.uk) (macro@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 20 Apr 2009 19:57:11 -0000
Date:	Mon, 20 Apr 2009 20:57:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@codesourcery.com>
To:	"Joseph S. Myers" <joseph@codesourcery.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.1.10.0904202056070.8828@tp.orcam.me.uk>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk> <20090418123815.GA21240@linux-mips.org> <Pine.LNX.4.64.0904181732250.11016@digraph.polyomino.org.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Sat, 18 Apr 2009, Joseph S. Myers wrote:

> > I've probably not spelled it out clearly enough in an earlier email on
> > this topic but yes, I think it's ok.  In all reality the stackframe has
> > de facto become a part of the ABI that needs to be kept stable.
> 
> Thanks - I've now committed the patch.

 Thanks to everybody involved.

  Maciej
