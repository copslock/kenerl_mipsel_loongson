Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 20:50:29 +0100 (CET)
Received: from mail-wm0-x229.google.com ([IPv6:2a00:1450:400c:c09::229]:36550
        "EHLO mail-wm0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991100AbdLATuSiJXYY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 20:50:18 +0100
Received: by mail-wm0-x229.google.com with SMTP id b76so5260045wmg.1
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2017 11:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RgSR07PVATRN78oubjD0pkKFBP7nnjNAh3Yhqv5u1L8=;
        b=yLY8xGAeILVO+DH/j8rekOc/rtrdugBdCfikABnmcqn8bI6rtfQe9x1v8zrUMCbshM
         krclG3zBTo62EwJJsemxzEvZtQsulMmLp5hrH/rFNiSEBPtEL7MQKjGww+POgXbEc5x1
         geuzZrF83ZRm1jGyExoAbSZpav9+Y2NzwxPD36gq1EoEi88sF8sFdFezTR2FQUxO3mFu
         mM2AIinN7yjpwQZwU72Rlb/bwJd64M/BJsTLyLItrPf9cLEC1mMCTyYlla5qJ0Pg0XzE
         m0xvVR4J7xwClzlYmm4H3ueDJv2Q9HzOqi0Fyq7zmOkkHLKqybB514LtlDz8pap//9Mf
         ifPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RgSR07PVATRN78oubjD0pkKFBP7nnjNAh3Yhqv5u1L8=;
        b=nnu6eWJG3DOoAH0fkKEmiZIYZlPFk+WylKXSOy4omFkszGLn3z0FApC0x3HKS75NDY
         bKOaT5pilVajI+nG/Kl2+Pq40+AjXAMxcf8O06/GoWgJAqwwWODLHk7sKzL4hb8FN3dw
         N3RJLObdA0JtQF2K/CdPUUtyyhPumeRExzYQhy4euoFpxLFBJHW0lI/MCL+yiKlrpF3C
         1JsE8pH7gfBb3krR1kfEuNNTIVn+Hz88z0K1RLKSMhJ0pLX3ZQaAFSkA8xafhfelZh0W
         DtYF0Jd3DWOlsp6HvyiDop1agNWaeeHsCBqWz4+iySPqlLdCR46151k/rk4qJS7yorDE
         ihuQ==
X-Gm-Message-State: AKGB3mIqrhdnjHmPllYLusrWA/lW6a3hzPchQ+AF+zE+YaPfcJANxvG+
        tm6cWmYShL6pIxKXmvxubTxRv7UA2YqDH2MIeJuh3Q==
X-Google-Smtp-Source: AGs4zMZ4YkZFJlepFv+NVK7bCK9AIsyv9YK5CJFrYY2hbaOLOpWfpoda9hM6QGPpWjZNQFFr6ze6Mp7YQxlkLTAP7Nw=
X-Received: by 10.28.207.8 with SMTP id f8mr1922621wmg.30.1512157812056; Fri,
 01 Dec 2017 11:50:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Fri, 1 Dec 2017 11:49:31 -0800 (PST)
In-Reply-To: <99dd185d-6e5d-f474-90aa-ebee63045c42@caviumnetworks.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-4-david.daney@cavium.com> <20171130225333.GI27409@jhogan-linux.mipstec.com>
 <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com> <99dd185d-6e5d-f474-90aa-ebee63045c42@caviumnetworks.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Fri, 1 Dec 2017 20:49:31 +0100
Message-ID: <CAOFm3uEy52yog4H_Hco0X+OHF5yiHUZYAHaGz4MefKcYQz3LUg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
To:     David Daney <ddaney@caviumnetworks.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Carlos Munoz <cmunoz@cavium.com>,
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
X-archive-position: 61265
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

David, Greg,

On Fri, Dec 1, 2017 at 6:42 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 11/30/2017 11:53 PM, Philippe Ombredanne wrote:
[...]
>>>> --- /dev/null
>>>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>>>> @@ -0,0 +1,371 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Resource manager for Octeon.
>>>> + *
>>>> + * This file is subject to the terms and conditions of the GNU General
>>>> Public
>>>> + * License.  See the file "COPYING" in the main directory of this
>>>> archive
>>>> + * for more details.
>>>> + *
>>>> + * Copyright (C) 2017 Cavium, Inc.
>>>> + */
>>
>>
>> Since you nicely included an SPDX id, you would not need the
>> boilerplate anymore. e.g. these can go alright?
>
>
> They may not be strictly speaking necessary, but I don't think they hurt
> anything.  Unless there is a requirement to strip out the license text, we
> would stick with it as is.

I think the requirement is there and that would be much better for
everyone: keeping both is redundant and does not bring any value, does
it? Instead it kinda removes the benefits of having the SPDX id in the
first place IMHO.

Furthermore, as there have been already ~12K+ files cleaned up and
still over 60K files to go, it would really nice if new files could
adopt the new style: this way we will not have to revisit and repatch
them in the future.

-- 
Cordially
Philippe Ombredanne
