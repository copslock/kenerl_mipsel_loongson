Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MBFSx14057
	for linux-mips-outgoing; Sun, 22 Jul 2001 04:15:28 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MBFRV14051
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 04:15:27 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id NAA30828
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 13:15:25 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15OHCn-0005mZ-00
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 13:15:25 +0200
Date: Sun, 22 Jul 2001 13:15:25 +0200
To: linux-mips@oss.sgi.com
Subject: Re: mips64 linker bug?
Message-ID: <20010722131525.L16278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007301c1129d$cdf908e0$0deca8c0@Ulysses>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell wrote:
[snip]
> > An Kernel with 64bit addresses is less compact and likely to run slower.
> > OTOH, a 64bit Kernel has certainly some hack value. :-)
> 
> Note that the 5Kc is one of the new generation of MIPS64 parts
> that can enable 64-bit integer and floating point instructions without
> requiring that 64-bit addressing also be enabled in the kernel.

Sorry, but I can't see what's new here. AFAICS this possibility existed
already in MIPS III.

> Making Linux kernel support for this capability available is
> one of the things that we're working on.  But it's not there yet.

I know. :-)


Thiemo
