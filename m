Received:  by oss.sgi.com id <S553810AbQKRMPX>;
	Sat, 18 Nov 2000 04:15:23 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:33553 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553779AbQKRMPM>;
	Sat, 18 Nov 2000 04:15:12 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 771A17CF8; Sat, 18 Nov 2000 12:15:10 +0000 (GMT)
Date:   Sat, 18 Nov 2000 12:15:10 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Wierd Boot Problem
Message-ID: <20001118121510.A28176@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am currently cross-compiling 2.4 cvs kernels with different versions
of GCC, to find out when GCC broke...

I now have a few kernels here, all of which boot find on my Indy R4600

However, none of them will boot on my I2.

Obtaining /vmlinux from server slinky
  /                                  

Every time I try it, and with which ever kernel I use, the cursor
always stops spinning at the same point...

If I try a 2.2.14 kernel, it works fine, but when I try a 2.4 kernel
(same ones that boot on the Indy), it fails as above.

I have had the I2 booted on a 2.4 kernel before, but it was an older
2.4test9 kernel, and it was nativly compiled instead of cross-compiled.

Any ideas?


Thanks!


Bye for Now,

Ian

                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |       I used up all my sick days, so I'm calling in dead.       |
 \-----------------------------------------------------------------/
