Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 12:58:08 +0100 (BST)
Received: from p508B5469.dip.t-dialin.net ([IPv6:::ffff:80.139.84.105]:11434
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225278AbTDPL6H>; Wed, 16 Apr 2003 12:58:07 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3GBvue08365;
	Wed, 16 Apr 2003 13:57:56 +0200
Date: Wed, 16 Apr 2003 13:57:56 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ashish anand <ashish.anand@inspiretech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: vmalloc cached space..
Message-ID: <20030416135756.B29679@linux-mips.org>
References: <200304160959.h3G9xVf6017958@smtp.inspirtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304160959.h3G9xVf6017958@smtp.inspirtek.com>; from ashish.anand@inspiretech.com on Wed, Apr 16, 2003 at 03:10:17PM +0530
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2003 at 03:10:17PM +0530, Ashish anand wrote:

> As vmalloc returns KSEG2 cached memory , 
> 1.can I use a volatile pointer to treat it as safe as uncached..?
> or

Volatile does not mean uncached.  Volatile means the C compiler should not
perform certain optimizations and is usually used for hardware accesses
that have side effects or variables that can be changed from some kind
of interrupt or signal handled and are also read by the main program.

> 2. i should use vmalloc_prot (size, PAGE_KERNEL_UNCACHED) in umap.c.

Uncached memory access is rarely necessary and so _extremly_ slow that it
should be avoided at almost any price.  Maybe you should describe what
you're trying to achieve, then let's see if there's a better suggestion
we can make.

  Ralf
