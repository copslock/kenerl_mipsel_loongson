Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 12:50:49 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:20373 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225539AbUA2Mus>; Thu, 29 Jan 2004 12:50:48 +0000
Received: from sprocket.localnet ([192.168.1.27] helo=bitbox.co.uk)
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1AmBc8-00062t-00; Thu, 29 Jan 2004 12:49:44 +0000
Message-ID: <40190154.10601@bitbox.co.uk>
Date: Thu, 29 Jan 2004 12:49:24 +0000
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?St=E9phane?= <stf@c-gix.com>
CC: linux-mips@linux-mips.org
Subject: Re: Best kernel for a Cobalt Qube 2
References: <4018EA65.40407@c-gix.com>
In-Reply-To: <4018EA65.40407@c-gix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Stéphane wrote:

> I'm using a Cobalt Qube 2 for a long time now, it's under a 2.4.14 
> kernel working 24/24 7/7 without any problem (no weird hang, no tulip 
> problems, both internal network cards used).
>
> It's appears that the new libc needs at least a 2.4.19 kernel, this is 
> breaking all my debian updates. So I'll have to switch.
>
> Do you have any advice about which kernel to use  ?
>
> According to what I read here, 2.4.23 seems not ready and it's not 
> clear to me if newest kernels still have problem whith the 
> network/serial bug...


2.4.23 is running solid here, but it needs a couple of patches (one 
fixes a cache aliasing bug triggered by IDE in PIO mode, another fixes 
up Galileo so the network driver works without stalling). I'll mail the 
patches when I get home.

The major problem with running the later 2.4 kernels is that  Cobalt 
boot loader kernel size restriction means you have to cut the kernel 
configuration down to the very minimum to get it to fit, and this is 
only going to get worse with 2.6. I've written a new boot loader which 
lifts this restriction (and some others), but it's a week or two away 
from completion (disk booting is complete, I'm just finisihing off 
network booting).

P.
