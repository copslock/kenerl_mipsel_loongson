Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2005 19:34:44 +0000 (GMT)
Received: from mail.sonicwall.com ([IPv6:::ffff:67.115.118.12]:31816 "EHLO
	relay.sonicwall.com") by linux-mips.org with ESMTP
	id <S8225325AbVBKTe2>; Fri, 11 Feb 2005 19:34:28 +0000
Received: from us0exb02.us.sonicwall.com ([10.50.128.202]) by relay.sonicwall.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Feb 2005 11:34:26 -0800
Received: from [10.0.15.99] ([10.0.15.99]) by us0exb02.us.sonicwall.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Feb 2005 11:34:26 -0800
Message-ID: <420D08C1.8050105@total-knowledge.com>
Date:	Fri, 11 Feb 2005 11:34:25 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	"Stephen P. Becker" <geoman@gentoo.org>,
	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>,
	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
References: <420CEE7F.3080201@astek.fr> <420CF611.5030705@gentoo.org> <Pine.LNX.4.61L.0502111825300.30117@blysk.ds.pg.gda.pl> <420D006E.3000107@total-knowledge.com> <Pine.LNX.4.61L.0502111915510.30117@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0502111915510.30117@blysk.ds.pg.gda.pl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2005 19:34:26.0061 (UTC) FILETIME=[B21DDBD0:01C51070]
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Fri, 11 Feb 2005, Ilya A. Volynets-Evenbakh wrote:
>
>  
>
>>O64 may not be supported ABI, but it provides us with a feature that is really
>>usefull:
>>specifically, it generates 32 bit symbol addresses instead of 64 bit ones.
>>This cuts
>>down on code size considerably. If this feature was implemented in toolchain
>>as separate
>>switch, O64 hack could go away.
>>    
>>
>
> Well, the topic has been beaten to death here, so you don't really need 
>to illuminate me -- it's only due to this popular request I've implemented 
>the ability to do 32-bit builds for 64-bit kernel.
>
I know

>  I just wonder why 
>people insisting on such a setup don't actually contribute some code to do 
>that cleanly and keep switching between hacks as they stop working one by 
>one...
>  
>
Because they hope that if they annoy you enough, you'll do it yourself ;-)


-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
