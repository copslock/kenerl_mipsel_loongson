Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 03:26:38 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:51415 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039073AbWLGD0d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 03:26:33 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 08DDC15D4004;
	Wed,  6 Dec 2006 20:56:36 -0800 (PST)
Subject: Re: Cant analyze prologue code
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061207.103714.25910613.nemoto@toshiba-tops.co.jp>
References: <1165434577.6516.8.camel@sandbar.kenati.com>
	 <45772013.70907@ru.mvista.com>
	 <1165450403.6516.28.camel@sandbar.kenati.com>
	 <20061207.103714.25910613.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Date:	Wed, 06 Dec 2006 19:39:14 -0800
Message-Id: <1165462754.6516.40.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips


Hi,

I cant build the kernel with this patch -- i m using the 2.6.14.6
kernel..

also, the kernel does not hang, but the output produced on the console 
is not complete: eg
i.e. I get this:


> 1000 i 1.5 P P <v@e.>
> 0: A1 Er n  01500000,  28
> 0: Bd BCM5221 10/100 BT PHY   e 0
> 0: U Bo BCM5221 10/100 BT PHY  a
> 1: A1 Ee    01510000,  29
> 1: Bm BCM5221 10/100 BT PHY   e 0
> 1: U Bc BCM5221 10/100 BT PHY  l
> NET: Re c l 2
> IP t   h l i: 1024 (: 0, 4096 s)
> TCP l h  i: 4096 (: 2, 16384 s)
> TCP d h  i: 4096 (: 2, 16384 s)
> TCP: H s u (a 4096  4096)
> TCP  s
> TCP  s
> NET: Rs o y 1
> NET: Rt o i 17
> IP-C: Gn s 255.255.255.0

instead of :


> au1000eth version 1.5 Pete Popov <ppopov@embeddedalley.com>
> eth0: Au1x Ethernet found at 0xb1500000, irq 28
> eth0: Broadcom BCM5221 10/100 BaseT PHY at phy address 0
> eth0: Using Broadcom BCM5221 10/100 BaseT PHY as default
> eth1: Au1x Ethernet found at 0xb1510000, irq 29
> eth1: Broadcom BCM5221 10/100 BaseT PHY at phy address 0
> eth1: Using Broadcom BCM5221 10/100 BaseT PHY as default
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 2, 16384 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> IP-Config: Guessing netmask 255.255.255.0
> IP-Config: Complete:


which makes me think there is some kind of a wrong initialisation of the UART -- but i ve checked all the parameters:
iobase, IRQ, etc and nothing is obviously wrong --

I was wondering what the significance of the flags in the plat_serial8250_port is?


> static struct plat_serial8250_port encm3_via_uart_data[] = {
>                 {
> 
>                    .flags          = UPF_SHARE_IRQ, 
>                        
Thanks and Regards,
Ashlesha.


On Thu, 2006-12-07 at 10:37 +0900, Atsushi Nemoto wrote:
> On Wed, 06 Dec 2006 16:13:23 -0800, Ashlesha Shintre <ashlesha@kenati.com> wrote:
> > However, I now get a "Cant analyze prologue code at 80294aec." error!
> > 
> > Any remedies/suggestions for the same?
> 
> Please look at this thread:
> 
> http://www.linux-mips.org/archives/linux-mips/2004-09/msg00123.html
> 
> Final patch is:
> 
> http://www.linux-mips.org/archives/linux-mips/2004-10/msg00312.html
> 
> And actual commit is:
> 
> http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=dc953df1ba5526814982676f47580c8e1bcdbfeb
> 
> ---
> Atsushi Nemoto
