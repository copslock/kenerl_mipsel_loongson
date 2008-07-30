Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2008 10:03:04 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:4078 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20032921AbYG3JC5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2008 10:02:57 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 2D426C8073;
	Wed, 30 Jul 2008 12:02:48 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id ZvtXAJGzjiUG; Wed, 30 Jul 2008 12:02:48 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 105D7C8016;
	Wed, 30 Jul 2008 12:02:48 +0300 (EEST)
Message-ID: <48902E37.70108@movial.fi>
Date:	Wed, 30 Jul 2008 12:02:47 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Manuel Lauss <mlau@msc-ge.com>
CC:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v4 7/10] Alchemy: split core PM code from sysctl parts.
References: <20080729165853.GB8784@roarinelk.homelinux.net> <20080729170329.GI8784@roarinelk.homelinux.net> <48901B7A.2070700@movial.fi> <48902C3C.9060507@msc-ge.com>
In-Reply-To: <48902C3C.9060507@msc-ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> Dmitri Vorobiev wrote:
>> Manuel Lauss wrote:
>>> The Alchemy power.c file contains both core suspend/resume code, which
>>> is processor specific, and leftovers of the 2.4 PM userspace interface
>>> (sysctls).
>>>
>>> This patch moves the userspace interface to the platform.c file and
>>> leaves the core board-independent suspend/resume parts which should be
>>> usable for all Alchemy-based systems intact.
>>>
>>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>>> ---
>>>  arch/mips/au1000/common/platform.c |  304
>>> ++++++++++++++++++++++++++++++++++-
>>>  arch/mips/au1000/common/power.c    |  317
>>> +-----------------------------------
>>>  2 files changed, 305 insertions(+), 316 deletions(-)
>>>
>>> diff --git a/arch/mips/au1000/common/platform.c
>>> b/arch/mips/au1000/common/platform.c
>>> index 66d6770..1e89560 100644
>>> --- a/arch/mips/au1000/common/platform.c
>>> +++ b/arch/mips/au1000/common/platform.c
> [...]
>>> +    /**
>>> +     ** The code below is all system dependent and we should probably
>>> +     ** have a function call out of here to set this up.  You need
>>> +     ** to configure the GPIO or timer interrupts that will bring
>>> +     ** you out of sleep.
>>> +     ** For testing, the TOY counter wakeup is useful.
>>> +     **/
>>> +#if 0
>>
>> Why not simply remove the dead code while you're at it?
> 
> That code is removed by a later patch in the series.

Oh, I haven't noticed that. My mistake. Sorry.

Thanks,
Dmitri
