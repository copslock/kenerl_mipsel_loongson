Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jul 2013 02:24:22 +0200 (CEST)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:48859 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834875Ab3GSAYOSX51S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jul 2013 02:24:14 +0200
Received: by mail-ob0-f179.google.com with SMTP id xk17so4397145obc.38
        for <linux-mips@linux-mips.org>; Thu, 18 Jul 2013 17:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=hcrrQ5GUrGrDe2+/UV7y40cEhxO1/TXnAtWQb0byUDQ=;
        b=T3RXnMcnTZ575beoyK5m/HHkosebpJ+VWS8oF+HYd2rmpIz9L9bBEXnymwBBKi/7Wd
         aO34o9AT3rtaGdprnAeg5mzJd2gH8VRvdg/LxW3SddpS/2XNazuKqZVhgjPhU2jxAnvk
         IfQ+7ojzimd7g/TtRO2x8EPShiM8zVpR3pf+EAI4f7tCk1RxtV3g9FBC3/mszKfsQmN8
         j8sBvfyirrBnRy0+KafZHRWJhPiVTRXLJyzt5fxQg6CvJzs003j1e+Yw1ZsrKZ/EkxFD
         42U1viWp2qAIJa7Q5+W7okEVKB2X1ozvpb5KsrjgBeRAzKKWsa1Bz43TMhVWAFjXMiLZ
         Uapw==
X-Received: by 10.60.138.137 with SMTP id qq9mr15983151oeb.8.1374193447204;
        Thu, 18 Jul 2013 17:24:07 -0700 (PDT)
Received: from [192.168.27.116] (pool-173-74-121-95.dllstx.fios.verizon.net. [173.74.121.95])
        by mx.google.com with ESMTPSA id o8sm18241285obx.11.2013.07.18.17.24.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 17:24:06 -0700 (PDT)
Message-ID: <51E88726.1000705@mvista.com>
Date:   Thu, 18 Jul 2013 19:24:06 -0500
From:   Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] mips/ftrace: Fix function tracing return address to match
References: <1373926637-24627-1-git-send-email-ddaney.cavm@gmail.com> <1374178262.6458.266.camel@gandalf.local.home>
In-Reply-To: <1374178262.6458.266.camel@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlq8BsOwZkFRdjy7gnqJzq0nK6tGwqcuOfqwrAK+MlW6DEvQL44wP12+Oww9EvJeqNQddO4
Return-Path: <cminyard@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cminyard@mvista.com
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

On 07/18/2013 03:11 PM, Steven Rostedt wrote:
> On Mon, 2013-07-15 at 15:17 -0700, David Daney wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Dynamic function tracing was not working on MIPS.  When doing dynamic
>> tracing, the tracer attempts to match up the passed in address with
>> the one the compiler creates in the mcount tables.  The MIPS code was
>> passing in the return address from the tracing function call, but the
>> compiler tables were the address of the function call.  So they
>> wouldn't match.
>>
>> Just subtracting 8 from the return address will give the address of
>> the function call.  Easy enough.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> [david.daney@cavium.com: Adjusted code comment and patch Subject.]
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/mips/kernel/mcount.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
>> index a03e93c..539b629 100644
>> --- a/arch/mips/kernel/mcount.S
>> +++ b/arch/mips/kernel/mcount.S
>> @@ -83,7 +83,7 @@ _mcount:
>>   	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
>>   #endif
>>   
>> -	move	a0, ra		/* arg1: self return address */
>> +	PTR_SUBU a0, ra, 8	/* arg1: self address */
>>   	.globl ftrace_call
>>   ftrace_call:
>>   	nop	/* a placeholder for the call to a real tracing function */
> I applied this patch to my Yeeloong Lemote laptop and it causes the
> system to crash. Not sure why. I'll try to investigate.
>
> -- Steve
>
>
That is bizarre.  That value should just be used for comparisons, it 
isn't dereferenced or anything like that.  What tracing do you have enabled?

-corey
