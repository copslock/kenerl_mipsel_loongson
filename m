Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VD8W926127
	for linux-mips-outgoing; Tue, 31 Jul 2001 06:08:32 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VD8VV26121
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 06:08:31 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id PAA94638
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 15:08:29 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15RZG9-00008W-00
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 15:08:29 +0200
Date: Tue, 31 Jul 2001 15:08:29 +0200
To: linux-mips@oss.sgi.com
Subject: Re: r4600 flag
Message-ID: <20010731150829.O27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006901c119b5$ac8ecfe0$0deca8c0@Ulysses>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell wrote:
[snip]
> > `-mcpu=CPU TYPE'
> >      Assume the defaults for the machine type CPU TYPE when scheduling
> >      instructions.  The choices for CPU TYPE are `r2000', `r3000',
> >      `r3900', `r4000', `r4100', `r4300', `r4400', `r4600', `r4650',
> >      `r5000', `r6000', `r8000', and `orion'.  Additionally, the
> >      `r2000', `r3000', `r4000', `r5000', and `r6000' can be abbreviated
> >      as `r2k' (or `r2K'), `r3k', etc.  While picking a specific CPU
> >      TYPE will schedule things appropriately for that particular chip,
> >      the compiler will not generate any code that does not meet level 1
> >      of the MIPS ISA (instruction set architecture) without a `-mipsX'
> >      or `-mabi' switch being used.
> 
> In that case, the tools that I've been using are technically
> broken.  Surprise surprise.   Because -mcpu=4600 is
> most assuredly setting the ISA level, even if it doesn't
> override one explicitly set!

gas and gcc have different meanings for this option, gas uses the
cpu's default ISA (if none specified) while gcc uses MIPS I.
In current binutils/gcc CVS, there was -march and -mtune introduced
as a replacement for -mcpu and -m<cpu>, which were kept for backward
compatibility only.

[snip]
> > No MAD on R4600.  Again it would be in contradiction with above document-
> > ation.  Mad you get with:
> 
> Right.  Sorry.  I got the 4600 and 4650 confused.  I no longer
> understand why "4600" and not "4650" is the model for MIPS32.

At least for the CVS binutils gas it is Generic-MIPS32, not 4600.


Thiemo
