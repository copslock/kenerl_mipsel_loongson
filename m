Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6M8rbRw016523
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 01:53:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6M8rbor016522
	for linux-mips-outgoing; Mon, 22 Jul 2002 01:53:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6M8rSRw016512
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 01:53:28 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6M8sBXb017380;
	Mon, 22 Jul 2002 01:54:11 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA02021;
	Mon, 22 Jul 2002 01:54:10 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6M8sAb04052;
	Mon, 22 Jul 2002 10:54:10 +0200 (MEST)
Message-ID: <3D3BC827.439BFC10@mips.com>
Date: Mon, 22 Jul 2002 10:54:10 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: CoreHI interrupts on Malta
References: <3D3894CD.5000609@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:

> After shuffling some lines of printk(), etc, I suddenly get the following
> panics.  Anybody knows what they are?  They seems to be recursive, BTW.
>
> If the interrupts really shouldn't happen, we probably should just disable IP5.
>

This interrupt comes from the Galileo system controller, when an error happens on
the bus.
Your are probably accesses an address out of range (beyond your physical memory
area).

This indicate a fatal error in the kernel, ignoring it wouldn't be wise.


>
> Jun
>
> Loading modules:
> modprobe: Can't open dependencies file /lib/modules/2.4.19-rc1/modules.dep (No )
> CoreHI interrupt, shouldn't happen, so we die here!!!
> epc   : 80108a00
> Status: 1000fc03
> Cause : 00802000
> badVaddr : 00000000
> GT_INTRCAUSE = 43e00009
> GT_CPU_ERR_ADDR = 0204000028
> CoreHi interrupt in malta_int.c::corehi_irqdispatch, line 285:
> $0 : 00000000 7fff62e8 00000000 7fff63e8 7fff6308 83ffff28 00000000 83f3c364
> $8 : 00000000 00000000 00000000 00000000 00000000 7fff62c8 00000000 00000000
> $16: 7fff63c0 00000018 00000000 10013a88 00000000 ffffffff 00000000 10015188
> $24: 00000000 00000018                   83ffe000 83ffff30 00000008 801089e8
> Hi : 00000000
> Lo : 00000020
> epc  : 80108a00    Not tainted
> Status: 1000fc03
> Cause : 00802000
> Process rcS (pid: 32, stackpage=83ffe000)
> Stack: ffffffff 7fff6498 7fff6518 00000000 00000001 00000000 00000000 802c0000
>         00001062 00000000 00000018 7fff62c8 7fff62e8 00000000 0000fc00 2ad44404
>         00000000 00000000 00000000 7fff64a0 00000000 00000000 00000000 00000020
>         00000000 10013a88 00000000 ffffffff 00000000 10015188 00000000 2acb0870
>         00000010 00000000 2ae22db0 7fff62b0 00000008 2acaec84 00000020 00000000
>         2acb0884 ...
> Call Trace:
> Code: afa80034  00021023  afa20018 <afa20020> 40086000  00000000  35080001  390
> CoreHI interrupt, shouldn't happen, so we die here!!!
> ....

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
