Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 21:49:01 +0100 (BST)
Received: from allen.werkleitz.de ([80.190.251.108]:36236 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S8133709AbWFWUsx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 21:48:53 +0100
Received: from p54bde340.dip.t-dialin.net ([84.189.227.64] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.62)
	(envelope-from <js@linuxtv.org>)
	id 1FtsZu-0003dd-MA; Fri, 23 Jun 2006 22:48:43 +0200
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1FtsZv-0000kJ-00; Fri, 23 Jun 2006 22:48:35 +0200
Date:	Fri, 23 Jun 2006 22:48:35 +0200
From:	Johannes Stezenbach <js@linuxtv.org>
To:	Daniel Mack <daniel@caiaq.de>
Cc:	linux-mips@linux-mips.org
Message-ID: <20060623204835.GA2548@linuxtv.org>
References: <5B414347-B938-4E68-812E-627AED1A38B0@caiaq.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5B414347-B938-4E68-812E-627AED1A38B0@caiaq.de>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.227.64
Subject: Re: smc91x ethernet an DBAU1200
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

Hi Daniel,

On Fri, Jun 23, 2006, Daniel Mack wrote:
>is there anyone out there successfully using the SMC 91C111 ethernet  
>chip
>on AMD's DBAU1200 eval kit? In my setup here, it's working fine from  
>within
>the YAMON boot loader so I can use it to download a kernel image via  
>TFTP.
>The kernel (bleeding edge linux-2.6 mips-GIT) detects the device as well
>
>	smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
>	eth0: SMC91C11xFD (rev 1) at b9000300 IRQ 65 [nowait]
>	eth0: Ethernet addr: 00:00:1a:19:11:8c
>
>and is able to mount its root filesystem via NFS. However, the  
>communication
>does not seem to be sufficiently stable, messages like this occur  
>regularily:
>
>	nfs: server 192.168.1.200 not responding, still trying
>	nfs: server 192.168.1.200 not responding, still trying

I had similar issues with smc91x.c on a different platform,
where the bus it is connected to was rather slow (and no DMA)
-> dropped packets.

Try to use NFS via TCP, or force a 10Mbit connection
with ethtool or by hacking the driver (ctl_rspeed).
(For me tcp works.)


HTH,
Johannes
