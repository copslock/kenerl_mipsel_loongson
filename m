Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 07:00:17 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:49432
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225208AbUKVHAI>; Mon, 22 Nov 2004 07:00:08 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CW8BD-00011a-00; Mon, 22 Nov 2004 08:00:07 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CW8BB-0001Mo-00; Mon, 22 Nov 2004 08:00:05 +0100
Date: Mon, 22 Nov 2004 08:00:04 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Improve o32 syscall handling
Message-ID: <20041122070003.GA902@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122061854.GA25433@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122061854.GA25433@linux-mips.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Nov 21, 2004 at 05:45:57PM +0100, Thiemo Seufer wrote:
> 
> > For the 64bit Kernel, it
> >  - checks for unaligned user stack
> 
> Why bother, the unaligned exception handler should take care of this.

It really does so for unaligned accesses from kernel space?

> >  - also allows now up to 8 arguments
> 
> Quite frankly I'd prefer to see this being handle in userspace.  For o32
> it's too late to go for that but for N32 / N64 we still may have a chance.

My changes are for O32 only. N32/N64 doesn't need more than 6 arguments.

> > -	LONG_L	a2, TI_FLAGS($28)	# current->work
> > +	lw	a2, TI_FLAGS($28)	# current->work
> 
> Flags is a long variable.

"long" isn't a quantity the assembler knows about. :-)

The whole assembler file for O32 support in 32bit Kernels makes only
sense when it is compiled as 32bit code. In that case, the C "long"
has 4 bytes and is loaded with lw. Using a macro which abstracts for
32/64bit compilation hides this needlessly, and can even lead to the
erraneous impression the code would be useful for 64bit, too.


Thiemo
