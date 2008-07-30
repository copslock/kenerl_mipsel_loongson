Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2008 09:55:45 +0100 (BST)
Received: from gate.msc-ge.com ([212.86.197.209]:20692 "EHLO gate.msc-ge.com")
	by ftp.linux-mips.org with ESMTP id S28581167AbYG3Izi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2008 09:55:38 +0100
Received: from localhost ([127.0.0.1]:54349)
	by msc-mail01.stu.msc-ge.com with esmtp (Exim 4.34 #5 (Debian))
	id 1KO7T6-0000aF-SP; Wed, 30 Jul 2008 10:55:36 +0200
Received: from msc-mail01.stu.msc-ge.com ([127.0.0.1])
 by localhost (msc-mail01 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01840-04; Wed, 30 Jul 2008 10:55:36 +0200 (CEST)
Received: from msc-ex03.msc-ge.mscnet ([10.100.1.38]:55422)
	by msc-mail01.stu.msc-ge.com with esmtp (Exim 4.34 #5 (Debian))
	id 1KO7T6-0000a5-5W; Wed, 30 Jul 2008 10:55:36 +0200
Received: from [192.168.44.99] ([192.168.44.99]) by msc-ex03.msc-ge.mscnet with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jul 2008 10:55:46 +0200
Message-ID: <48902C3C.9060507@msc-ge.com>
Date:	Wed, 30 Jul 2008 10:54:20 +0200
From:	Manuel Lauss <mlau@msc-ge.com>
Organization: MSC Vertriebsges.m.b.H.
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
MIME-Version: 1.0
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
CC:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v4 7/10] Alchemy: split core PM code from sysctl parts.
References: <20080729165853.GB8784@roarinelk.homelinux.net> <20080729170329.GI8784@roarinelk.homelinux.net> <48901B7A.2070700@movial.fi>
In-Reply-To: <48901B7A.2070700@movial.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2008 08:55:46.0314 (UTC) FILETIME=[0E523EA0:01C8F222]
X-Virus-Scanned: by amavisd-new
Return-Path: <mlau@msc-ge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlau@msc-ge.com
Precedence: bulk
X-list: linux-mips

Dmitri Vorobiev wrote:
> Manuel Lauss wrote:
>> The Alchemy power.c file contains both core suspend/resume code, which
>> is processor specific, and leftovers of the 2.4 PM userspace interface
>> (sysctls).
>>
>> This patch moves the userspace interface to the platform.c file and
>> leaves the core board-independent suspend/resume parts which should be
>> usable for all Alchemy-based systems intact.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>> ---
>>  arch/mips/au1000/common/platform.c |  304 ++++++++++++++++++++++++++++++++++-
>>  arch/mips/au1000/common/power.c    |  317 +-----------------------------------
>>  2 files changed, 305 insertions(+), 316 deletions(-)
>>
>> diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
>> index 66d6770..1e89560 100644
>> --- a/arch/mips/au1000/common/platform.c
>> +++ b/arch/mips/au1000/common/platform.c
[...]
>> +	/**
>> +	 ** The code below is all system dependent and we should probably
>> +	 ** have a function call out of here to set this up.  You need
>> +	 ** to configure the GPIO or timer interrupts that will bring
>> +	 ** you out of sleep.
>> +	 ** For testing, the TOY counter wakeup is useful.
>> +	 **/
>> +#if 0
> 
> Why not simply remove the dead code while you're at it?

That code is removed by a later patch in the series.  This patch is
just code reshuffling; I wanted to leave everything (as broken) as
it was.

Thanks,
	Manuel Lauss
