Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 17:18:40 +0000 (GMT)
Received: from [IPv6:::ffff:66.151.148.199] ([IPv6:::ffff:66.151.148.199]:54033
	"EHLO eagle.qarbon.com") by linux-mips.org with ESMTP
	id <S8225365AbUBJRSj>; Tue, 10 Feb 2004 17:18:39 +0000
Received: (qmail 10131 invoked from network); 10 Feb 2004 17:18:28 -0000
Received: from unknown (HELO theilya.com) (ilya@192.168.2.42)
  by eagle.qarbon.com with SMTP; 10 Feb 2004 17:18:28 -0000
Message-ID: <4029125F.2040603@theilya.com>
Date: Tue, 10 Feb 2004 09:18:23 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@theilya.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robin H. Johnson" <robbat2@gentoo.org>
CC: linux-mips <linux-mips@linux-mips.org>
Subject: Re: SGI O2 PANIC on mem=xxxM, and strange initrd behavior
References: <20040210112137.GA9213@curie-int.orbis-terrarum.net>
In-Reply-To: <20040210112137.GA9213@curie-int.orbis-terrarum.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@theilya.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theilya.com
Precedence: bulk
X-list: linux-mips

As it is now, you are limited to 256M of RAM. pass mem=256M, or die ;-) 
I am working now on fixing that, but hit a brick wall in few places. 
We'll see by the end of next week though.

Also, pass console=ttyS0 to get serial output.

As for death after starting init, you may be running into problem
with R1[02]K, and your init just crashes in loop, or something like 
that. I get it from time to time.

    Ilya.

Robin H. Johnson wrote:

>Hi,
>
>I've recently picked up an SGI O2, 300mhz R12k, 512Mb RAM.
>Playing with getting it working, using Ilya's minimal patches on top of
>the LMO CVS HEAD, I noticed that it wasn't pulling up the correct amount
>of RAM. I threw mem=512M onto the params, and found a kernel crash.
>
>Boots mostly fine:
>http://www.orbis-terrarum.net/~robbat2/sgio2/kernel.boot
>Crashes:
>http://www.orbis-terrarum.net/~robbat2/sgio2/kernel.crash
>Decoded:
>http://www.orbis-terrarum.net/~robbat2/sgio2/decoded.panic
>Kernel config:
>http://www.orbis-terrarum.net/~robbat2/sgio2/kernel.config
>
>I've also got one weird problem where it never gets any further than the
>init call to my busybox initrd.
>
>Output using an old debian netboot initrd (from debian-mips-2.4.19.img):
>serial console detected.  Disabling virtual terminals.  init started:
>BusyBox v0.60.3-pre (2002.01.22-06:31+0000) multi-call binary
>
>Output for using bleeding-edge Gentoo initrd that works perfectly for
>an Indy and an I2:
>init started:  BusyBox v1.00-pre7 (2004.02.10-08:42+0000) multi-call binary
>
>In both cases, right after the init message, absolutely nothing happens.
>I've tried putting commands in the linuxrc that would cause some
>externally visible activity, but nothing.
>
>I am wondering if it may have to with the virtual consoles (which I had
>to turn off to get any serial output), but I doubt they are the problem.
>
>  
>
