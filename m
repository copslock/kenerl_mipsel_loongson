Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 13:30:21 +0200 (CEST)
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:60697 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010831AbaJHLaTcpx45 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 13:30:19 +0200
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-11v.sys.comcast.net with comcast
        id 0bWC1p0024xDoy801bWGlC; Wed, 08 Oct 2014 11:30:16 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-po-05v.sys.comcast.net with comcast
        id 0bWF1p00K3aNLgd01bWGes; Wed, 08 Oct 2014 11:30:16 +0000
Message-ID: <5435203E.6050702@gentoo.org>
Date:   Wed, 08 Oct 2014 07:30:06 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: IP22/IP32: Add missing ifdefs to Platform files
References: <543496C6.7000005@gentoo.org> <54351332.9020309@imgtec.com>
In-Reply-To: <54351332.9020309@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1412767816;
        bh=69GYs6d6PlKozgbo5bEUPL5YCycLdrZtCRUdhW87RuY=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=bRFam7Rz6JI9uHvYK6B8ShkKo8+M8uXcq4iP62iocQSsIyW3+zXgfi8JmbJ0BqvQd
         4gWHfGC2sNtntOMmlbgVj1qeyqPb4+RXsypPGColti/PigZsDz4BCcsGa/3W8535fS
         XuLROAqsJGJEisJp/lBTzTh1C9dmXQMGDJBUqMsbGxtNPT/UZZ6gXCbzim7Ti4Ez6q
         V96TtrREA9vJw1xf2XtYqvQvjZIo4FIIAbc4w87cavD9LFn7Vlv7vIKYziktHlyiSA
         CL9PorpVBCT95GSNKIAb4HaO0cCv10EjEx3miioQ1mfDf+1bNvKfKrI8QfC/kXy8Hj
         qcjROEKnm8erA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 10/08/2014 06:34, Markos Chandras wrote:
> On 10/08/2014 02:43 AM, Joshua Kinard wrote:
>> In arch/mips/sgi-ip22/Platform and arch/mips/sgi-ip32/Platform, ifdefs for
>> CONFIG_SGI_IP22 and CONFIG_SGI_IP32 are missing, which can cause the
>> definitions for these platforms to get included in builds for other platforms.
>>  This patch adds these missing ifdefs, which matches IP27's Platform file.
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>  arch/mips/sgi-ip22/Platform |    8 +++++---
>>  arch/mips/sgi-ip32/Platform |    9 ++++++---
>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
>> index b7a4b7e..5fa3c7a 100644
>> --- a/arch/mips/sgi-ip22/Platform
>> +++ b/arch/mips/sgi-ip22/Platform
>> @@ -7,7 +7,8 @@
>>  # current variable will break so for 64-bit kernels we have to raise the start
>>  # address by 8kb.
>>  #
>> -platform-$(CONFIG_SGI_IP22)		+= sgi-ip22/
>> +ifdef CONFIG_SGI_IP22
>> +platform-$(CONFIG_SGI_IP22)	+= sgi-ip22/
>>  cflags-$(CONFIG_SGI_IP22)	+= -I$(srctree)/arch/mips/include/asm/mach-ip22
>>  ifdef CONFIG_32BIT
>>  load-$(CONFIG_SGI_IP22)		+= 0xffffffff88002000
>> @@ -15,6 +16,7 @@ endif
>>  ifdef CONFIG_64BIT
>>  load-$(CONFIG_SGI_IP22)		+= 0xffffffff88004000
>>  endif
>> +endif
>>  
> 
> I could be wrong but isn't that functionally the same thing? As in, if
> CONFIG_SGI_IP22 is not enabled, the sgi-ip22 etc are not included.
> That's the same thing as the original code was doing no? Why do you need
> to hide all the $FOO-$(CONFIG_SGI_IP22) in a separate #ifdef block. What
> problem are you trying to solve?

That's what I thought, but one of my builds in 3.15 for Octane (IP30) was
pulling in IP32's Platform file for some reason, which caused a build error.  I
could not figure it out.  I played with building an IP27 kernel some, and
figured out it wasn't affected, so after looking at its Platform file, I
noticed the ifdef.  Looking at IP32, that wasn't there, so I added it, and the
build problem went away.  I did the same for IP22 just for consistency.

I figure kbuild or make was just getting confused somewhere and globbing IP3*.
 IP22 wouldn't be affected because IP27 has an ifdef present, but IP30 was
somehow affected because IP32 lacked the ifdef.  No one else has probably run
into it because IP30 isn't officially in the tree.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
