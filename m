Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2009 21:19:57 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:26830 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20021893AbZDOUTs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Apr 2009 21:19:48 +0100
Received: (qmail 12635 invoked from network); 15 Apr 2009 20:19:40 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 15 Apr 2009 20:19:40 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.69)
	(envelope-from <joseph@codesourcery.com>)
	id 1LuBa1-0001HY-5D; Wed, 15 Apr 2009 20:19:33 +0000
Date:	Wed, 15 Apr 2009 20:19:33 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	"Maciej W. Rozycki" <macro@codesourcery.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
Message-ID: <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Sun, 1 Mar 2009, Maciej W. Rozycki wrote:

> Hello,
> 
>  Here is code to implement the getcontext API for MIPS.  This glibc patch 
> is sent to the linux-mips mailing list, because it makes use of an 
> internal syscall which has not been designated as a part of the public 
> ABI.  I am writing to request this syscall to become fixed as a part of 
> the ABI or to seek for an alternative.  See below for the rationale.

Was there any conclusion about whether the assumptions this patch makes 
about the kernel are OK (and so it can go in) or not?

-- 
Joseph S. Myers
joseph@codesourcery.com
