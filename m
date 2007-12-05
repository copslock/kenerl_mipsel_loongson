Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 06:16:36 +0000 (GMT)
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:31155 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20022337AbXLEGQ2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2007 06:16:28 +0000
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id LsFa1Y00B0EPcho0A09Z00; Wed, 05 Dec 2007 06:16:20 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id LuGJ1Y00258Be2l0800000; Wed, 05 Dec 2007 06:16:19 +0000
X-Authority-Analysis: v=1.0 c=1 a=iutXgmbQ7ULgJeHD0VAA:9 a=VsqEP6V0iwlQwqG2ykgORS65Xd8A:4 a=QJAqVYndk0IA:10
Message-ID: <4756422D.6070305@gentoo.org>
Date:	Wed, 05 Dec 2007 01:16:13 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <20071129095442.C6679C2B39@solo.franken.de> <20071129130130.GA14655@linux-mips.org>
In-Reply-To: <20071129130130.GA14655@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Nov 29, 2007 at 10:54:42AM +0100, Thomas Bogendoerfer wrote:
> 
>> Add support for SGI IP28 machines (Indigo 2 with R10k CPUs)
>> This work is mainly based on Peter Fuersts work.
> 
> Queued for 2.6.25.  There clearly is work remaining to be done but the
> code is now in an acceptable shape and the best way to push it forward
> is integrating it.  Thanks for all the work and especially to Peter
> Fürst for the initial heavyweight lifting!
> 
>   Ralf

Seconded.  Peter is made of Win.

I've been out of it lately -- did the gcc side of things ever make it in, or do 
we need to go push on that some more?


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
