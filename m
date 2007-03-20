Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 16:24:58 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:57062 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022224AbXCTQY4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 16:24:56 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A35CB3ED1; Tue, 20 Mar 2007 09:24:21 -0700 (PDT)
Message-ID: <46000ADD.3050309@ru.mvista.com>
Date:	Tue, 20 Mar 2007 19:25:01 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marco Braga <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>	 <200703200204.l2K24WgH020041@centurysys.co.jp>	 <45FFEDED.6060708@ru.mvista.com>	 <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>	 <45FFFE8B.1010806@ru.mvista.com>	 <d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>	 <4600052B.40901@ru.mvista.com> <d459bb380703200908t2ab759f0u352dc0014ebe0b17@mail.gmail.com>
In-Reply-To: <d459bb380703200908t2ab759f0u352dc0014ebe0b17@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marco Braga wrote:

>> > I think I'm beginning to make a lot of confusion. Is the problem that
>> the
>> > PCI1510 must NOT be behind a bridge, or the problem is that PCI1510 
>> acts
>> as
>> > a bridge, so cardbus cards cannot work?

>>     The second.

> Ok, at the risk of appearing totally dumb, I'll double check.. If the 
> second
> ic correct, PCI1510 is a bridce, a cardbus card cannot work.

    Yeah. Note that it's not totally broken -- you just can't use the "decent" 
devices on it, i.e. ones with bus mastering.

>>    You can see yourself that PCI1510 is a bridge (Cardbus-to-PCI bridge is
>> largely the same as PCI-to-PCI bridge).

> Ok.

    Yeah, that's an importnat point.  AMD docs don't say about CardBus 
bridges, So, it was probably obvious to me only. :-)

>> So it seems that the 3Com card is behind a bus. Should this work? From
>> what
>> > I've understood, it should now work..

>>     Think again. :-)

> Ok, that's a typo :-) It should NOT work. Is this better?

>   Sounds like what's been told in the errata 32.

> It seems that  Au1500 slowly faded into the shadows. Now it is owned by
> Raza, but there is no sign of an errata document, perhaps I've lost the
> magic moment when a lot of documentation was available.

    The errata has been available only from the AMD's developer site.

> But still, the question remains: how can Takeyoshi's "Ricoh CardBus Bridge"
> work with a cardbus card if bridges cannot work with Au1500's PCI?

> Scrub scrub..

WBR, Sergei
