Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2004 22:44:37 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:43490 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8226055AbUFQVod>; Thu, 17 Jun 2004 22:44:33 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc12) with ESMTP
          id <2004061721442601200ho9ane>
          (Authid: kumba12345);
          Thu, 17 Jun 2004 21:44:26 +0000
Message-ID: <40D2118C.5020506@gentoo.org>
Date: Thu, 17 Jun 2004 17:47:56 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Swap and 2.6
References: <40D1FA36.80800@murphy.dk>
In-Reply-To: <40D1FA36.80800@murphy.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Brian Murphy wrote:

> Hi,
> I have been using the swap patch posted here by Kumba on 27/5/2004
> and it seeems to work, why has it not been merged? Is it incorrect?
> Without it swapon segfaults and enabling swap is impossible.
> 
> /Brian

It does seem to work for me on my R5K machines.

My only oddity so far is I'm unsure if it runs on R4x00 machines or 
Indigo2's.  My I2 lacks a framebuffer, and ip22zilog is shot dead in 
2.6.x, so It's near impossible to tell whether I get a successful boot 
or not on the machine.  I'm confident Peter's patch works for the most 
part, but if anyone w/ an I2 R4x00 machine and Newport can test 
2.6.5/.6/.7 + patch and let me know if it boots or not, I'd be 
interested.  Right now, I'm not able to boot anything past 2.6.4 on said 
machine, and have no idea how to capture all the boot info from the 
kernel startup through userland (netconsole didn't seem to work when I 
last tried it).


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
