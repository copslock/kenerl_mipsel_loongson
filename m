Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 20:45:45 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:54871
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225923AbULAUpk>; Wed, 1 Dec 2004 20:45:40 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZbM1-0005Vb-00; Wed, 01 Dec 2004 21:45:37 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZbM0-0005Df-00; Wed, 01 Dec 2004 21:45:36 +0100
Date: Wed, 1 Dec 2004 21:45:36 +0100
To: Dominic Sweetman <dom@mips.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
	Nigel Stephens <nigel@mips.com>, David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16813.39660.948092.328493@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Dominic Sweetman wrote:
> 
> Thiemo writes:
> 
> > the atomic functions use so far memory references for the inline
> > assembler to access the semaphore. This can lead to additional
> > instructions in the ll/sc loop, because newer compilers don't
> > expand the memory reference any more but leave it to the assembler.
> > 
> > The appended patch...
> 
> I thought it was an explicit aim of the substantial rewrite of the
> MIPS backend for 3.x to get the compiler to generate only "real"
> instructions, not macros which expand to multiple instructions inside
> the assembler.  So it's disappointing if newer compilers got worse.

The compiler was improved with PIC code in mind. The kernel is
non-PIC, and can't allow explicit relocs by the compiler because
of the weird code model used for 64bit kernels. This led to some
degradation and even subtle failures for inline assembly code which
relies on assumptions about earlier compiler's behaviour.


Thiemo
