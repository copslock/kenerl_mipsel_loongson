Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:34:37 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:36566
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991130AbdLAXeRlaqbp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Dec 2017 00:34:17 +0100
Received: by mail-wr0-x241.google.com with SMTP id v105so11647659wrc.3
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2017 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BcB4cQhWVtwfG/2FQxVokh4kzfSH6QCXWtgF3Vx59pg=;
        b=utGOxbj+igHrTyOCbhNofQNgOF3jcp2X8deo+B2e5+w6QRVO4QQ4PmTUVEMQVZ7yQ/
         1HXk0dUAb7zieseVnnJeJ5DvRD5XzLqQKlzHh6olJvn6js6SOLzmp5ZnUS94dsPtpx2s
         Ez7jHO5f+NL+AWlqkyTPQVeyTLgKKb/mXXsdQXUXN1O2rgXS9+ecJa0j6Wmzd+UedOoy
         ok059cUszidLz3vRxx4Eb2t1D3/BzElFO2sFbnSpMuPzufhcXULFk3rRYhA/mfmVxNwx
         xt0EWiEe9pTq1OP5IpnzSJHSCTueq4Fz00l09K61Wjj3AMaHCXkJ+60gVCKWqk2lNEep
         15PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BcB4cQhWVtwfG/2FQxVokh4kzfSH6QCXWtgF3Vx59pg=;
        b=Y8SpclEwgJy/UyHeeL5WzJbR1ziZhglInsll+9lgefAWzfxSFeTZS5g6HBfeTmyp9L
         i9QlBV/Tu/KHAPk1yVyJEK6rqU2yLHKLBdLJoBADn6xJgyhrUuQcLgu+qfCN0txBi8S9
         cnU13i71mEpw01q/tgwOtvObho3VmWY8M/SX8D1nhfKbojOh28aOgd+MzYoZpbulR9mJ
         8b6ajRYZWccyHidaE/ngP3yXRYMDmLoPNsXN8rDOv1pgOR6yQv7xkgr1fI9uG1neH4YL
         IA9acOfXhhPoxU4m7M05Us4Ie8C9tLUOK+6lKbYHPe5477GASAoqgQISHbpLQEwFLkmY
         3IQQ==
X-Gm-Message-State: AJaThX4l8y92+gx8khNKLWieQpAFauLrxLv1DTiK/U+QFRkNZ4NoopO2
        AoMM8sR059sLF5f6w7yqvwx/Ab4hsW/wdWWiW3B/9Q==
X-Google-Smtp-Source: AGs4zMbEGdmyVOZmpD9VQoXEVZPz7ABodKvylhfWOx7GkV3l/IubhkbIKtvlRgXox2cb1u2uR1R/9vTOPVLgH+8VkYs=
X-Received: by 10.223.160.111 with SMTP id l44mr6919856wrl.259.1512171250710;
 Fri, 01 Dec 2017 15:34:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Fri, 1 Dec 2017 15:33:30 -0800 (PST)
In-Reply-To: <1c34c7f5-4237-0fca-e871-ee18c262a3f3@caviumnetworks.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-4-david.daney@cavium.com> <20171130225333.GI27409@jhogan-linux.mipstec.com>
 <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com>
 <99dd185d-6e5d-f474-90aa-ebee63045c42@caviumnetworks.com> <CAOFm3uEy52yog4H_Hco0X+OHF5yiHUZYAHaGz4MefKcYQz3LUg@mail.gmail.com>
 <2ac5ec17-cedb-5dd8-6ea7-f065025639a9@caviumnetworks.com> <CAOFm3uHSp3ziQ-h1-V9uz07+jiixpgoUB9UZV82fOkrMBk8aZQ@mail.gmail.com>
 <1c34c7f5-4237-0fca-e871-ee18c262a3f3@caviumnetworks.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Sat, 2 Dec 2017 00:33:30 +0100
Message-ID: <CAOFm3uGm3qo5yzb7vhi=5CnLUNw01abMc0uY3WF-Nc6-8=brWg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Munoz <cmunoz@cavium.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@mips.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

On Fri, Dec 1, 2017 at 9:56 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 12/01/2017 12:41 PM, Philippe Ombredanne wrote:
>>
>> David,
>>
>> On Fri, Dec 1, 2017 at 9:01 PM, David Daney <ddaney@caviumnetworks.com>
>> wrote:
>>>
>>> On 12/01/2017 11:49 AM, Philippe Ombredanne wrote:
>>>>
>>>>
>>>> David, Greg,
>>>>
>>>> On Fri, Dec 1, 2017 at 6:42 PM, David Daney <ddaney@caviumnetworks.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On 11/30/2017 11:53 PM, Philippe Ombredanne wrote:
>>>>
>>>>
>>>> [...]
>>>>>>>>
>>>>>>>>
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>>>>>>>> @@ -0,0 +1,371 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>> +/*
>>>>>>>> + * Resource manager for Octeon.
>>>>>>>> + *
>>>>>>>> + * This file is subject to the terms and conditions of the GNU
>>>>>>>> General
>>>>>>>> Public
>>>>>>>> + * License.  See the file "COPYING" in the main directory of this
>>>>>>>> archive
>>>>>>>> + * for more details.
>>>>>>>> + *
>>>>>>>> + * Copyright (C) 2017 Cavium, Inc.
>>>>>>>> + */
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Since you nicely included an SPDX id, you would not need the
>>>>>> boilerplate anymore. e.g. these can go alright?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> They may not be strictly speaking necessary, but I don't think they
>>>>> hurt
>>>>> anything.  Unless there is a requirement to strip out the license text,
>>>>> we
>>>>> would stick with it as is.
>>>>
>>>>
>>>>
>>>> I think the requirement is there and that would be much better for
>>>> everyone: keeping both is redundant and does not bring any value, does
>>>> it? Instead it kinda removes the benefits of having the SPDX id in the
>>>> first place IMHO.
>>>>
>>>> Furthermore, as there have been already ~12K+ files cleaned up and
>>>> still over 60K files to go, it would really nice if new files could
>>>> adopt the new style: this way we will not have to revisit and repatch
>>>> them in the future.
>>>>
>>>
>>> I am happy to follow any style Greg would suggest.  There doesn't seem to
>>> be
>>> much documentation about how this should be done yet.
>>
>>
>> Thomas (tglx) has already submitted a first series of doc patches a
>> few weeks ago. And AFAIK he might be working on posting the updates
>> soon, whenever his real time clock yields a few cycles away from real
>> time coding work ;)
>>
>> See also these discussions with Linus [1][2][3], Thomas[4] and Greg[5]
>> on this and mostly related topics
>>
>> [1] https://lkml.org/lkml/2017/11/2/715
>> [2] https://lkml.org/lkml/2017/11/25/125
>> [3] https://lkml.org/lkml/2017/11/25/133
>> [4] https://lkml.org/lkml/2017/11/2/805
>> [5] https://lkml.org/lkml/2017/10/19/165
>>
>
> OK, you convinced me.
>
> Thanks,
> David
>

No! Thank you to you: For doing real work on the kernel that makes my
servers and laptops run, while I am nitpicking you on comments.

-- 
Cordially
Philippe Ombredanne
