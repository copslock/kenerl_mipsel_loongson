Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8KKVD31200
	for linux-mips-outgoing; Thu, 8 Nov 2001 12:20:31 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8KKS031178;
	Thu, 8 Nov 2001 12:20:28 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8KKKjV023111;
	Thu, 8 Nov 2001 12:20:20 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8KKK49023107;
	Thu, 8 Nov 2001 12:20:20 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 8 Nov 2001 12:20:20 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: i8259.c in big endian
In-Reply-To: <20011108121348.A26083@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.10.10111081217220.13456-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > Also I like to see away to pass in a base offset. I have a mips device
> > which has a i8259 chip but its io is offseted by 0xb0000000.
> 
> Then it's almost certainly an legacy ISA device with it's ports in ISA space,
> so set mips_io_port_base to an apropriate value or does that not work for
> you?

The mips_io_port_base is 0xa0000000. Whereas the i8259 chip is at
0xb0000000. The 0xa000000 value could be wrong. I will give it a try. 
