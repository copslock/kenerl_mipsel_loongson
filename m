Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8LrLO08684
	for linux-mips-outgoing; Thu, 8 Nov 2001 13:53:21 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8LrH008680;
	Thu, 8 Nov 2001 13:53:17 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8Lr9jV028643;
	Thu, 8 Nov 2001 13:53:09 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8Lr8JU028639;
	Thu, 8 Nov 2001 13:53:08 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 8 Nov 2001 13:53:07 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
In-Reply-To: <Pine.LNX.4.10.10111081331170.13456-100000@transvirtual.com>
Message-ID: <Pine.LNX.4.10.10111081348000.13456-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > > The mips_io_port_base is 0xa0000000. Whereas the i8259 chip is at
> > > 0xb0000000. The 0xa000000 value could be wrong. I will give it a try. 
> > 
> > As your board must have RAM at physical address zero 0xa0000000 is almost
> > certainly a wrong value.
> 
> Your right. The address of 0xb000000 is bogus. This is the value from the
> old code. I will migrate the code over to the i8259.c stuff now. Thanks. 

Actually looking threw other mips branches now I see what the 0xb000000
is. It is the isa_port_base. 
