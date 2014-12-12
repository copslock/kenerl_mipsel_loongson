Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:20:02 +0100 (CET)
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:47933 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008621AbaLLWUAeICsC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:20:00 +0100
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-04v.sys.comcast.net with comcast
        id SmHl1p0045Clt1L01mKtbL; Fri, 12 Dec 2014 22:19:53 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-17v.sys.comcast.net with comcast
        id SmKs1p00Y0gJalY01mKttz; Fri, 12 Dec 2014 22:19:53 +0000
Message-ID: <548B69F8.3000104@gentoo.org>
Date:   Fri, 12 Dec 2014 17:19:36 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: CEVT: Make R4K's clockevent_device name more meaningful
References: <548B5EAC.9030403@gentoo.org> <548B62D1.4000809@gmail.com>
In-Reply-To: <548B62D1.4000809@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1418422793;
        bh=Jffs6+H4oSsxqxaWXSZOXnPqnOzoemAgHiKR56nf8+4=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=EGK211Gf48NnAptY9zuX947nBZFzLNuQUp3lKj6gSY3nb/iMu9aTRio3WnLBMuQX2
         1lKKmwoI3Jt5eqKUT7elxMeZuNx1BkMSrUfJOsnQnsuzmyG2zyvU50MbdTX3fr7Tjk
         hm/loHFjYXXqmjuoPmP9yClvdqqiwiIgYPRATXLiRE5DIJ56mn7qa5B3FkzYwPif+8
         M5OxSStiZyKntl1vNHS8YWW3qC0bsE5e6Zg48fcnVE4auj934MDOn6HI8xi8zYm4Bk
         IFEOQiER/EcZ5A3JDfBAAyhDp73GrYrBHBc10mma/b+wxJtkXWsp4s8HsAxUwPPcPS
         /shK2h9FiCwUw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44664
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

On 12/12/2014 16:49, David Daney wrote:
> On 12/12/2014 01:31 PM, Joshua Kinard wrote:
>> Change the R4K clockevent device's name from "MIPS" to something a bit more
>> meaningful, "CEVT-R4K".
>>
> 
> This is visible to userspace, so how does changing this effect the kernel <-->
> userspace ABI?  Or in other words, what uses this, and could changing it
> possibly break things?
> 
> David Daney

I haven't noticed any issues in userspace running this change on the Octane.
R4k is the only clockevent_device using the name of "MIPS", so if there is some
userspace program relying on that, I would imagine it'd fail on the other
clockevent_device providers as they use different names.  I suspect that R4k
was the original clockevent_device/timer, so it got defaulted to "MIPS".  Since
there's several providers now, differentiating R4K seems logical.

--J


>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>   arch/mips/kernel/cevt-r4k.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
>> index bc127e2..f531cac 100644
>> --- a/arch/mips/kernel/cevt-r4k.c
>> +++ b/arch/mips/kernel/cevt-r4k.c
>> @@ -178,7 +178,7 @@ int r4k_clockevent_init(void)
>>
>>       cd = &per_cpu(mips_clockevent_device, cpu);
>>
>> -    cd->name        = "MIPS";
>> +    cd->name        = "CEVT-R4K";
>>       cd->features        = CLOCK_EVT_FEAT_ONESHOT |
>>                     CLOCK_EVT_FEAT_C3STOP |
>>                     CLOCK_EVT_FEAT_PERCPU;
>>
