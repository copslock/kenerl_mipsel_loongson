Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBFNrRt28086
	for linux-mips-outgoing; Sat, 15 Dec 2001 15:53:27 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.28.122.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBFNrNo28074
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 15:53:23 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 65E4A7CF5; Sat, 15 Dec 2001 22:53:16 +0000 (GMT)
Date: Sat, 15 Dec 2001 22:53:16 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: Guido Guenther <guido.guenther@gmx.net>
Cc: linux-mips@oss.sgi.com
Subject: I2 wont boot current kernel, Indy will.
Message-ID: <20011215225316.B1879@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20011215113050.GA13030@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <20011215113050.GA13030@bogon.ms20.nix>; from guido.guenther@gmx.net on Sat, Dec 15, 2001 at 12:30:50PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Guido,

I tried with a fresh current cvs tree and applied your
newport_vs_i2.diff straight from the e-mail, but
still get the same on the I2:

>> bootp():/vmlinux                                 
Setting $netaddr to 192.168.0.13 (from server )
Obtaining /vmlinux from server                 
  |                         

[stops]


Tried it on the Indy and it works (Same kernel, same boot server etc)


Maybe it's a gcc 3 bug?   I still have not got round to compiling an
older toolchain.


Any other ideas?


Thanks

Ian
