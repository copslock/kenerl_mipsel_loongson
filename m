Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2708598 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 15:40:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA7111670
	for linux-list;
	Thu, 2 Apr 1998 15:38:41 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA6580349;
	Thu, 2 Apr 1998 15:38:34 -0800 (PST)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id PAA01567; Thu, 2 Apr 1998 15:38:33 -0800 (PST)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id SAA11236; Thu, 2 Apr 1998 18:47:08 -0500
Date: Thu, 2 Apr 1998 18:53:46 -0500
Message-Id: <199804022353.SAA15219@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: serial console
In-Reply-To: <199804022316.PAA01989@fir.engr.sgi.com>
References: <199804021731.TAA00404@calypso.saturn>
	<199804021855.NAA08562@pluto.npiww.com>
	<19980402204738.29605@uni-koblenz.de>
	<199804022006.PAA10227@pluto.npiww.com>
	<19980402233532.10932@uni-koblenz.de>
	<199804022316.PAA01989@fir.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

William J. Earl writes:
 > ralf@uni-koblenz.de writes:
 >  > On Thu, Apr 02, 1998 at 03:06:21PM -0500, Dong Liu wrote:
 >  > 
 >  > > Ok, I got a serial cable , connect it, type "nvram console d", now I
 >  > > can boot irix from a serial terminal, but for linux, the message
 >  > > didn't come out, maybe all the serial parameters are not set right.
 >  > 
 >  > Linux doesn't accept the value ``dd'' for the console variable.  If you
 >  > try, Linux should complain about the setting and enter the interactive
 >  > firmware mode again.  Could you try setting console to either d1 or d2
 >  > according to the serial line you're using?
 > 
 >      For reduced user confusion, accepting "console=d" as an alias
 > for "console=d1" might reduce user confusion.
 > 

Yes, but from arch/mips/sgi/setup.c

	ctype = prom_getenv("console");
	serial_console = 0;
	if(*ctype == 'd') {
		if(*(ctype+1)=='2')
			serial_console = 1;
		else
			serial_console = 2;
		if(!serial_console) {
			prom_printf("Weird console env setting %s\n", ctype);
			prom_printf("Press a key to reboot.\n");
			prom_getchar();
			prom_imode();
		}
	}

It got it the wrong serial_console, "d2" means serial port 1, "d"
means serial port 2.

Any way, I think I found out why serial port doesn't work, con_init()
call rs_cons_hook() before rs_init got called. 

But now I got another problem, I got the patch from
ftp://zero.aec.at/pub/sgi-linux, using the same .config file from the
same ftp site, I got

Exception: <vector=UTLB Miss>
Status register: 0x30044803<CU1,CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
Exception PC: 0x880ec7f0, Exception RA: 0x880f0294
exception, bad address: 0x0
Local I/O interrupt register 1: 0x80 <VR/GIO2>
  Saved user regs in hex (&gpda 0xa8740e08, &_regs 0xa8741008):
  arg: 0 8bfffcae 8bfffc24 88107498
  tmp: e 8813e5bc a 8811216c 100000 88100000 0 48
  sve: 88121228 2 8813e570 4 4 1 88121220 9fc47a40
  t8 48 t9 bfbd9833 at 4f v0 1 v1 88107498 k1 bad11bad
  gp 8bf70000 fp 9fc47bac sp 8bfff840 ra 880f0294

PANIC: Unexpected exception

[Press reset or ENTER to restart.]

So I can't compile the kernel my self:=(.

Dong
