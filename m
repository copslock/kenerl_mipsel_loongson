Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 20:15:47 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:33515
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992110AbdBJTPkGA4p0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 20:15:40 +0100
Received: by mail-qk0-x244.google.com with SMTP id 11so6333972qkl.0;
        Fri, 10 Feb 2017 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=byET5jzKCEf0VxNT/OHeLavmhqNDBvUbtFYqpTn/yDg=;
        b=d0cKSML1mBXj7UHUwxfxJn3nyFW6TW4zn7uW+xpYiAETSa2w5iA0PLZRz8bU3VwJRe
         QUuTt5ZXUlgc/CIidSqIsC8kPrcrVo+40zQxp+4OKuI0VhvFDtwB/DCGUWvUSmISD8Js
         j5mandg+Tg88NxeJ+SC6oVtsNXlsjcprxFVEkvxFQBPF0X/NNoggNdKhQVXgKFSC558h
         3RsTLJXYT8Jmty+287/qterZFmccvOIhx1VxIIzXUjXGtKZy1g/1qf5EHYxP21S0ybAp
         PyY/prUz+fT9PEawNmIoyrsMIkzcYr+OZNyOJCJVZNr9vPVSj5ezBvDMNrUlxoMRUwC7
         UhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=byET5jzKCEf0VxNT/OHeLavmhqNDBvUbtFYqpTn/yDg=;
        b=p+JhC4oEk0fysXREUPf7mmEmbeWpAkRBagERNiNL3kGpyXkNsBE4c9VwS1vz7tvqeN
         2OsKWR7sVtmmetyJhY15dmqpq+XyosWbtKMPCSrvlrZvUWHFM3GCOnLH0JHTAPfRD75v
         lpXlAhFRCC6YFUD/zQ5MrALVpcyqq9FKEby+dxY3eWbd04RumWDUoB87jAP/RNdUlEGa
         KXBRHzQYawILZ7/bPXbQJQwvMl4M9OgeqWTv0iWqDcHFzDgmLtL4CtumCWrmrJ66xcRx
         vjmI2knP2ZB/K1Yra4BYSABtMlbu6XUOS1KXilYZ9k25A9v4yiYQbCazvubGOs97M0aJ
         WC5A==
X-Gm-Message-State: AMke39kmnefVDtPQn37Mj5PpOiWVCyshcnSHSwsXbyUREaTDvH+BBmar5r1K6Dg1zBx2HA==
X-Received: by 10.55.76.18 with SMTP id z18mr9111717qka.263.1486754134305;
        Fri, 10 Feb 2017 11:15:34 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id u49sm2184582qtc.44.2017.02.10.11.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 11:15:33 -0800 (PST)
Subject: Re: Crash in -next due to 'MIPS: Add cacheinfo support'
To:     Guenter Roeck <linux@roeck-us.net>,
        James Hogan <james.hogan@imgtec.com>
References: <20170208234523.GA13263@roeck-us.net>
 <CAJx26kWDuH2AbibrOdHi7yh9YG314T7J5Zz7CwgTrZCfwDGuYw@mail.gmail.com>
 <eee97bba-5386-9d78-1c82-9e9753a28920@roeck-us.net>
 <20170210094011.GB24226@jhogan-linux.le.imgtec.org>
 <20170210103952.GC24226@jhogan-linux.le.imgtec.org>
 <20170210174644.GA15372@roeck-us.net>
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Ralf Baechle <ralf@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6360d767-39f9-ad9b-6ca4-cb16c617e3cc@gmail.com>
Date:   Fri, 10 Feb 2017 11:15:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170210174644.GA15372@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56761
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

On 02/10/2017 09:46 AM, Guenter Roeck wrote:
> On Fri, Feb 10, 2017 at 10:39:52AM +0000, James Hogan wrote:
>> On Fri, Feb 10, 2017 at 09:40:11AM +0000, James Hogan wrote:
>>> Hi Guenter,
>>>
>>> On Thu, Feb 09, 2017 at 08:50:04PM -0800, Guenter Roeck wrote:
>>>> On 02/09/2017 04:01 PM, Justin Chen wrote:
>>>>> Hello Guenter,
>>>>>
>>>>> I am unable to reproduce the problem. May you give me more details?
>>>>>
>>>> The scripts I am using are available at
>>>>
>>>> https://github.com/groeck/linux-build-test/tree/master/rootfs
>>>>
>>>> in the mips and mipsel subdirectories (both crash). Individual
>>>> build logs are always available at kerneltests.org/builders,
>>>> in the 'next' column.
>>>
>>> Did you find it 100% reproducible? I was trying to reproduce yesterday
>>> evening, and did hit it a few times, but then it stopped happening
>>> before I could try and figure out what was going wrong.
>>
>> I switched to gcc 5.2 (buildroot toolchain) for building kernel, and now
>> it reproduces every time :)
>>
> gcc 5.4.0 (binutils 2.26.1) also reliably crashes. The exact crash depends on
> the kernel (-next is different to ToT + offending patch, qemu command line
> makes a difference, qemu version makes a difference), but the crash is easy
> to reproduce, at least for me.

Just to clarify here, is the crash a combination of:

- the kernel image, based on different trees/branches
- different GCC versions
- different ways of invoking QEMU/QEMU version?

and essentially Justin's commit just made problem 1) to occur, but is
not the root cause of the crash you are seeing?
-- 
Florian
