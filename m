Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3HGmf715857
	for linux-mips-outgoing; Tue, 17 Apr 2001 09:48:41 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3HGmaM15836
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 09:48:37 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3HGWpU07508;
	Tue, 17 Apr 2001 13:32:51 -0300
Date: Tue, 17 Apr 2001 13:32:51 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Link problems with 2.4.3 kernel
Message-ID: <20010417133251.B7177@bacchus.dhis.org>
References: <3ADB5181.BCE02A9@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADB5181.BCE02A9@cotw.com>; from samcconn@cotw.com on Mon, Apr 16, 2001 at 01:09:37PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 16, 2001 at 01:09:37PM -0700, Scott A McConnell wrote:

> No matter what I do I can not get _ftext to appear at 80001000. I use
> identical ld.scripts for bother kernels.
> At first I thought it was my binutils so I switched to the same tools
> that I used with my 2.4.0-test5 kernel.
> 
> Addresses appear to be off by 0x1000.  Which is why my 2.4.3 kernel dies
> on the jump to init_arch out of kernel_entry.
> 
> Any thoughts about what I might be doing wrong?

Thinking you can change the address to 0x80001000.  .text needs 8kb
aligment for 32-bit kernels, 16kb for 64-bit.

  Ralf
