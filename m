Received:  by oss.sgi.com id <S553760AbQK2RRm>;
	Wed, 29 Nov 2000 09:17:42 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:1031 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553671AbQK2RRM>;
	Wed, 29 Nov 2000 09:17:12 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 061127CD8; Wed, 29 Nov 2000 17:17:09 +0000 (GMT)
Date:   Wed, 29 Nov 2000 17:17:09 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     Jesse Dyson <jesse@winston-salem.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel Boot Hard Locks Indigo 2
Message-ID: <20001129171709.A21825@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> However, after the kernel has loaded the machine hard locks.


Where did you get the kernel from?

We have a known issue with the CVS versions of GCC....it seems that
when you compile a 2.4 kernel with this, it works on the Indy, but
won't boot on the I2...it hangs when initialising the serial console.

Compiling the same kernel with egcs-1.1.2 works OK on both the Indy and
I2...


You can get known working kernels for the Indy and I2 in:

ftp://download.ichilton.co.uk/pub/ichilton/linux-mips/kernels)
(or  http://download.ichilton.co.uk/linux-mips/kernels/)

For 2.2.14, there are separate kernels for the I2 and Indy (the I2 one
has EISA enabled).

For 2.4-test11, the same kernel works on both.


Bye for Now,

Ian

                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |        Proofread carefully to see if you any words out.         |
 \-----------------------------------------------------------------/
