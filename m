Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 16:57:21 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37704 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026566AbbEHO5UB-WI0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 16:57:20 +0200
Received: by igbsb11 with SMTP id sb11so23360836igb.0;
        Fri, 08 May 2015 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lXG3fsDHvHF0e7gA8XZyzKgteGMcARyjgzcsTK37uz0=;
        b=eFhXtRxeYdQX8OKaNKLxJIDOS6vTz2t0keYgvOOMJFLyqur5qNn2hokG7DlwelvcQZ
         l5CXBhzE73jFydoJxNoilIXDiXf3VhXsuyjFHR57hq/vHe10Z9WVllMRJvYFo3FZGlPQ
         JvvN47bXsDOa4jqjcThjc2wEGWVd1r0eTCvT8OYe2LbpoFwLtImfZioX0RIg95LXCbo8
         lZZKT0uXHJ0G2Xfr6NZNTfBOb4m7X+jakhJIZxeY0/RXjRpC6CGDEB7xhmATr8gpbJuQ
         gV5eLsxQaNO7x5vVcZh8Ao5k6IJhlnRGCv5iL4DLoSia7q8e+9hzY/jYEOpFnIHbxzOt
         ZI/Q==
X-Received: by 10.107.163.79 with SMTP id m76mr5490388ioe.85.1431097036458;
        Fri, 08 May 2015 07:57:16 -0700 (PDT)
Received: from [192.168.0.10] (CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com. [99.231.110.121])
        by mx.google.com with ESMTPSA id g2sm5208694igt.8.2015.05.08.07.57.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 07:57:15 -0700 (PDT)
Message-ID: <554CCEC9.9080406@gmail.com>
Date:   Fri, 08 May 2015 10:57:13 -0400
From:   nick <xerofoify@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>, ralf@linux-mips.org
CC:     chenhc@lemote.com, andreas.herrmann@caviumnetworks.com,
        rusty@rustcorp.com.au, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips:Remove unneeded duplicate declaration of cpu_callin_map
 in smp.h
References: <1431094355-28145-1-git-send-email-xerofoify@gmail.com> <554CCD6D.9010004@imgtec.com>
In-Reply-To: <554CCD6D.9010004@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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



On 2015-05-08 10:51 AM, James Hogan wrote:
> On 08/05/15 15:12, Nicholas Krause wrote:
>> This removes the unneeded duplicate declaration of cpu_callin_map
>> in smp.h due to use already declaring it in the file,smp.c that
> 
> No, it isn't declared in arch/mips/kernel/smp.c, its *defined* there (no
> "extern"). It's referenced by:
> arch/mips/cavium-octeon/smp.c
> arch/mips/kernel/process.c
> arch/mips/kernel/smp-bmips.c
> arch/mips/kernel/smp-cps.c
> arch/mips/loongson/loongson-3/smp.c
> as well as arch/mips/kernel/smp.c, which is why the declaration is
> needed in a header.
> 
> If you're attempting to fix the build errors in this area, please see:
> http://patchwork.linux-mips.org/patch/9970/
> 
> Cheers
> James
> 
>> already uses it internally for functions required this variable
>> for their various internal work.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>>  arch/mips/include/asm/smp.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
>> index bb02fac..7752011 100644
>> --- a/arch/mips/include/asm/smp.h
>> +++ b/arch/mips/include/asm/smp.h
>> @@ -45,8 +45,6 @@ extern int __cpu_logical_map[NR_CPUS];
>>  #define SMP_DUMP		0x8
>>  #define SMP_ASK_C0COUNT		0x10
>>  
>> -extern volatile cpumask_t cpu_callin_map;
>> -
>>  /* Mask of CPUs which are currently definitely operating coherently */
>>  extern cpumask_t cpu_coherent_mask;
>>  
>>
> James,
Your patch is 100% percent I missed that it hit all those files and therefore just removed it from the 
header file. After looking at it further this was easy break the build on other configurations,please
NAK this patch.
Nick
