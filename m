Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA2630815 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 16:49:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id QAA7075242
	for linux-list;
	Thu, 2 Apr 1998 16:47:56 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA6050576
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 16:47:54 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id QAA27376
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 16:47:53 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA21210
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Apr 1998 02:47:51 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA02701;
	Fri, 3 Apr 1998 02:47:32 +0200
Message-ID: <19980403024732.64164@uni-koblenz.de>
Date: Fri, 3 Apr 1998 02:47:32 +0200
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: serial console
References: <199804021731.TAA00404@calypso.saturn> <199804021855.NAA08562@pluto.npiww.com> <19980402204738.29605@uni-koblenz.de> <199804022006.PAA10227@pluto.npiww.com> <19980402233532.10932@uni-koblenz.de> <199804022316.PAA01989@fir.engr.sgi.com> <199804022353.SAA15219@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804022353.SAA15219@pluto.npiww.com>; from Dong Liu on Thu, Apr 02, 1998 at 06:53:46PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 02, 1998 at 06:53:46PM -0500, Dong Liu wrote:

>  >      For reduced user confusion, accepting "console=d" as an alias
>  > for "console=d1" might reduce user confusion.

Correct.

> Yes, but from arch/mips/sgi/setup.c
> 
> 	ctype = prom_getenv("console");
> 	serial_console = 0;
> 	if(*ctype == 'd') {
> 		if(*(ctype+1)=='2')
> 			serial_console = 1;
> 		else
> 			serial_console = 2;
> 		if(!serial_console) {
> 			prom_printf("Weird console env setting %s\n", ctype);
> 			prom_printf("Press a key to reboot.\n");
> 			prom_getchar();
> 			prom_imode();
> 		}
> 	}
> 
> It got it the wrong serial_console, "d2" means serial port 1, "d"
> means serial port 2.

Ooops.

> Any way, I think I found out why serial port doesn't work, con_init()
> call rs_cons_hook() before rs_init got called. 
> 
> But now I got another problem, I got the patch from
> ftp://zero.aec.at/pub/sgi-linux, using the same .config file from the
> same ftp site, I got
> 
> Exception: <vector=UTLB Miss>
> Status register: 0x30044803<CU1,CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
> Exception PC: 0x880ec7f0, Exception RA: 0x880f0294
> exception, bad address: 0x0
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
>   Saved user regs in hex (&gpda 0xa8740e08, &_regs 0xa8741008):
>   arg: 0 8bfffcae 8bfffc24 88107498
>   tmp: e 8813e5bc a 8811216c 100000 88100000 0 48
>   sve: 88121228 2 8813e570 4 4 1 88121220 9fc47a40
>   t8 48 t9 bfbd9833 at 4f v0 1 v1 88107498 k1 bad11bad
>   gp 8bf70000 fp 9fc47bac sp 8bfff840 ra 880f0294

Which looks similar to the Challenge S report recently posted to this
list, but not the same.

  Ralf
