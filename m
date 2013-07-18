Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 22:15:08 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44105 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819780Ab3GRUPCMAu6b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 22:15:02 +0200
Received: by mail-pd0-f177.google.com with SMTP id p10so3439060pdj.36
        for <multiple recipients>; Thu, 18 Jul 2013 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BmHSSlmo4ZjUU+u+rhu7BkmaxwK97h2RJFRi0gVkr3Y=;
        b=emR7u2cIvUJR2EF5qraTcrqda3HZ+PNymjmxxYXnsRVip+5jbtJ/TY1P//W4vpRhh0
         Qz5Vm9u+jHB/OQ/VN6mf5rkX+eTf+SmDIph2cwKeyE5SzPyqkila953Rj6PmorzM0jzh
         g5/lE1wEsNgMjlGkze0tgXRbEk4HJQZGTzCzHt4dAJbn1ykcoyTVf0kujm3u0kmzE2ox
         mSrcoE+2bWySZOyN5VkBJI+RjOQj4PT7TCWrc9Fss3hpEht6qrCPgc0CSbW60aWz0muQ
         MOxl9k6XEKsLQ6vBP3jbyvcyYaxM8M7qXDOb43LSk9otQgSFODqLCjVyYVsyZKZ9ti7U
         MIiw==
X-Received: by 10.66.139.227 with SMTP id rb3mr14866763pab.121.1374178495277;
        Thu, 18 Jul 2013 13:14:55 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id is3sm9173648pbc.25.2013.07.18.13.14.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 13:14:54 -0700 (PDT)
Message-ID: <51E84CBC.80206@gmail.com>
Date:   Thu, 18 Jul 2013 13:14:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Corey Minyard <cminyard@mvista.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] mips/ftrace: Fix function tracing return address to match
References: <1373926637-24627-1-git-send-email-ddaney.cavm@gmail.com> <1374178262.6458.266.camel@gandalf.local.home>
In-Reply-To: <1374178262.6458.266.camel@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37325
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

On 07/18/2013 01:11 PM, Steven Rostedt wrote:
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
>
> I applied this patch to my Yeeloong Lemote laptop and it causes the
> system to crash. Not sure why. I'll try to investigate.
>

There is an mcount ABI difference based on which GCC version you are 
using, although I wouldn't think it would effect this bit.

We are using GCC-4.7 FWIW.

David Daney


> -- Steve
>
>
>
>
