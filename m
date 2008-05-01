Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2008 22:01:28 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:6127 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20033234AbYEAVBZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2008 22:01:25 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m41L1FBq008191;
	Thu, 1 May 2008 23:01:15 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m41L1E81008187;
	Thu, 1 May 2008 22:01:15 +0100
Date:	Thu, 1 May 2008 22:01:13 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:	linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
In-Reply-To: <20080501163314.GA9955@alpha.franken.de>
Message-ID: <Pine.LNX.4.55.0805012150130.6145@cliff.in.clinika.pl>
References: <20080501163314.GA9955@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 1 May 2008, Thomas Bogendoerfer wrote:

> it would be nice, if people started thinking before supplying such
> crappy^Winteresting code:
> 
> arch/mips/kernel/traps.c:
> 
> #define IS_KVA01(a) ((((unsigned int)a) & 0xc0000000) == 0x80000000)
> 
> Kills every 64bit kernel build...

 Not everybody tests 64-bit stuff as some people limit themselves to
32-bit systems only.  It looks like a step backwards, but there you go.

> Why is this needed at all ?

 It looks like an attempt to avoid TLB exceptions for the stack dump -- if
that is the case, then obviously a piece of code like one in
arch/mips/lib/uncached.c should be used to check for CKSEG0/1 and XKPHYS.  
If there are two uses of this code, then it should be wrapped in an inline
function and put in a header; <asm/addrspace.h>, perhaps.

  Maciej
