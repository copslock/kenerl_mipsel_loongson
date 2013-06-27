Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 22:54:32 +0200 (CEST)
Received: from mail-gh0-f169.google.com ([209.85.160.169]:64156 "EHLO
        mail-gh0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835042Ab3F0Uyb0I3c3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jun 2013 22:54:31 +0200
Received: by mail-gh0-f169.google.com with SMTP id r1so498275ghr.14
        for <multiple recipients>; Thu, 27 Jun 2013 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=coBh83tmXRRYEu/q9W3A0S0mbu3vwx65za4t22T9riM=;
        b=sOi35S2zsgSkZZrn/8cxjKo7S0v9fdPA/t2pFhkC09k7z0lrWpGtGATGOIQhzjlBuz
         /G8JpSjKZQdAj85krM+ZNrl1lM5CSIyyt7HikgT5ciYBXgLmgv8YGMD2gzqn+j6tUF80
         AXbACv6Y6iuiYaYZ6pLwzRbLsuBomfdXveHIzYvuhAf8owGeXZguPBqvgeR4IThxNZub
         jMbMRTjen4E0mVlr0fJqk9YH90OfL+wOitjfhvGS/Wz7zw8NHAusQ0Nl8OU78j7asfcF
         iuc32fyWC7gI7jCwAw2PDTxDGTvj/LW7aiX6IzXXFKqPXCMrQ0YolYlsP/mSXO7KCl4Q
         7eTg==
X-Received: by 10.236.5.142 with SMTP id 14mr5646913yhl.207.1372366464880;
        Thu, 27 Jun 2013 13:54:24 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPSA id v68sm6620540yhn.22.2013.06.27.13.54.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 13:54:24 -0700 (PDT)
Message-ID: <51CCA67C.2010803@gmail.com>
Date:   Thu, 27 Jun 2013 15:54:20 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Santosh Shilimkar <santosh.shilimkar@ti.com>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        arm@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com> <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com>
In-Reply-To: <51C48B5A.2040404@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On 06/21/2013 12:20 PM, Santosh Shilimkar wrote:
> On Friday 21 June 2013 05:04 AM, Sebastian Andrzej Siewior wrote:
>> On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
>>> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
>>> index 0a2c68f..62e2e8f 100644
>>> --- a/arch/microblaze/kernel/prom.c
>>> +++ b/arch/microblaze/kernel/prom.c
>>> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
>>>  }
>>>  
>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>> -		unsigned long end)
>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>>  {
>>>  	initrd_start = (unsigned long)__va(start);
>>>  	initrd_end = (unsigned long)__va(end);
>>
>> I think it would better to go here for phys_addr_t instead of u64. This
>> would force you in of_flat_dt_match() to check if the value passed from
>> DT specifies a memory address outside of 32bit address space and the
>> kernel can't deal with this because its phys_addr_t is 32bit only due
>> to a Kconfig switch.
>>
>> For x86, the initrd has to remain in the 32bit address space so passing
>> the initrd in the upper range would violate the ABI. Not sure if this
>> is true for other archs as well (ARM obviously not).
>>
> That pretty much means phys_addr_t. It will work for me as well but
> in last thread from consistency with memory and reserved node, Rob
> insisted to keep it as u64. So before I re-spin another version,
> would like to here what Rob has to say considering the x86 requirement.
> 
> Rob,
> Are you ok with phys_addr_t since your concern was about rest
> of the memory specific bits of the device-tree code use u64 ?

No. I still think it should be u64 for same reasons I said originally.

Rob
