Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 16:14:01 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33565 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012817AbbEHON7MQHnZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 16:13:59 +0200
Received: by iepj10 with SMTP id j10so61108631iep.0;
        Fri, 08 May 2015 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FkYJDb/9CkFL5Lws5+AM8hvlLPu4kXwPeAofrwgyS70=;
        b=yzp8AbQNUd6VAq09GAYZ8bcYf2XdXfQoMeMeRROziuRkoj+RZfElaNOy8WruEHsoKi
         Fus3jMFzCVccFMb2IOA6buaFJah1uygiS15+4tDFdlxYdBlY9gMGsOi6/AZTGz4HBC7o
         nSI1eWbYcgLrtbSVljyTmXpA3Regb8+oD6i4Tfa75C7dPAh8GimFFljEOKPpZQDw38fv
         RR8rchgxoa62yWE4sVjVt1qYkrAZWM1/efOPoQmSSIYWlm3WYKQ6dUZUUj71h/GzTkgd
         XZ6jFGDj3EpXhVcDd9+rR5bHaBPRHG4xS3oZ3SersJWpuST3WF+meuYFryMEB+S2nmZ/
         84gg==
X-Received: by 10.107.130.165 with SMTP id m37mr5057383ioi.62.1431094434861;
        Fri, 08 May 2015 07:13:54 -0700 (PDT)
Received: from [192.168.0.10] (CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com. [99.231.110.121])
        by mx.google.com with ESMTPSA id k16sm5129430igf.19.2015.05.08.07.13.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 07:13:50 -0700 (PDT)
Message-ID: <554CC49C.1010204@gmail.com>
Date:   Fri, 08 May 2015 10:13:48 -0400
From:   nick <xerofoify@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>, ralf@linux-mips.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips:Fix build error for ip32_defconfig configuration
References: <1431046356-27882-1-git-send-email-xerofoify@gmail.com> <554C4D4E.6040904@gentoo.org>
In-Reply-To: <554C4D4E.6040904@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47280
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



On 2015-05-08 01:44 AM, Joshua Kinard wrote:
> On 05/07/2015 20:52, Nicholas Krause wrote:
>> This fixes the make error when building the ip32_defconfig
>> configuration due to using sgio2_cmos_devinit rather then
>> the correct function,sgio2_rtc_devinit in a device_initcall
>> below this function's definition.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>>  arch/mips/sgi-ip32/ip32-platform.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
>> index 0134db2..2a7efcb 100644
>> --- a/arch/mips/sgi-ip32/ip32-platform.c
>> +++ b/arch/mips/sgi-ip32/ip32-platform.c
>> @@ -130,9 +130,9 @@ struct platform_device ip32_rtc_device = {
>>  	.resource		= ip32_rtc_resources,
>>  };
>>  
>> -+static int __init sgio2_rtc_devinit(void)
>> +static  __init int sgio2_rtc_devinit(void)
>>  {
>>  	return platform_device_register(&ip32_rtc_device);
>>  }
>>  
>> -device_initcall(sgio2_cmos_devinit);
>> +device_initcall(sgio2_rtc_devinit);
>>
> 
> I believe I sent this patch in already, back on 04/19/2015.  Didn't get an
> acknowledgement on it from akpm, though.
> 
> --J
> 
That's fine, I didn't known about that. 
Sorry Nick
