Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2004 04:11:07 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:18650 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8224850AbUCJELE>; Wed, 10 Mar 2004 04:11:04 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2004031004105601500pk8j7e>
          (Authid: kumba12345);
          Wed, 10 Mar 2004 04:10:56 +0000
Message-ID: <404E962D.5070700@gentoo.org>
Date: Tue, 09 Mar 2004 23:14:37 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: "eth%d" - net dev name in 2.6?
References: <20040310023308.GU31326@mvista.com>
In-Reply-To: <20040310023308.GU31326@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

> With swarm running on 2.6 I just saw the net dev names are
> not set correctly.  See below.
> 
> eth%d: SiByte Ethernet at 0x10064000, address: 00-02-4C-FE-0C-B2                
> eth%d: enabling TCP rcv checksum                                                
> 
> It appears alloc_netdev() assigns this initial name and nobody
> later resets it to a more meaningful name.  
> 
> Any body has a clue here?  I don't think it is driver's job though ...
> 
> Thanks.
> 
> Jun

I've seen this for ages on 2.4 and 2.6.  Seems to be some kind of typo 
or something in several archs (my Blade 100 shows this in dmesg as well).


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
