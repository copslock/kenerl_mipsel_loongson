Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8Lbne08035
	for linux-mips-outgoing; Thu, 8 Nov 2001 13:37:49 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8Lbk008031;
	Thu, 8 Nov 2001 13:37:46 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8LbcjV027651;
	Thu, 8 Nov 2001 13:37:38 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8LbbUm027644;
	Thu, 8 Nov 2001 13:37:37 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 8 Nov 2001 13:37:36 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: i8259.c in big endian
In-Reply-To: <20011108124119.B26083@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.10.10111081331170.13456-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > The mips_io_port_base is 0xa0000000. Whereas the i8259 chip is at
> > 0xb0000000. The 0xa000000 value could be wrong. I will give it a try. 
> 
> As your board must have RAM at physical address zero 0xa0000000 is almost
> certainly a wrong value.

Your right. The address of 0xb000000 is bogus. This is the value from the
old code. I will migrate the code over to the i8259.c stuff now. Thanks. 
