Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8Kg2u04964
	for linux-mips-outgoing; Thu, 8 Nov 2001 12:42:02 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fA8Kfx004957
	for <linux-mips@oss.sgi.com>; Thu, 8 Nov 2001 12:41:59 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA8KfJg26540;
	Thu, 8 Nov 2001 12:41:19 -0800
Date: Thu, 8 Nov 2001 12:41:19 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: i8259.c in big endian
Message-ID: <20011108124119.B26083@dea.linux-mips.net>
References: <20011108121348.A26083@dea.linux-mips.net> <Pine.LNX.4.10.10111081217220.13456-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111081217220.13456-100000@transvirtual.com>; from jsimmons@transvirtual.com on Thu, Nov 08, 2001 at 12:20:20PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 08, 2001 at 12:20:20PM -0800, James Simmons wrote:

> > > which has a i8259 chip but its io is offseted by 0xb0000000.
> > 
> > Then it's almost certainly an legacy ISA device with it's ports in ISA space,
> > so set mips_io_port_base to an apropriate value or does that not work for
> > you?
> 
> The mips_io_port_base is 0xa0000000. Whereas the i8259 chip is at
> 0xb0000000. The 0xa000000 value could be wrong. I will give it a try. 

As your board must have RAM at physical address zero 0xa0000000 is almost
certainly a wrong value.

  Ralf
