Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2004 22:23:46 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:41632 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8224952AbUCJWXp>; Wed, 10 Mar 2004 22:23:45 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20040310221317015009i4ibe>
          (Authid: kumba12345);
          Wed, 10 Mar 2004 22:13:17 +0000
Message-ID: <404F93E1.7070003@gentoo.org>
Date: Wed, 10 Mar 2004 17:17:05 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: "eth%d" - net dev name in 2.6?
References: <20040310023308.GU31326@mvista.com> <404E962D.5070700@gentoo.org> <20040310145942.GB9104@linux-mips.org>
In-Reply-To: <20040310145942.GB9104@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Tue, Mar 09, 2004 at 11:14:37PM -0500, Kumba wrote:
> 
> 
>>I've seen this for ages on 2.4 and 2.6.  Seems to be some kind of typo 
>>or something in several archs (my Blade 100 shows this in dmesg as well).
> 
> 
> What driver?
> 
>   Ralf
> 

Sun GEM driver.  Looks like it's fixed in 2.6, but 2.4.22/23 on the 
system had this in dmesg:

sungem.c:v0.97 3/20/02 David S. Miller (davem@redhat.com)
eth%d: MII PHY ID: 437420 Enable Semiconductor
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:04:be:a4

Seen it else where too, Maybe on a 2.4 driver in my x86 box, but that 
dmesg isn't available anymore to double check.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
