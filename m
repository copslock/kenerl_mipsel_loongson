Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 18:12:54 +0100 (BST)
Received: from intranet.codesourcery.com ([65.74.133.6]:52637 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S8133492AbWFHRMq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jun 2006 18:12:46 +0100
Received: (qmail 25998 invoked from network); 8 Jun 2006 17:12:39 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 8 Jun 2006 17:12:39 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.52)
	id 1FoO3i-0002OI-6Y; Thu, 08 Jun 2006 17:12:38 +0000
Date:	Thu, 8 Jun 2006 17:12:38 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: N32 sigset and __COMPAT_ENDIAN_SWAP__
In-Reply-To: <20060608165136.GA17152@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0606081706310.7925@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk>
 <20060608165136.GA17152@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Thu, 8 Jun 2006, Ralf Baechle wrote:

> Interesting that a bug of this sort manages to survive for that long.
> I guess it is proof that barely anybody is using 64-bit little endian,
> yet we're cursed to support it.

I might conclude that barely anybody is *yet* using NPTL on 64-bit MIPS at 
all, for either endianness, given that most of the problems I've been 
finding, in glibc as well as the kernel, don't seem endian-specific and 
would probably show up in a glibc testsuite run for either endianness.  
MIPS64 NPTL is very new and seems to do a good job of showing up bugs in 
the three syscall interfaces.

-- 
Joseph S. Myers
joseph@codesourcery.com
