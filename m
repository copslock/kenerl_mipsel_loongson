Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f355C9J05563
	for linux-mips-outgoing; Wed, 4 Apr 2001 22:12:09 -0700
Received: from dea.waldorf-gmbh.de (u-109-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.109])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f355BjM05556
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 22:11:58 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3558VZ11841;
	Thu, 5 Apr 2001 07:08:31 +0200
Date: Thu, 5 Apr 2001 07:08:31 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Fredrickson <matt@frednet.dyndns.org>
Cc: jsc6233@ritvax.isc.rit.edu, linux-mips@oss.sgi.com
Subject: Re: your mail
Message-ID: <20010405070831.A11613@bacchus.dhis.org>
References: <5.0.0.25.0.20010404172906.00a4bce8@vmspop.isc.rit.edu> <20010404163747.A22469@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010404163747.A22469@frednet.dyndns.org>; from matt@frednet.dyndns.org on Wed, Apr 04, 2001 at 04:37:47PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 04:37:47PM -0500, Matthew Fredrickson wrote:

> > hello,
> > Yeah i am trying to compile it while running Irix 6.5. Once i get it all 
> > working I was going to boot into it. Does that make sense?
> > james
> 
> <g>No offense, but not really.  Actually, you'll probably need to start
> off by setting up the x86-mips cross compilers on an x86 linux machine of
> yours and booting the kernel via tftp over the network to get started.  I
> think most of this is covered in the FAQ on the site.  Anyway, I don't
> think it's _ever_ been supported to compile up the kernel in IRIX anyway,
> so your kind of out of luck for that.

You obvious didn't even check.  I assure you that I rarely compile a MIPS
kernel under Linux so if that works, it's coincidental.  Crosscompiling
on IRIX works just fine.

  Ralf
