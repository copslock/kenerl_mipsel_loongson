Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEIRnQ05503
	for linux-mips-outgoing; Fri, 14 Dec 2001 10:27:49 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.28.122.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEIRko05500
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 10:27:46 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id CB4997CF5; Fri, 14 Dec 2001 17:27:39 +0000 (GMT)
Date: Fri, 14 Dec 2001 17:27:39 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: linux-mips@oss.sgi.com
Subject: Current Kernel in CVS Broken
Message-ID: <20011214172739.A28669@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

2.4 cvs broken

mips-linux-gcc -I /home/ian/tmp/i2/linux/include/asm/gcc -D__KERNEL__
-I/home/ian/tmp/i2/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap
-pipe    -c -o ip22-setup.o ip22-setup.c
ip22-setup.c: In function `sgi_request_irq':
ip22-setup.c:64: `SGI_KEYBD_IRQ' undeclared (first use in this
function)
ip22-setup.c:64: (Each undeclared identifier is reported only once
ip22-setup.c:64: for each function it appears in.)
make[1]: *** [ip22-setup.o] Error 1
make[1]: Leaving directory `/home/ian/tmp/i2/linux/arch/mips/sgi-ip22'
make: *** [_dir_arch/mips/sgi-ip22] Error 2


Ian
