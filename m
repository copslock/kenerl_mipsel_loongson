Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:26:48 +0100 (CET)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:45726 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009080AbaLTB0qWAjTD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:26:46 +0100
Received: by mail-ig0-f170.google.com with SMTP id r2so2964599igi.1;
        Fri, 19 Dec 2014 17:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eA6lWxKBfObwK1nKn+XCtspUYqHnYAs4fDu8maFKNgU=;
        b=ojZLBrOuNNnkTBNrZS6rVXlEGWdecUEk8DfPCwBDGyIuaWtWd1gajFB8wIiMAwc41d
         JX7AzNxJOWqqd8v98K/Irvkjy1eo1eg4gwGNP4ZETng5ztFCtN5eu98r9BvBvZPHd4sK
         gPN06n7vppPiIyikApGJR+Mj4B1jhq5XhgQ9CjwI+St50PnleA4TrXgqpY31va62Dojy
         DYu/+YCHpw3CmPKW0xVAM8dBy3e+BQM/GwfjRP7+lII+R5x9+Ct+p/tttFGMFYrFDN2s
         cZf7DS5HTxEjb3Ka3K4OtxIv8rb4PcRm08r2e+h7f/3LKZncMoHlzLERXyitjCgnCDQY
         UB3Q==
X-Received: by 10.43.153.8 with SMTP id ky8mr9227066icc.37.1419038800587;
        Fri, 19 Dec 2014 17:26:40 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 23sm5322898ioq.1.2014.12.19.17.26.39
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:26:40 -0800 (PST)
Message-ID: <5494D04F.4030701@gmail.com>
Date:   Fri, 19 Dec 2014 17:26:39 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Fix C0_Pagegrain[IEC] support.
References: <1419038123-30270-1-git-send-email-ddaney.cavm@gmail.com> <5494CF23.1080606@imgtec.com>
In-Reply-To: <5494CF23.1080606@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 12/19/2014 05:21 PM, Leonid Yegoshin wrote:
> On 12/19/2014 05:15 PM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> If we are generating TLB exception expecting separate vectors, we must
>> enable the feature.
>>
>> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>
>> Very lightly tested, but it seems to make my XI and RI tests work on
>> OCTEON II CPUs, which have the C0_Pagegrain[IEC] bit.
>>
>>   arch/mips/mm/tlb-r4k.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
>> index e90b2e8..30639a6 100644
>> --- a/arch/mips/mm/tlb-r4k.c
>> +++ b/arch/mips/mm/tlb-r4k.c
>> @@ -489,6 +489,8 @@ static void r4k_tlb_configure(void)
>>   #ifdef CONFIG_64BIT
>>           pg |= PG_ELPA;
>>   #endif
>> +        if (cpu_has_rixiex)
>> +            pg |= PG_IEC;
>>           write_c0_pagegrain(pg);
>>       }
> David, I think it is still better to use set_c0_pagegrain() because
> PageGrain has a lot of RW bits now and clear all of them may be not good.

IMHO all the code that sets PageGrain should be in this function.  We 
should calculate all the bits here that should be set, and set them.

The whole reason that we have this mess, is that we were setting the 
bits at different code sites, and clobbering them in others.

If *all* the PageGrain logic is in one place, we won't have this problem.

If you think this patch is incorrect, then we should revert the other 
two and take our time to carefully do something that is correct.

David Daney
