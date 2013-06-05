Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 18:36:40 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:58528 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827523Ab3FEQghrVTWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 18:36:37 +0200
Received: by mail-pa0-f45.google.com with SMTP id bi5so1109502pad.4
        for <multiple recipients>; Wed, 05 Jun 2013 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hWfjmYrBggh/blImod7dLNR6sgHcEm2R8vF2ml4/0NM=;
        b=sxgKGXlmpL5M+C/QPz8/2jgHoT84UTdMlx0HOSLEOHQPwEKiqP8nHywwMF3sVsFLyq
         omVk3aua0qKR24r195SfJ0goDosaCb1OdUbNr0bWG/4TIUngJ4xh7QsJDQKHgrYTTYs0
         NKc6A9tV9GjupapQcu70+/xB0trIKLSIRuaypae3kvA6U9vgGpL3vHt9eMh5/NjeYcIr
         FLIINECvmL5gCXT/hjl+h16TG5x0ky5cWhmK67zMTZdFifKta1yDFX6F1uijsR7Jhq8Z
         /IQmFWxWKFi4KEpCTmdxXaQojVBGFXlD9V4HnQFyu24BBEOsTKsCh2Fjq0lMNfAlwk3O
         sG1w==
X-Received: by 10.68.230.40 with SMTP id sv8mr34011231pbc.30.1370450190205;
        Wed, 05 Jun 2013 09:36:30 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pe9sm4429977pbc.35.2013.06.05.09.36.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 09:36:29 -0700 (PDT)
Message-ID: <51AF690B.8020702@gmail.com>
Date:   Wed, 05 Jun 2013 09:36:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v3] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370372979-20634-1-git-send-email-Steven.Hill@imgtec.com> <51AF1C0B.6090904@cogentembedded.com>
In-Reply-To: <51AF1C0B.6090904@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36695
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

On 06/05/2013 04:07 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 04-06-2013 23:09, Steven J. Hill wrote:
>
>> The ISA exception bit selects whether exceptions are taken in classic
>> MIPS or microMIPS mode. This bit is Config3.ISAOnExc and is bit 16. It
>> It was improperly defined as bits 16 and 17. Fortunately, bit 17 is
>> read-only and did not effect microMIPS operation. However, detecting
>> a classic or microMIPS kernel when examining the /proc/cpuinfo file,
>> the result always showed a microMIPS kernel.

I don't see anything in the patch that would make Classic CPUs be 
misidentified.  Is the change log still accurate?

...

>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>> ---
>>   arch/mips/include/asm/mipsregs.h |    2 +-
>>   arch/mips/kernel/cpu-probe.c     |    7 ++-----
>>   arch/mips/mti-malta/malta-init.c |    7 +++++++
>>   arch/mips/mti-sead3/sead3-init.c |    7 +++++++
>>   4 files changed, 17 insertions(+), 6 deletions(-)
>
> [...]
>> diff --git a/arch/mips/mti-malta/malta-init.c
>> b/arch/mips/mti-malta/malta-init.c
>> index ff8caff..3598f1d 100644
[...]
>> --- a/arch/mips/mti-sead3/sead3-init.c
>> +++ b/arch/mips/mti-sead3/sead3-init.c
>> @@ -130,6 +130,13 @@ static void __init mips_ejtag_setup(void)
>>
>>   void __init prom_init(void)
>>   {
>> +#ifdef CONFIG_CPU_MICROMIPS
>> +    unsigned int config3 = read_c0_config3();
>> +
>> +    if (config3 & MIPS_CONF3_ISA)
>> +        write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
>> +#endif
>> +
>
>     I see it's repeated twice and enclosed in #ifdef... Couldn't you
> factor it out in some sort of inline function and put into some header:
>
> #ifdef CONFIG_CPU_MICROMIPS
> static inline void mips_set_config3_isa_oe(void)


I don't have a strong opinion about factoring it out like this, but we 
do, let's give it a better name.  Something like 
enable_micromips_exception_mode() or similar.  That way we know what it 
does.

> {
>      unsigned int config3 = read_c0_config3();
>
>      if (config3 & MIPS_CONF3_ISA)
>          write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> }
> #else
> static inline void mips_set_config3_isa_oe(void) {}
> #endif
>
> WBR, Sergei
>
>
>
