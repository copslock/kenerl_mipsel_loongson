Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9MKn4Z16052
	for linux-mips-outgoing; Mon, 22 Oct 2001 13:49:04 -0700
Received: from dea.linux-mips.net (a1as02-p219.stg.tli.de [195.252.185.219])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9MKn0D16049
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 13:49:00 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9MKmSH23032;
	Mon, 22 Oct 2001 22:48:28 +0200
Date: Mon, 22 Oct 2001 22:48:28 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Machida Hiroyuki <machida@sm.sony.co.jp>
Cc: alan@lxorguk.ukuu.org.uk, linux-mips@oss.sgi.com
Subject: Re: csum_ipv6_magic()
Message-ID: <20011022224828.A20032@dea.linux-mips.net>
References: <20011022151606V.machida@sm.sony.co.jp> <E15vZvr-000138-00@the-village.bc.nu> <20011022195619A.machida@sm.sony.co.jp> <20011022203324G.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011022203324G.machida@sm.sony.co.jp>; from machida@sm.sony.co.jp on Mon, Oct 22, 2001 at 08:33:24PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 22, 2001 at 08:33:24PM +0900, Machida Hiroyuki wrote:

> I found bugs in checksum.h. A sample fix is attached below.
> 
> I perfer to use generic csum_ipv6_magic() in net/checksum.h
> than this fix. Please someone show me improvements for this asm
> version of csum_ipv6_magic(). 

The C version should produce code that performs identically on MIPS.  As
such we have no good reason to keep the assembler version.

> * (csum_ipv6_magic): Have same paramter types as net/checksum.h.
>   Correct carry computation.  Add a final carry.

The len argument of that prototype should be __u32 because of IPv6
jumbograms.

  Ralf
