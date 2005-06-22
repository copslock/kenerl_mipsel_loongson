Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 13:53:06 +0100 (BST)
Received: from sccrmhc14.comcast.net ([IPv6:::ffff:204.127.202.59]:40353 "EHLO
	sccrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8225400AbVFVMwq>; Wed, 22 Jun 2005 13:52:46 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005062212513501400k7b8ue>; Wed, 22 Jun 2005 12:51:36 +0000
Message-ID: <42B95FB2.1090604@gentoo.org>
Date:	Wed, 22 Jun 2005 08:55:14 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: .set mips2 breaks 64bit kernel (Re: CVS Update@linux-mips.org:
 linux)
References: <20050614173512Z8225617-1340+8840@linux-mips.org> <20050622.163101.103777455.nemoto@toshiba-tops.co.jp> <Pine.LNX.4.61L.0506221330240.4849@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0506221330240.4849@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> 
>  Any specifics please?  It works for me -- I wouldn't have committed it 
> otherwise.  In particular in the affected range there are no operations 
> that would require a 64-bit ISA.
> 
>   Maciej

I've tested to see it break IP30, and Thiemo reported IP27 was also not booting 
(no text display after kernel entry).  Reversing this patch seems to allow both 
systems to boot.  Is it possible it breaks ELF64-only builds?  I haven't tested 
it on IP28 yet, so I can't confirm this (it's also ELF64).


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
