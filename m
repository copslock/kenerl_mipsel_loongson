Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA1116335 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 14:09:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA21462 for linux-list; Thu, 11 Dec 1997 14:07:11 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA21334 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 14:06:49 -0800
Received: from otto.artcom.de (schleuse-inx-bt.artcom.de [195.21.176.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id OAA29777
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 14:06:45 -0800
	env-from (NOSPAMkaro@artcom.net)
Received: from artcom.net by otto.artcom.de with smtp
	id m0xgGhy-009tQ7C; Thu, 11 Dec 97 23:03 MET
Message-ID: <34906346.C1FB7311@artcom.net>
Date: Thu, 11 Dec 1997 23:03:50 +0100
From: Benjamin Pannier <NOSPAMkaro@artcom.net>
Reply-To: karo@artcom.net
Organization: ART+COM
X-Mailer: Mozilla 4.04 [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: ralf@uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Uploads ...
References: <19971208150602.52582@brian.uni-koblenz.de> <ralf@uni-koblenz.de> <9712091934.ZM3116@mdhill.interlog.com> <19971210040210.27443@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de wrote:
> 
> On Tue, Dec 09, 1997 at 07:34:21PM -0500, Michael Hill wrote:
> 
> > Thanks for the kernel binary.  Unfortunately it quits in the same spot as the
> > previous kernel I tried (the R4600 V2.0 problem).  You said you had a stable
> > kernel on the SNI RM200.  This time I used the Indy kernel; should I try the
> > rm200 kernel?
> 
> If your have a RM200 ...
> 
> Is it still that bus error message you get?  If so, could you please mail
> me the register dump displayed on the screen.

vmlinux-indy-2.1.67:

ARCH: SGI-IP22 
CPU: MIPS-4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
Loading R4000 MMU routines
CPU revision is: 00002020
...
Stating kswapd v1.23
SGI Zilog8530 serialdriver V1.00
tty00 at 0xbfbd9838 (irq = 21) is Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is Zilog8530
loop: registered device at major 7
Got a bus error IRQ, shouldn't ...
$0 : 00000000 1000fc01 88130000 00000000
$4 : 88174274 8812cb10 8fff1cd8 00000001
$8 : 1000fc03 00000201 0000ffe5 8813de68
$12: 00000001 00000001 00000001 fffffffc
$16: 0000c000 8ffe5000 00000000 00000000
$20: a8747330 9fc47a40 00000000 9fc47a40
$24: 1000fc01 0000000f
$2:  00000000 8fff1cb8 9fc47bac 8800b0e8
epc: 880359f8
status: 1000fc03
cause: 00004000
Spinning...

-karo

-- 
  __/__/__/\ Benjamin Pannier,ART+COM GmbH,BudapesterStr44,D-10787Berlin
 __/__/__/\/ Tel:(+49-30)25417-3 Fax:(+49-30)25417-555
__/__/__/\/ Email:karo@artcom.net WWW:http://www.artcom.net/~karo/ 
__\__\__\/ Email:karo@artcom.org me@karo.org i.am@ka.ro karo@artcom.de
