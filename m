Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0PMpNi09859
	for linux-mips-outgoing; Fri, 25 Jan 2002 14:51:23 -0800
Received: from holomorphy (mail@holomorphy.com [216.36.33.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0PMpIP09837
	for <linux-mips@oss.sgi.com>; Fri, 25 Jan 2002 14:51:18 -0800
Received: from wli by holomorphy with local (Exim 3.33 #1 (Debian))
	id 16UEGP-0008SQ-00; Fri, 25 Jan 2002 13:52:01 -0800
Date: Fri, 25 Jan 2002 13:52:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jason Gunthorpe <jgg@debian.org>
Cc: Phil Thompson <phil@river-bank.demon.co.uk>, linux-mips@oss.sgi.com
Subject: Re: Generic DISCONTIGMEM Support on 32bit MIPS
Message-ID: <20020125135201.I872@holomorphy.com>
References: <3C51838A.174F8712@river-bank.demon.co.uk> <Pine.LNX.3.96.1020125141828.5657B-100000@wakko.deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.3.96.1020125141828.5657B-100000@wakko.deltatee.com>; from jgg@debian.org on Fri, Jan 25, 2002 at 02:20:33PM -0700
Organization: The Domain of Holomorphy
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 25 Jan 2002, Phil Thompson wrote:
>> The first question is: has anybody already done this? Particularly as,
>> once you've identified where the holes are, the code isn't board
>> specific.

On Fri, Jan 25, 2002 at 02:20:33PM -0700, Jason Gunthorpe wrote:
> Is this of any help?
> http://kt.zork.net/kernel-traffic/kt20011112_141.html#6
> William Irwin [*] announced:
> A number of people have expressed a wish to replace the bitmap-based
> bootmem allocator with one that tracks ranges explicitly. I have written
> such a replacement in order to deal with some of the situations I have
> encountered. 
> [...]

I ran into some code acceptance issues in three places:
(1) I used trees
(2) I didn't go about changing the arch-specific code to
	actually simplify the calling sequence as it appeared
	in arch-specific code.
(3) it is a whole-hog rewrite of bootmem.c, which perhaps attracted
	flak from the original author

The last bits of this I released are in:
	ftp://ftp.kernel.org/pub/linux/kernel/people/wli/bootmem/

I'm not sure it addresses all the issues that arise here -- largely
it just avoids some code complexity in laying out the bootmem bitmaps.

DISCONTIGMEM as I understand it just minimally adjusts the core bootmem
so it can handle things at all, and then focuses on the actual hard
parts needed for things to work well on larger systems.

(Of course, that's an extremely vague description of the difference, but
I won't go about reciting featuresets aside from this high-level stuff.)

Cheers,
Bill
