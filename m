Received:  by oss.sgi.com id <S553681AbRAKWxO>;
	Thu, 11 Jan 2001 14:53:14 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:36590 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553659AbRAKWxA>; Thu, 11 Jan 2001 14:53:00 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867046AbRAKWlp>; Thu, 11 Jan 2001 20:41:45 -0200
Date:	Thu, 11 Jan 2001 20:41:45 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Ian Chilton <ian@ichilton.co.uk>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Current CVS Kernel Broken on MIPS (010111 - 2.4.0)
Message-ID: <20010111204145.B894@bacchus.dhis.org>
References: <20010111224205.A2429@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111224205.A2429@woody.ichilton.co.uk>; from ian@ichilton.co.uk on Thu, Jan 11, 2001 at 10:42:05PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 11, 2001 at 10:42:05PM +0000, Ian Chilton wrote:

> I used the same GCC 2.95.2 + Binutils 2.10.1 that worked when compiling
> 001027.
> 
> This output was from an I2
> 
> Command Monitor.  Type "exit" to return to the menu.
> >> bootp():vmlinux console=ttyS0
> Setting $netaddr to 192.168.1.2 (from server scotty)
> Obtaining vmlinux from server scotty
>   \
> Exception: <vector=Normal>
> Status register: 0x10044803<CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x3000c01c<CE=3,IP8,IP7,EXC=DBE>
> Exception PC: 0x88141554, Exception RA: 0x881821d4
> Data Bus error GIO Timeout Interrupt
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
> Local I/O interrupt register 2: 0xca <EISA,SLOT0,SLOT1>
> GIO parity error register: 0x400<TIME>
> GIO bus error: address: 0x1000000
>   Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>   arg: a8740000 0 81009400 1000
>   tmp: a8740000 100a 81000000 881abe50 100a 1 9400 20
>   sve: a8740000 0 0 0 0 0 0 0
>   t8 a8740000 t9 0 at 0 v0 0 v1 0 k1 81000000
>   gp a8740000 fp 0 sp 0 ra 0

Such a pile of numbers is pretty useless for debuggin unless accompanied
with the disassembler listing of the crashing code, System.map or even
better the kernel binary itself ...

  Ralf
