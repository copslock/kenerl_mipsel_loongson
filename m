Received:  by oss.sgi.com id <S553798AbQJMSUn>;
	Fri, 13 Oct 2000 11:20:43 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:18694 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553795AbQJMSUb>;
	Fri, 13 Oct 2000 11:20:31 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id B67B97C75; Fri, 13 Oct 2000 19:20:29 +0100 (BST)
Date:   Fri, 13 Oct 2000 19:20:29 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: 2.4 Kernel Problem on Indy
Message-ID: <20001013192029.A27003@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

Just compiled the CVS 2.4 kernel from this morning, with egcs 1.0.3a, glibc 2.0.6 and binutils 2.8.1 (compiled nativly)

When I try to boot, it says this...something I have done wrong, or a kernel bug?
(the cvs 2.2 one I did at the same time works though :))

>> boot bootp():/vmlinux root=/dev/sda5             
130768+22320+3184+341792+48560d+4604+6816 entry: 0x8afa60d0
Obtaining /vmlinux from server slinky                      
  -                                  
Exception: <vector=UTLB Miss>
Status register: 0x10004802<CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL>
Cause register: 0x8008<CE=0,IP8,EXC=RMISS>                      
Exception PC: 0x88026f88, Exception RA: 0x8802a698
exception, bad address: 0xfffffffc                
Local I/O interrupt register 1: 0x80 <VR/GIO2>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: 88193f40 21 88009e24 3c                                 
  tmp: 4800 ffff00ff a 0 881a377e fffffff7 ffffffff 88009dbc
  sve: 881a3763 881a3763 0 0 88193f44 10004801 21 0         
  t8 a t9 0 at 10004800 v0 fffffff8 v1 0 k1 bad11bad
  gp 88008000 fp 88009d98 sp 88009d98 ra 8802a698   
                                                 
PANIC: Unexpected exception

[Press reset or ENTER to restart.]


Any ideas?
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
