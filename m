Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GHnaW03118
	for linux-mips-outgoing; Thu, 16 Aug 2001 10:49:36 -0700
Received: from dea.waldorf-gmbh.de (u-171-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.171])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GHnWj03115
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 10:49:33 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7GGEJG31124;
	Thu, 16 Aug 2001 18:14:19 +0200
Date: Thu, 16 Aug 2001 18:14:19 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Murphy <brian.murphy@eicon.com>, linux-mips@oss.sgi.com
Subject: Re: glibc
Message-ID: <20010816181419.B30997@bacchus.dhis.org>
References: <3B7B8951.B666A175@eicon.com> <E15XNl1-0005C7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15XNl1-0005C7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 16, 2001 at 03:04:23PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 16, 2001 at 03:04:23PM +0100, Alan Cox wrote:

> > We use 2.0.6 here because it is half the size of the newer glibcs and it
> > seems to work fine for us.
> 
> It trust someone patched the holes in it for things like DNS lookups ?

The latest glibc 2.0.6 I was spreading only has MIPS-specific bug fixes.
All the other big holes which are indeed big enough to drive a nice shipload
of trucks through are unfixed.  I haven't noticed that any other glibc
2.0 variant floating around has additional fixes.

Nice for Cobalt boxen ...

  Ralf
