Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 23:44:10 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:34841
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992236AbdBJWoDei2Tt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 23:44:03 +0100
Received: by mail-wr0-x241.google.com with SMTP id o16so16548719wra.2;
        Fri, 10 Feb 2017 14:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E9HanZaswFeBrNzyB1XkzvxNRiWX5LB2nT43Xo81XO4=;
        b=skBoKceFyOazoJLrfwqHyE9Cr/hn+LjELWB3qXkIJg3NA142+5h2IZkq9oTYXZQGqR
         +c33eCEkJuyrLpYaGo+cEva1yrKFlJEQ+9ytuMubn9hCjv7cJoZtBKYdJ8RvOagCOi5j
         SLq/mJ0M3C9iRJO8d0Au4o9f1zLZd+pAji6B6VyXncjtEgx/5qe7RX2HiC3see3WAKi+
         g0RN4by7otLUZ6/kKxGoGJewpl/plykyMlzajQ6FWwKq6iTpxvOZQ+I4gFgRb3NKveYr
         WCQkpG9rdj1mKZHrJGjoYzruhptTbWRY3juUidffge5ZiUrG7z96i7TQRH5iw++hBK/R
         I8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E9HanZaswFeBrNzyB1XkzvxNRiWX5LB2nT43Xo81XO4=;
        b=oQnNe9hVBSNh7PHesrWDwP0eQ9l8aqjW/w9BLZyoqckjkczBBIraFV1+bADaLB1Vmt
         bqt5j0RV402L47L6NO3Jf2r2uKHGWeGmMpZA1PPLzZNaoN2a7WO+jPS7XKLcPGwXz3lk
         IyJaozLfDsMJo4wfyeoiZXOcs8VsE5YJf+Ij6+cNx6Ar0Gj/U+DpmcPyRYY2hpAWXCun
         giVETTo9mmFR9/b7d0DpRaO9u+uQQX8C30QIQbNXGLlJNxaIBhYlmWPJZ7PlXvxkZb8N
         BYLqA5i87KJpYPKhNM7LZ2M6jMmNcMBYu5ECPGR2VQJbAVXguE5x1otXFhyhNunU2eJj
         eQ2g==
X-Gm-Message-State: AMke39lkxfU/ev1QCSTLCAByhe0R2TrlRhegbBPz57ZT7N5iQkew9fhh1cRMEYaVcfZBEw==
X-Received: by 10.223.134.218 with SMTP id 26mr9460698wry.104.1486766635336;
        Fri, 10 Feb 2017 14:43:55 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id o143sm3173988wmd.3.2017.02.10.14.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 14:43:54 -0800 (PST)
Subject: Re: Crash in -next due to 'MIPS: Add cacheinfo support'
To:     James Hogan <james.hogan@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20170208234523.GA13263@roeck-us.net>
 <CAJx26kWDuH2AbibrOdHi7yh9YG314T7J5Zz7CwgTrZCfwDGuYw@mail.gmail.com>
 <eee97bba-5386-9d78-1c82-9e9753a28920@roeck-us.net>
 <20170210094011.GB24226@jhogan-linux.le.imgtec.org>
 <20170210103952.GC24226@jhogan-linux.le.imgtec.org>
 <20170210174644.GA15372@roeck-us.net>
 <6360d767-39f9-ad9b-6ca4-cb16c617e3cc@gmail.com>
 <20170210221152.GA20435@roeck-us.net>
 <20170210223932.GA9246@jhogan-linux.le.imgtec.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Ralf Baechle <ralf@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <15bd90f8-5481-0540-7ae8-30f199587d5b@gmail.com>
