Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Aug 2003 15:54:34 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:6486
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225202AbTHJOya>; Sun, 10 Aug 2003 15:54:30 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19lraT-0002ig-00; Sun, 10 Aug 2003 16:54:25 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19lraT-00012G-00; Sun, 10 Aug 2003 16:54:25 +0200
Date: Sun, 10 Aug 2003 16:54:25 +0200
To: Chip Coldwell <coldwell@frank.harvard.edu>
Cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
Message-ID: <20030810145425.GE22977@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030810120844.GB22977@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.44.0308101032240.16702-100000@frank.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308101032240.16702-100000@frank.harvard.edu>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Chip Coldwell wrote:
[snip]
> >         printf("%016x\n", ~a);
> > 
> >         return 0;
> > }
> > 
> > outputs
> > 
> > 00000000ffffffff
> > 
> > on my i386-linux system.
> 
> Strangely, this is actually "correct" behavior.  Arguments on
> variable-length argument lists are implicitly "promoted" to unsigned
> int at the widest.  See K&R 2nd ed. A6.1 and A7.3.2.

Ugh. Thanks for pointing this out. I wasn't aware of it.

	printf("%016Lx\n", ~a);

Produces the expected output. So it is actually an implementation
bug in binutils, which isn't fixable for 2.14 and earlier, because
those have to remain at K&R C level. The K&R requirement was only
recenly loosened.


Thiemo
