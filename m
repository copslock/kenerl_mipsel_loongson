Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 21:35:40 +0000 (GMT)
Received: from p508B78BD.dip.t-dialin.net ([IPv6:::ffff:80.139.120.189]:32213
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225223AbTCMVfj>; Thu, 13 Mar 2003 21:35:39 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2DLZTb32464;
	Thu, 13 Mar 2003 22:35:29 +0100
Date: Thu, 13 Mar 2003 22:35:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Ranjan Parthasarathy <ranjanp@efi.com>
Cc: Richard Hodges <rh@matriplex.com>, linux-mips@linux-mips.org
Subject: Re: Disabling lwl and lwr instruction generation
Message-ID: <20030313223529.D30512@linux-mips.org>
References: <D9F6B9DABA4CAE4B92850252C52383AB07968241@ex-eng-corp.efi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <D9F6B9DABA4CAE4B92850252C52383AB07968241@ex-eng-corp.efi.com>; from ranjanp@efi.com on Thu, Mar 13, 2003 at 10:09:03AM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 13, 2003 at 10:09:03AM -0800, Ranjan Parthasarathy wrote:

> From the gcc sources, the compiler generates the lwl,lwr etc. in the block
> move code in gcc/config/mips/mips.c ( output_block_move ). 
> 
> There is an option -mmemcpy which tells gcc to use a memcpy compiled in
> with the sources for this block move instead of gcc genetrating code. The
> problem however with this is that arch/mips/lib/memcpy.S is optimized
> using lwl,lwr,swl,swr. If this can be  modified so that lwl,lwr,swl,swr
> is used if enabled as a kernel option, it might work very well. 

Replace those unaligned copies with a word-wise or even bytewise copying.
Not good for performance but ...

  Ralf
