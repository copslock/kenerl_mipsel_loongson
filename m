Received:  by oss.sgi.com id <S42255AbQGSDYS>;
	Tue, 18 Jul 2000 20:24:18 -0700
Received: from mail.rpi.alumlink.com ([207.92.136.80]:30227 "EHLO
        mail.alum.rpi.edu") by oss.sgi.com with ESMTP id <S42235AbQGSDXm>;
	Tue, 18 Jul 2000 20:23:42 -0700
Date:   Tue, 18 Jul 2000 23:23:22 -0400
Message-Id: <200007182323.AA145031220@mail.alum.rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From:   "clemej" <clemej@mail.alum.rpi.edu>
Reply-To: <clemej@mail.alum.rpi.edu>
To:     <linux-mips@oss.sgi.com>
Subject: Re: Okay, lost
X-Mailer: <IMail v6.03>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


When I was bitten by the infamous '-N' bug, it seems to me the 
exception I got said "UTLB" in it somewhere.  This one doesn't.
So maybe that's not the problem.

And I think I might be being bitten by the same thing.  All 2.4 
kernels I've tried die with what seems to be a similar error on 
my Indigo2 (R4400 200Mhz).  I thought I read somewhere something 
about XZ graphics causing problems and boards should be 
removed... why? Could this be the cause? I have XZ in my 
machine.... I want to try a few more things before sounding too 
many alarms though...

john.c
- --
John Clemens
clemens@alum.rpi.edu


---------- Original Message ----------------------------------
From:   Ralf Baechle <ralf@oss.sgi.com>
Date:   Tue, 18 Jul 2000 05:23:09 +0200

>On Mon, Jul 17, 2000 at 08:53:03PM -0500, A. Wrasman wrote:
>
>> Okay, I can't seem to get any of the pre-compiled linux kernels  after the 2.2.14 one on oss.sgi.com to boot on my Indy.
>> 
>> I get this type of error:
>> Exception: <vector=Normal>
>> Status register: 0x10044803<CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
>> Cause register: 0x8034<CE=0,IP8,EXC=TRAP>
>> Exception PC: 0x88240004, Exception RA: 0x8816d610
>> Processor Trap exception at address 0xffffffff
>> Local I/O interrupt register 1: 0x80 <VR/GIO2>
>> 	Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>> 	arg: a8740000 28 8847ff80 a
>> 	tmp: a8740000 8480 88002000 8480 881932a0 1 fffffffc 47dfa8
>> 	sve: a8740000 0 0 0 0 0 0 0
>> 	t8 a8740000 t9 0 at 0 v0 0 v1 0 k1 88002000
>> 	gp a8740000 fp 0 sp 0 ra 0
>> 
>> PANIC: unexpected exception
>
>Now that looks like a kernel compiled by somebody who doesn't read
>documentation, see http://oss.sgi.com/mips/mips-howto.html.  In short:
>remove the -N linker flag from arch/mips/Makefile.
>
>  Ralf
>
