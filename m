Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Feb 2005 00:54:45 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:3529 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225352AbVBLAy3>; Sat, 12 Feb 2005 00:54:29 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2005021200541601500e6t10e>; Sat, 12 Feb 2005 00:54:20 +0000
Message-ID: <420D5374.4000006@gentoo.org>
Date:	Fri, 11 Feb 2005 19:53:08 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
References: <420CEE7F.3080201@astek.fr> <420CF611.5030705@gentoo.org> <Pine.LNX.4.61L.0502111825300.30117@blysk.ds.pg.gda.pl> <420D006E.3000107@total-knowledge.com> <Pine.LNX.4.61L.0502111915510.30117@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0502111915510.30117@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 11 Feb 2005, Ilya A. Volynets-Evenbakh wrote:
> 
> 
>>O64 may not be supported ABI, but it provides us with a feature that is really
>>usefull:
>>specifically, it generates 32 bit symbol addresses instead of 64 bit ones.
>>This cuts
>>down on code size considerably. If this feature was implemented in toolchain
>>as separate
>>switch, O64 hack could go away.
> 
> 
>  Well, the topic has been beaten to death here, so you don't really need 
> to illuminate me -- it's only due to this popular request I've implemented 
> the ability to do 32-bit builds for 64-bit kernel.  I just wonder why 
> people insisting on such a setup don't actually contribute some code to do 
> that cleanly and keep switching between hacks as they stop working one by 
> one...
> 

I believe it was mentioned at some point in time by someone that using "n32" 
inplace of "o64" might have a similar affect of "o64", but I can't recall what 
the outcome of that actually was (or whether or not it ever worked).

As if I could be any more vague.


--Kumba

--



-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
