Received:  by oss.sgi.com id <S553852AbRAJVOE>;
	Wed, 10 Jan 2001 13:14:04 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:62470 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553724AbRAJVNn>;
	Wed, 10 Jan 2001 13:13:43 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 7E71C7CF5; Wed, 10 Jan 2001 21:13:41 +0000 (GMT)
Date:   Wed, 10 Jan 2001 21:13:41 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: R4X00 Kernel
Message-ID: <20010110211341.A26347@woody.ichilton.co.uk>
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

I just compiled a kernel with my new toolchain...

I it using gcc 2.95.2 + binutils 2.10.1 and the kernel from today's cvs
(10/01/01) which is just after Ralf checked in test12...


08:58PM <quintela> Exception: <vector=Normal>
08:58PM <quintela> Status register:
0x10044803<CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
08:58PM <quintela> Cause register: 0x3000c000<CE=3,IP8,IP7,EXC=INT>
08:58PM <quintela> Exception PC: 0x8814c7b4
08:58PM <quintela> Interrupt exception
08:58PM <quintela> CPU Parity Error Interrupt
08:58PM <quintela> Local I/O interrupt register 2: 0xc8
<EISA,SLOT0,SLOT1>
08:58PM <quintela> CPU parity error register: 0x302<B1,MEM_PAR>
08:59PM <quintela> CPU parity error: address: 0xa572f88
08:59PM <quintela>   Saved user regs in hex (&gpda 0xa8740e48, &_regs
0xa8741048):
08:59PM <quintela>   arg: 8a572fc0 0 2530044 881d8000
08:59PM ð penguin42/#mipslinux has sore fingers
08:59PM <Spock> Opening an Indy is easy
08:59PM <quintela>   tmp: 4 8ad30040 1000 0 0 881b591f fffffff6
ffffffff
08:59PM <quintela>   sve: 8ad31 88800000 881bb280 8ad31 1 2530044 20 1
08:59PM <quintela>   t8 88009dd5 t9 a at 10044800 v0 88800000 v1 0 k1
bad11bad
08:59PM <quintela>   gp 88008000 fp 1f sp 88009e70 ra 881921ec
08:59PM <quintela>
08:59PM <quintela> PANIC: Unexpected exception
08:59PM <quintela>
08:59PM <quintela> [Press reset or ENTER to restart.]


This is on an I2..


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
 |         Budget: A method for going broke methodically.          |
 \-----------------------------------------------------------------/