Date:   Fri, 10 Feb 2017 14:43:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170210223932.GA9246@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 02/10/2017 02:39 PM, James Hogan wrote:
> On Fri, Feb 10, 2017 at 02:11:52PM -0800, Guenter Roeck wrote:
>> On Fri, Feb 10, 2017 at 11:15:31AM -0800, Florian Fainelli wrote:
>>> On 02/10/2017 09:46 AM, Guenter Roeck wrote:
>>>> On Fri, Feb 10, 2017 at 10:39:52AM +0000, James Hogan wrote:
>>>>> On Fri, Feb 10, 2017 at 09:40:11AM +0000, James Hogan wrote:
>>>>>> Hi Guenter,
>>>>>>
>>>>>> On Thu, Feb 09, 2017 at 08:50:04PM -0800, Guenter Roeck wrote:
>>>>>>> On 02/09/2017 04:01 PM, Justin Chen wrote:
>>>>>>>> Hello Guenter,
>>>>>>>>
>>>>>>>> I am unable to reproduce the problem. May you give me more details?
>>>>>>>>
>>>>>>> The scripts I am using are available at
>>>>>>>
>>>>>>> https://github.com/groeck/linux-build-test/tree/master/rootfs
>>>>>>>
>>>>>>> in the mips and mipsel subdirectories (both crash). Individual
>>>>>>> build logs are always available at kerneltests.org/builders,
>>>>>>> in the 'next' column.
>>>>>>
>>>>>> Did you find it 100% reproducible? I was trying to reproduce yesterday
>>>>>> evening, and did hit it a few times, but then it stopped happening
>>>>>> before I could try and figure out what was going wrong.
>>>>>
>>>>> I switched to gcc 5.2 (buildroot toolchain) for building kernel, and now
>>>>> it reproduces every time :)
>>>>>
>>>> gcc 5.4.0 (binutils 2.26.1) also reliably crashes. The exact crash depends on
>>>> the kernel (-next is different to ToT + offending patch, qemu command line
>>>> makes a difference, qemu version makes a difference), but the crash is easy
>>>> to reproduce, at least for me.
>>>
>>> Just to clarify here, is the crash a combination of:
>>>
>>> - the kernel image, based on different trees/branches
>>
>> I tried with linux-next, and I tried with ToT with the offending patch
>> applied. Both fail reliably. Without the patch, both pass reliably.
>>
>>> - different GCC versions
>>
>> I can only say that I see it crashes with both gcc 5.2.0 and gcc 5.4.0.
>>
>>> - different ways of invoking QEMU/QEMU version?
>>>
>> Yes and no. One way of _not_ (or maybe not always) seeing this crash
>> is to use the bare-bone command line with qemu 2.7 or 2.8 (with no
>> root file system provided). This crashes because there is no root file
>> system, but not as described earlier. It does crash, though, when
>> providing a more comprehensive command line. All kernel versions
>> without this patch do not crash.
>>
>> On the other side, blaming this on the qemu command line is akin to
>> saying that a crash only seen if a mouse is connected would be caused
>> by the mouse, so I am not entirely sure if that helps too much.
>> Also see below, regarding heisenbug.
>>
>>> and essentially Justin's commit just made problem 1) to occur, but is
>>> not the root cause of the crash you are seeing?
>>
>> That would not necessarily be my conclusion. Of course, the code appears
>> to be heavily SMP related, so it may well be that it exposes some
>> problem associated with cache handling or support in non-SMP configurations.
>>
>> Of course, it might also be possible that there is a qemu problem somewhere
>> which only manifests itself on non-SMP mips images with Justin's commit
>> applied. That appears to be somewhat unlikely, though I have no hard data
>> supporting this guess.
>>
>> I'll do some more testing and try to find the actual crash location.
>> Tricky though since it almost looks like there is a not completely
>> initialized workqueue. Making things worse, the problem "goes away"
>> if I add some debug log into process_one_work(), meaning there may
>> be a heisenbug.
> 
> cracked it by moving around an early return error. populate_cache()
> macro has multiple statements with no do while (0) around it. The
> c->scache.waysize condition in populate_cache_leaves then only
> conditionalises the first statement in the macro and in absense of l2
> (or l3 for that matter) it'll continue to write beyond the end of the
> array allocated in detect_cache_attributes(). Badness ensues.

Good catch, thanks James!

> 
> The SMP calls in arch/mips/kernel/cacheinfo.c file are pretty redundant
> too since all the cache info is read from the cpu info structures.
> 
> I'll write a patch. Thanks for reporting Guenter!
> 
> Cheers
> James
> 


-- 
Florian
