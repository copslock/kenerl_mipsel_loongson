Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2005 19:38:57 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:41940 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225325AbVBKTil>; Fri, 11 Feb 2005 19:38:41 +0000
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j1BJcTBN021208;
	Fri, 11 Feb 2005 14:38:29 -0500
Received: from [127.0.0.1] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by vivi.cc.vt.edu (MOS 3.5.7-GR)
	with ESMTP id CPG70006 (AUTH spbecker);
	Fri, 11 Feb 2005 14:38:26 -0500 (EST)
Message-ID: <420D09D3.2090405@gentoo.org>
Date:	Fri, 11 Feb 2005 14:38:59 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>,
	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>,
	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
References: <420CEE7F.3080201@astek.fr> <420CF611.5030705@gentoo.org> <Pine.LNX.4.61L.0502111825300.30117@blysk.ds.pg.gda.pl> <420D006E.3000107@total-knowledge.com> <Pine.LNX.4.61L.0502111915510.30117@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0502111915510.30117@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
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

Well, it wasn't my intention to beat anything to death mentioning the 
o64 hack.  I'm just pointing out that using n64 for an ip32 kernel 
results in a broken kernel at this point in time...plain and simple. 
Therefore we have to use this hack.  Another point though is that n64 
kernels are very large, and apparently ip32 has issues booting kernels 
larger than about 8mb.  So either way, n64 isn't a good idea for o32 at 
this time.

Steve
