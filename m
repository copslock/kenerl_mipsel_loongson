Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9NBJDQ01718
	for linux-mips-outgoing; Tue, 23 Oct 2001 04:19:13 -0700
Received: from dea.linux-mips.net (a1as16-p134.stg.tli.de [195.252.192.134])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9NBJ9D01714
	for <linux-mips@oss.sgi.com>; Tue, 23 Oct 2001 04:19:09 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9NBIno12898;
	Tue, 23 Oct 2001 13:18:49 +0200
Date: Tue, 23 Oct 2001 13:18:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Machida Hiroyuki <machida@sm.sony.co.jp>
Cc: alan@lxorguk.ukuu.org.uk, linux-mips@oss.sgi.com
Subject: Re: csum_ipv6_magic()
Message-ID: <20011023131849.B12848@dea.linux-mips.net>
References: <20011022195619A.machida@sm.sony.co.jp> <20011022203324G.machida@sm.sony.co.jp> <20011022224828.A20032@dea.linux-mips.net> <20011023140722J.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011023140722J.machida@sm.sony.co.jp>; from machida@sm.sony.co.jp on Tue, Oct 23, 2001 at 02:07:22PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 23, 2001 at 02:07:22PM +0900, Machida Hiroyuki wrote:

> > > * (csum_ipv6_magic): Have same paramter types as net/checksum.h.
> > >   Correct carry computation.  Add a final carry.
> > 
> > The len argument of that prototype should be __u32 because of IPv6
> > jumbograms.
> 
> I suppose csum_ipv6_magic() in include/net/checksum.h should have __u32
> len. Please update include/net/checksum.h to avoid confusion.

Will do.

  Ralf
