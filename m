Received:  by oss.sgi.com id <S553797AbRAQMIB>;
	Wed, 17 Jan 2001 04:08:01 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:39177 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553758AbRAQMHj>;
	Wed, 17 Jan 2001 04:07:39 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 563747D11; Wed, 17 Jan 2001 12:07:37 +0000 (GMT)
Date:   Wed, 17 Jan 2001 12:07:37 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Cc:     macro@ds2.pg.gda.pl, ralf@oss.sgi.com
Subject: CVS Kernel Report - 010117 (2.4.0)
Message-ID: <20010117120737.B29202@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I tried booting my Indy yesturday, but with no root fs. Maciej asked me
to try changing something and give him some outputs.

My Indy is off, but my I2 is finished compiling, so I thought I would
try that. The root fs, I have just had booted with 2.4.0-test9 (001027)
with no problem.

My plan was:

Boot the kernel - post output, cpuinfo and iomem
Make DEBUG change, reboot and repost output, cpuinfo and iomem

However, I booted the I2, and got this:

Activating swap...Adding Swap: 64376k swap-space (priority -1)
[swapon:13] Illegal instruction 0000002c at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 00000040 at 88198008 ra=8814b208
[swapon:13] Illegal instruction 74747978 at 88198008 ra=8814b208
[â.ttyx.#.d.d:13] Illegal instruction 74747978 at 88198008 ra=8814b208
[â.ttyx.#.d.d:-2011578176] Illegal instruction 74747978 at 88198008
ra=8814b208
[â.ttyx.#.d.d:-2011483784] Illegal instruction 74747978 at 88198008
ra=8814b208




I am contating home now to get someone to hit the reset. I will boot
with the test9 and disable swap and carry on.

Consider this a bug report  :)


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |         Budget: A method for going broke methodically.          |
 \-----------------------------------------------------------------/
