Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 22:47:40 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:26087 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225450AbTLOWrj>; Mon, 15 Dec 2003 22:47:39 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc11) with SMTP
          id <20031215224732013009genie>
          (Authid: kumba12345);
          Mon, 15 Dec 2003 22:47:32 +0000
Message-ID: <3FDE3A27.3090408@gentoo.org>
Date: Mon, 15 Dec 2003 17:48:07 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Tulip problems on Qube 2
References: <20031215221935.GA31161@skeleton-jack>
In-Reply-To: <20031215221935.GA31161@skeleton-jack>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:

> Is anyone looking at the problems with the Tulip network driver on the
> Cobalt Qube 2 ?

I've poked around with it, granted I usually don't have a clue what's 
going on.

> I've started poking around but am not getting very far ...
> 
> The card works okay for a few minutes but then something gets very
> confused in the receive ring. If the card is being pinged with packets
> once a second it generates a receive interrupt for every packet, but the
> first receive ring entry is marked busy so the packet's not passed up.
> Once we've received 32 packets the NIC wraps round the receive ring and
> the entry we've been waiting on gets marked as full. Now the receive
> interrupt removes that last packet and the 31 preceding ones in one go.
> Then we stall for another 32 seconds.
> 
> It looks like we're loosing some of the NIC's writes to the receive ring
> status entries in main memory ...

http://lists.debian.org/debian-powerpc/2003/debian-powerpc-200310/msg00010.html

You may want to look at this patch.  It addresses a similar problem on 
PPC systems.  While the patch touches a bit of code that should only be 
executed if tp->chip_id == 21041, it apparently affects the Cobalt 
systems, which use a 211142/21143 chip.  Why this is, I have no idea.

Either way, it makes the tulip stay up longer.  The same bug still kicks 
in eventually, so it doesn't totally address the problem, but it changes 
the behavior in some way.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
