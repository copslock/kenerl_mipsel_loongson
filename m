Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 12:00:21 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61205 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824104Ab3F1KATMpIAc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 12:00:19 +0200
Received: by mail-ie0-f180.google.com with SMTP id f4so3420839iea.25
        for <linux-mips@linux-mips.org>; Fri, 28 Jun 2013 03:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=7LnOFTByUiNd3Q+RFqzMpURyV0kQoPNScsBGRXkyjLc=;
        b=VwtWM1b/KkFwsIw8r7jA55uI1nghEZMlVG6ppCO3LmYoVEOV5Ig/49zGUeJeeJfIIv
         SLy4bkYwB+OFafdOaHeqL8Szja2HmMxU0yztP7wmrBzTBC/XkJ44Ar0oMkkIAXzG+TUs
         8SDRw6Rf0E65VKtA0esx9gHKrW+E7hSvCmNG1DiHVqil4Go3ESyFglR9gBUnncqeFQQd
         KYggFdLmZOchEjD2TlcniAUF/OycCbCDcxCpJUD2rGMmYY7KbpAey2e09LnuFDuRMEWy
         iMYaS93B8jUz89XPbKeG7Giu+djwMWf4z7gXWmRH0Uq0zEqofLimLpUqB3EBEgeVxbDG
         fImw==
X-Received: by 10.50.62.83 with SMTP id w19mr6953763igr.0.1372413612995; Fri,
 28 Jun 2013 03:00:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.133.16 with HTTP; Fri, 28 Jun 2013 02:59:52 -0700 (PDT)
In-Reply-To: <51CCA67C.2010803@gmail.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com> <51CCA67C.2010803@gmail.com>
From:   Grant Likely <grant.likely@linaro.org>
Date:   Fri, 28 Jun 2013 10:59:52 +0100
X-Google-Sender-Auth: 3BUClTNAHcKgAMhAJZH4TH_VULo
Message-ID: <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
To:     Rob Herring <robherring2@gmail.com>
Cc:     Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
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
        Rob Herring <rob.herring@calxeda.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        linux-mips <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org,
        devicetree-discuss <devicetree-discuss@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQmUfP3uLoi9TwQoHbvCPgOtfsztfoAAxn4e7ztQ8XRMj1adTntX5tppup7Iy2sTLGrWJdzq
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Thu, Jun 27, 2013 at 9:54 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 06/21/2013 12:20 PM, Santosh Shilimkar wrote:
>> On Friday 21 June 2013 05:04 AM, Sebastian Andrzej Siewior wrote:
>>> On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
>>>> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
>>>> index 0a2c68f..62e2e8f 100644
>>>> --- a/arch/microblaze/kernel/prom.c
>>>> +++ b/arch/microblaze/kernel/prom.c
>>>> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
>>>>  }
>>>>
>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>>> -           unsigned long end)
>>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>>>  {
>>>>     initrd_start = (unsigned long)__va(start);
>>>>     initrd_end = (unsigned long)__va(end);
>>>
>>> I think it would better to go here for phys_addr_t instead of u64. This
>>> would force you in of_flat_dt_match() to check if the value passed from
>>> DT specifies a memory address outside of 32bit address space and the
>>> kernel can't deal with this because its phys_addr_t is 32bit only due
>>> to a Kconfig switch.
>>>
>>> For x86, the initrd has to remain in the 32bit address space so passing
>>> the initrd in the upper range would violate the ABI. Not sure if this
>>> is true for other archs as well (ARM obviously not).
>>>
>> That pretty much means phys_addr_t. It will work for me as well but
>> in last thread from consistency with memory and reserved node, Rob
>> insisted to keep it as u64. So before I re-spin another version,
>> would like to here what Rob has to say considering the x86 requirement.
>>
>> Rob,
>> Are you ok with phys_addr_t since your concern was about rest
>> of the memory specific bits of the device-tree code use u64 ?
>
> No. I still think it should be u64 for same reasons I said originally.

+1

g.
