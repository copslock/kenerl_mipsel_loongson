Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 04:21:33 +0100 (CET)
Received: from mail-ot0-x243.google.com ([IPv6:2607:f8b0:4003:c0f::243]:36315
        "EHLO mail-ot0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990686AbdBFDVZdCFQR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 04:21:25 +0100
Received: by mail-ot0-x243.google.com with SMTP id 36so8985988otx.3;
        Sun, 05 Feb 2017 19:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bFYKcoqZJOMBwksH/sTkjAV4N58q1d/ShtlNCgV++wQ=;
        b=tVFCFke5N9aae8ImIKjkw3mVDIR1PFVbrF6pV3ZdSCljsJ2eFauFgIxcvySMzo4Cv5
         mM4ljNABwEMuqGbNttZbmF6YzzlX1sH2RexQC8Hed8taGeKBjGBOgKhuBBr3xoTBwLFW
         UgRH0HvuJPbluU0MyJcp2ps9/kn1yPA+Lc4rKCSPlm6j28KQ7pTEyHydaFV6GHtDIhHU
         2AGLgLT/dThSgBl9Y4XUd9XnPCHi4bgGumNvjRV7UWMxxNOZBKMWsA9Fdt+5S7Y7jCro
         HXStLWhxjYpcOoJm4SK/X3GKnXysfelNtE1zmcOLSku/v9CnDZBIqB9x3qdrvvhdsryr
         TiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bFYKcoqZJOMBwksH/sTkjAV4N58q1d/ShtlNCgV++wQ=;
        b=aOx737H7GbJwYEKxPcdReFcFqASGmkRuUhPjfE9A9Mb+nCT3aqp+zCFZsrf2ZK0sSi
         gWqLbmpb4r3+1hCdnxhGFLxuGHV61aRUrNPMzhcV0RwD8RKbZFhd1GzYzDCBxEj6Iacl
         F5VqNS8K7hElz6vbFsFGHH39QWdSrGd2o/s7kQWIFJNMZGRXt0okZ78APJsbORftKdui
         /2QpCznrG5fcEuAGgLXr6bFQ5Ho+7VP6suIc61pnJpKOVB9XZsQU8kjuQZ57zIXf461L
         JzXgUT5FYU3oC0+5THc0++Lr+uRLNWD8BqcaS/YN0fQKT1V7rXbn9THT8414iyEigprL
         7N1g==
X-Gm-Message-State: AMke39nviuOWGc5T99PBiL/UIWw0Ibot1JTElUP/QdFoXNq3zmrZP+IxUOpj51tE2lW87w==
X-Received: by 10.157.15.221 with SMTP id m29mr3719097otd.186.1486351279490;
        Sun, 05 Feb 2017 19:21:19 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:c4b8:8a31:56c4:3437? ([2001:470:d:73f:c4b8:8a31:56c4:3437])
        by smtp.googlemail.com with ESMTPSA id y43sm18565869otd.38.2017.02.05.19.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2017 19:21:18 -0800 (PST)
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1486147623.22276.70.camel@perches.com>
 <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
 <1486148236.22276.72.camel@perches.com> <20170203203609.GA14271@kroah.com>
 <50640771-abc2-dd9a-7418-7393afe23cd5@gmail.com>
 <20170203204427.GA14959@kroah.com>
 <5eb18f9b-d27c-3f35-9748-81e4ea2d2d70@gmail.com>
 <20170204080815.GA15555@kroah.com>
Cc:     Joe Perches <joe@perches.com>,
        "Jayachandran C." <c.jayachandran@gmail.com>,
        devel@driverdev.osuosl.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4ffd9c56-48b0-7e8d-c83a-6a335deeecb4@gmail.com>
Date:   Sun, 5 Feb 2017 19:21:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170204080815.GA15555@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56646
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

Le 02/04/17 à 00:08, Greg KH a écrit :
> On Fri, Feb 03, 2017 at 06:37:02PM -0800, Florian Fainelli wrote:
>>
>>
>> On 02/03/2017 12:44 PM, Greg KH wrote:
>>> On Fri, Feb 03, 2017 at 12:38:45PM -0800, Florian Fainelli wrote:
>>>> On 02/03/2017 12:36 PM, Greg KH wrote:
>>>>> On Fri, Feb 03, 2017 at 10:57:16AM -0800, Joe Perches wrote:
>>>>>> On Fri, 2017-02-03 at 10:50 -0800, Florian Fainelli wrote:
>>>>>>> (with JC's other email)
>>>>>>
>>>>>> And now with Greg's proper email too
>>>>>>
>>>>>>> On 02/03/2017 10:47 AM, Joe Perches wrote:
>>>>>>>> 64 bit stats isn't implemented, but is that really necessary?
>>>>>>>> Anything else?
>>>>>>>
>>>>>>> Joe, do you have such hardware that you are interested in getting
>>>>>>> supported, or was that just to reduce the amount of drivers in staging?
>>>>>>> I am really not clear about what happened to that entire product line,
>>>>>>> and whether there is any interest in having anything supported these days...
>>>>>>
>>>>>> No hardware.  Just to reduce staging driver count.
>>>>>
>>>>> Without hardware or a "real" maintainer, it shouldn't be moved.
>>>>>
>>>>> Heck, if no one has the hardware, let's just delete the thing.
>>>>
>>>> I do have one, and other colleagues have some too, but I am not heavily
>>>> using it, nor do I have many cycles to spend on that... sounds like we
>>>> could keep it in staging for another 6 months and see what happens then?
>>>
>>> Well, if it works for you, want to maintain it?  :)
>>
>> I'd have to locate the documentation first, and you would have to reply
>> to my patch series about DSA ;)
> 
> I don't have any patch series in my queue, sorry, so I have no idea what
> you are talking about...

You don't really? How about this patch series:

https://www.mail-archive.com/netdev@vger.kernel.org/msg147917.html

and me asking you another time to provide feedback:

https://www.mail-archive.com/netdev@vger.kernel.org/msg150885.html
-- 
Florian
