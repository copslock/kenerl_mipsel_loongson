Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 00:16:45 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:5468
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225218AbTHKXQk>; Tue, 12 Aug 2003 00:16:40 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19mLtz-00055o-00; Tue, 12 Aug 2003 01:16:35 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19mLtz-00067j-00; Tue, 12 Aug 2003 01:16:35 +0200
Date: Tue, 12 Aug 2003 01:16:35 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chip Coldwell <coldwell@frank.harvard.edu>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: load/store address overflow on binutils 2.14
Message-ID: <20030811231635.GB23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030810145425.GE22977@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.21.0308112257180.20421-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0308112257180.20421-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
[snip]
> > > Strangely, this is actually "correct" behavior.  Arguments on
> > > variable-length argument lists are implicitly "promoted" to unsigned
> > > int at the widest.  See K&R 2nd ed. A6.1 and A7.3.2.
> > 
> > Ugh. Thanks for pointing this out. I wasn't aware of it.
> > 
> > 	printf("%016Lx\n", ~a);
> > 
> > Produces the expected output. So it is actually an implementation
> > bug in binutils, which isn't fixable for 2.14 and earlier, because
> > those have to remain at K&R C level. The K&R requirement was only
> > recenly loosened.
> 
> How can it print the correct output if ~a is `promoted' to unsigned int, while
> you specify %Lx in the format string?

From 'info gcc':

Double-Word Integers
====================

   ISO C99 supports data types for integers that are at least 64 bits
wide, and as an extension GCC supports them in C89 mode and in C++.
[...]
   There may be pitfalls when you use `long long' types for function
arguments, unless you declare function prototypes.  If a function
expects type `int' for its argument, and you pass a value of type `long
long int', confusion will result because the caller and the subroutine
will disagree about the number of bytes for the argument.  Likewise, if
the function expects `long long int' and you pass `int'.  The best way
to avoid such problems is to use prototypes.


Thiemo
