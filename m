Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 21:42:04 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:41012
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991100AbdLAUlvwCCpb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 21:41:51 +0100
Received: by mail-wm0-x241.google.com with SMTP id g75so5697198wme.0
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2017 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4+X9+o/tz2R/6IjoGdMUVbmQPrRnsDsZV0IuNNQx460=;
        b=fjaGv3V32IgnuxzuCZle0iqO/GO0kA04N6tK6r08Sxgr1w4ZGumN1lLp+n/XxxMDAv
         JQfNMmGVSO7UeA3L3viv5efRVmwypZv6OkSN2vQA8himM4koIsSADJjHMzsfd24Q7z4a
         Wtwp9AeGf71oWXjaH9wU1Wj2w3awlCuKv46erI5zmalkdbDKhfI4c2zUrV+pLopii+At
         C78nXXn6WW+X8ePzoM7dx4nUKhgLHvjUgvw/KOigC8t61ChMooda3Crx5MarEVBBLOl5
         uSg3+nA2vr81/5zcd4BwDZqeV4o88xGChifcMxMDUPIdBIjHbcRaL6OxWeQTvllvifBD
         9Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4+X9+o/tz2R/6IjoGdMUVbmQPrRnsDsZV0IuNNQx460=;
        b=K5bNsZWPa6AzdU271znnSX/7kuycPX0bW1bNuX/9h2XMEDWrjXnZkAEj00Obd6y3X/
         uLg7YxAOgNbcBklMxNcS3MWYqKJg8O1arnNYF88rgLu7FHtwKzuS5ToIfeDlvOT1q/A4
         Zxy/jiScgAcr9tFvcvRdNA5d0RknGbymm/XD3PavgQ3KIPyD5LFppjLAOBs3J2/DQsUr
         WK9+rbVtCau+x6Jp1qth0UeBfTBqqktnUmIcYOqvm+FrzAXG6Tq4nXJgXrEEyN8zYD3s
         VlQBFOKO5nIqLdpUDWF8/FMjR9PyPm0KzIjs7DjP1AWetQT30Wiv50HeT8dORBA+XxgS
         aSzg==
X-Gm-Message-State: AKGB3mI6c+blalFjydIUJj5IsgfKNn5LnCkvUgBRDEsCJ2ojiPW0P9Ri
        QRw6adVCSiIA1FrgEnGrzyo7MndAoxn1HOnjXkGj7w==
X-Google-Smtp-Source: AGs4zMbfXQ8daKqFkGIdEYbzfeG/F0pLZqhCIB2xY947lqQFPXV3GdRKS4VBKx99W1ixwJPhW24KU9NCigrS7VytYTw=
X-Received: by 10.28.207.8 with SMTP id f8mr1991182wmg.30.1512160906416; Fri,
 01 Dec 2017 12:41:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Fri, 1 Dec 2017 12:41:05 -0800 (PST)
In-Reply-To: <2ac5ec17-cedb-5dd8-6ea7-f065025639a9@caviumnetworks.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-4-david.daney@cavium.com> <20171130225333.GI27409@jhogan-linux.mipstec.com>
 <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com>
 <99dd185d-6e5d-f474-90aa-ebee63045c42@caviumnetworks.com> <CAOFm3uEy52yog4H_Hco0X+OHF5yiHUZYAHaGz4MefKcYQz3LUg@mail.gmail.com>
 <2ac5ec17-cedb-5dd8-6ea7-f065025639a9@caviumnetworks.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Fri, 1 Dec 2017 21:41:05 +0100
Message-ID: <CAOFm3uHSp3ziQ-h1-V9uz07+jiixpgoUB9UZV82fOkrMBk8aZQ@mail.gmail.com>
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
X-archive-position: 61267
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

David,

On Fri, Dec 1, 2017 at 9:01 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 12/01/2017 11:49 AM, Philippe Ombredanne wrote:
>>
>> David, Greg,
>>
>> On Fri, Dec 1, 2017 at 6:42 PM, David Daney <ddaney@caviumnetworks.com>
>> wrote:
>>>
>>> On 11/30/2017 11:53 PM, Philippe Ombredanne wrote:
>>
>> [...]
>>>>>>
>>>>>> --- /dev/null
>>>>>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>>>>>> @@ -0,0 +1,371 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * Resource manager for Octeon.
>>>>>> + *
>>>>>> + * This file is subject to the terms and conditions of the GNU
>>>>>> General
>>>>>> Public
>>>>>> + * License.  See the file "COPYING" in the main directory of this
>>>>>> archive
>>>>>> + * for more details.
>>>>>> + *
>>>>>> + * Copyright (C) 2017 Cavium, Inc.
>>>>>> + */
>>>>
>>>>
>>>>
>>>> Since you nicely included an SPDX id, you would not need the
>>>> boilerplate anymore. e.g. these can go alright?
>>>
>>>
>>>
>>> They may not be strictly speaking necessary, but I don't think they hurt
>>> anything.  Unless there is a requirement to strip out the license text,
>>> we
>>> would stick with it as is.
>>
>>
>> I think the requirement is there and that would be much better for
>> everyone: keeping both is redundant and does not bring any value, does
>> it? Instead it kinda removes the benefits of having the SPDX id in the
>> first place IMHO.
>>
>> Furthermore, as there have been already ~12K+ files cleaned up and
>> still over 60K files to go, it would really nice if new files could
>> adopt the new style: this way we will not have to revisit and repatch
>> them in the future.
>>
>
> I am happy to follow any style Greg would suggest.  There doesn't seem to be
> much documentation about how this should be done yet.

Thomas (tglx) has already submitted a first series of doc patches a
few weeks ago. And AFAIK he might be working on posting the updates
soon, whenever his real time clock yields a few cycles away from real
time coding work ;)

See also these discussions with Linus [1][2][3], Thomas[4] and Greg[5]
on this and mostly related topics

[1] https://lkml.org/lkml/2017/11/2/715
[2] https://lkml.org/lkml/2017/11/25/125
[3] https://lkml.org/lkml/2017/11/25/133
[4] https://lkml.org/lkml/2017/11/2/805
[5] https://lkml.org/lkml/2017/10/19/165

-- 
Cordially
Philippe Ombredanne
