Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 08:39:06 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:25441
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225074AbULBIjB>; Thu, 2 Dec 2004 08:39:01 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZmUN-0003uj-00; Thu, 02 Dec 2004 09:38:59 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZmUN-0007ul-00; Thu, 02 Dec 2004 09:38:59 +0100
Date: Thu, 2 Dec 2004 09:38:59 +0100
To: Dominic Sweetman <dom@mips.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Nigel Stephens <nigel@mips.com>, David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041202083859.GU3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl> <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de> <16814.52180.502747.597080@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16814.52180.502747.597080@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Dominic Sweetman wrote:
> 
> Thiemo,
> 
> > I had guessed you already know what i mean. :-)
> 
> Generally a bad guess, of course...
> 
> > Current 64bit MIPS kernels run in (C)KSEG0, and exploit sign-extension
> > to optimize symbol loads (2 instead of 6/7 instructions, the same as in
> > 32bit kernels).
> 
> Gross... yet ingenious. I see the problem.  You want to use a
> 32-bit-pointer "la" for the addresses of static variables in the
> kernel build (which works, because the kernel is in the
> 32-bit-pointer-accessible 'kseg0').

Except that the compiler emits a "dla", but the assembler expands
it like "la". :-)

> The assembler macro was a very Linux solution, if you don't mind my
> saying so...  A more native compiler fix would probably be a good
> idea.
> 
> What ABI are you using for the 64-bit kernel build (n64? how do you
> get it to build non-PIC?)

The ABIs are generally only defined for PIC code, the 64bit kernel uses
the n64 non-PIC alike. Building as non-PIC is simple, via
-mabi=64 -fno-PIC -mno-abicalls

> And what constraints are there on
> your choice of gcc version? - it would be easier if 3.4 was OK.

3.2/3.3 are known to work. 3.4 fails for yet unknown reason, I guess
either due to inline assembler changes or more agressive dead code
elimination.


Thiemo
