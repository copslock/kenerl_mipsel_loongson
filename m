Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5G2FAY31704
	for linux-mips-outgoing; Fri, 15 Jun 2001 19:15:10 -0700
Received: from dea.waldorf-gmbh.de (u-5-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5G2F7k31700
	for <linux-mips@oss.sgi.com>; Fri, 15 Jun 2001 19:15:08 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5G2Et819919;
	Sat, 16 Jun 2001 04:14:55 +0200
Date: Sat, 16 Jun 2001 04:14:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.5 in cvs - Did anyone try ?
Message-ID: <20010616041455.A19841@bacchus.dhis.org>
References: <20010615210433.A4282@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010615210433.A4282@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Jun 15, 2001 at 09:04:33PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jun 15, 2001 at 09:04:33PM +0200, Florian Lohoff wrote:

> i am  just trying 2.4.5 on an Indy and i have no luck. The kernel
> gets confused very fast on the root ext2 filesystem the 2.4.3 continues
> to boot from. It is spitting our "EXT2: Bit already set for inode x"
> and hangs in a tight loop.

There was a stupid braino in include/asm-mips/bitops.h, make sure you
have revision 1.16 of that file.

  Ralf
