Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 03:42:44 +0100 (BST)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:3813 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225213AbTHBCmm>; Sat, 2 Aug 2003 03:42:42 +0100
Received: from gentoo.org (pcp02545003pcs.waldrf01.md.comcast.net[68.48.92.102](untrusted sender))
          by comcast.net (sccrmhc11) with SMTP
          id <2003080202423601100pmjp2e>
          (Authid: kumba12345);
          Sat, 2 Aug 2003 02:42:36 +0000
Message-ID: <3F2B2521.2060508@gentoo.org>
Date: Fri, 01 Aug 2003 22:42:41 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: udelay
References: <1059788948.9224.62.camel@zeus.mvista.com>
In-Reply-To: <1059788948.9224.62.camel@zeus.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:

> Looks like the latest udelay in 2.4 is borked. Anyway else notice that
> problem?  I did a 10 sec test: mdelay works, udelay is broken, at least
> for the CPU and toolchain I'm using.
> 
> Pete

What's one way of testing this brokeness?  I've been trying to find some 
explanation for a bug of some sort in a cobalt RaQ2 in which the tulip 
driver (eth0) just stops dead after several minutes of use.  One of the 
notable features of the tulip driver patch needed to work on the RaQ2 
adds a "udelay(1000)" into the tulip source.  Without it, the eth0 on 
the RaQ2 is dead, so I wonder if these are related.

If they are related, then this behavior has been slowly getting worse it 
seems, as eth0 on the RaQ2 apparently has had smaller and smaller 
amounts of time needed before the interface died.  2.4.18, it took most 
of a day, by 2.4.21, it happens within seconds.

--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
