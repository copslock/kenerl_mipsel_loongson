Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 22:12:39 +0100 (BST)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:46591 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225993AbUE1VMZ>; Fri, 28 May 2004 22:12:25 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc11) with ESMTP
          id <20040528211218011009i101e>
          (Authid: kumba12345);
          Fri, 28 May 2004 21:12:19 +0000
Message-ID: <40B7ABCE.3070809@gentoo.org>
Date: Fri, 28 May 2004 17:14:54 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: help needed : cannot install linux on SGI O2 R5000
References: <200405281210.05259.maksik@gmx.co.uk>
In-Reply-To: <200405281210.05259.maksik@gmx.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Max Zaitsev wrote:

> this I've tried already, but the thing is that the netboot kernel does not go 
> beyond telling me what the entry point was. I've also tried to use the kernel 
> from Ilya with the same root. There, everything would hang after starting the 
> initrd script.

Since you're on the framebuffer, likely the kernel was attaching to the 
serial console to display it's messages, thus why you didn't see any 
messages after the entry point.


> actually, I don't. I don't have a serial console/cable in my possetion and was 
> intending to actually use the display/keyboard combination to perform the 
> installation. Would it be possible? Can you advise me where to get a suitable 
> netboot kernel?

The framebuffer is still a bit flakey last I heard.  The netboot I have 
supports the netboot, but I have no idea how well it works.  Likely, 
it'll be several revisions of the kernel before the framebuffer becomes 
stable.

The O2 itself uses a standard DB9M connector, so it should be rather 
easy to obtain a cable and null-modem adapter to do serial console with 
for the machine.  Far easier than hunting down the obscure serial 
connectors for IP22 machines.  Serial, for now, my reccomended form of 
installing -- it'll be a lot less painless, IMHO.

Lastly, the netboot I have is geared for a gentoo install, if that's 
what you'll be installing, you'll want to aim any gentoo-specific 
questions to the gentoo-mips ML.  If it's a debian install, then you 
might be in for a fun ride or such, but I believe they are working on an 
O2 netboot of their own w/ the d-i setup and such.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
