Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HGH7V23028
	for linux-mips-outgoing; Tue, 17 Jul 2001 09:17:07 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HGH5V23025
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 09:17:05 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id SAA387329
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 18:17:03 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15MXWp-0001uu-00
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 18:16:55 +0200
Date: Tue, 17 Jul 2001 18:16:55 +0200
To: linux-mips@oss.sgi.com
Subject: Re: SUCCESS: Booting a real 64bit Kernel on Indigo2 R10000 (IP28)
Message-ID: <20010717181655.B3241@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010717052809.A1319@bacchus.dhis.org>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Sat, Jul 14, 2001 at 07:36:34PM +0200, Thiemo Seufer wrote:
> 
> > - A real 64bit Kernel image without linker crashes etc.
> >   No objcopy tricks, the Kernel is loaded at 0xa800000000000000.
> 
> Using the assembler in 32-bit mode results in better code also.

ITYM more compact and possibly faster. The 'faster' part depends
on what is done in the Kernel, since there are 64bit syscalls
it can't be true for everything. To the 'more compact' part:

text + data of my kernel is about 2.0 MB, including the standard
drivers for an I2 (except newport).

an roughly comparable kernel (2.4.3 from ftp.rfc822.org) which
supports newport but keeps some other things in modules needs
about 1.6 MB.

IMHO that's not too much difference, I2's aren't that low on memory.

Anyway, the Firmware of newer I2 does not load 32bit kernels, so
a 64bit Kernel is needed there.

> So
> while I came up with the objcopy trick as a way to kludge around the
> kernel bugs it has become the way of choice for the Origin.

How much is the performance difference there? Do you have some
estimates?

Supporting both sorts of kernels would require really ugly
ifdef'ing for most of the low-level assembly code.


Thiemo
