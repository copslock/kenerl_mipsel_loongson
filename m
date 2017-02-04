Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Feb 2017 03:37:11 +0100 (CET)
Received: from mail-ot0-x243.google.com ([IPv6:2607:f8b0:4003:c0f::243]:35403
        "EHLO mail-ot0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbdBDChFDD0kC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Feb 2017 03:37:05 +0100
Received: by mail-ot0-x243.google.com with SMTP id 65so4278440otq.2;
        Fri, 03 Feb 2017 18:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QGRdBBgrcfm5c7Z8pO9aYvMmhQFBhdps2pmkadqf6bE=;
        b=hvP5TjrVjlVzw+eJDEDZg8HQIRoVuCu3kmuJ2vA+KS9nvRK+QBgyAR1EAutU4/HUzQ
         xVejcbOYoVr67cj81JxeoKbhUg/A5kefsD3gh5DRDeMXEn2Dx6FKvkTTWWnPkqVayBdO
         xe3gV2/ZXmhnHnY5tfRCHcjEDcjuAiVLKICASLPKfGX1UxjMEa2i/nstvDC/sP+iTLn6
         snheQ8hrs9biG/GgSm1GVB/RrKGZBUdFw9Y9RiXqec9/sW7XaGKGNET6yxtlCpFBsVH0
         TewlSXEh4v4yrEF9LC/p5Kd+iQETyNv7OzphbuNu2IULU1pZy5J+pGLCR4RkZiQdw0EI
         0/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QGRdBBgrcfm5c7Z8pO9aYvMmhQFBhdps2pmkadqf6bE=;
        b=ug7HFBNnKIS0XHAYh1Bx/8mKjivC2E6aT+K43p8ftV1CWEyowc4H/7N2WSyPQAR0tj
         mzeC96lkkTT0d3BLH+00CoMxfYRUJ+34vMABho7dXqkK5MPBedKcFl2hl2qyps26qYx5
         fuvwtOuHd1hfFmmbk6jwOclt/kXAdsEFj6YgMLQJ0GjKg72sXz5HBY+Ss3iOl8JPH391
         ELEkBzie03tc8gXqaTTDMQJrEyWv+QQdUqlIOuWPSzPwpe5j8Z1ocsMc+eGvXD3/RFV3
         6/HJUBkDUeTMnmH+FXpMHBlXrdHK3TobxNVSktoyVcXwT9rZH9SV/XuicpU+5XDBb4I+
         owYw==
X-Gm-Message-State: AMke39kdcoy78JZFcg1Q041FVgHvQ+Er/44+aLOIzmkOMtk6dgN0aHfx02a6u5mZKXqvdA==
X-Received: by 10.157.30.194 with SMTP id n60mr87783otn.148.1486175819196;
        Fri, 03 Feb 2017 18:36:59 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:c1bf:596d:f44e:5a90? ([2001:470:d:73f:c1bf:596d:f44e:5a90])
        by smtp.gmail.com with ESMTPSA id x1sm15373490oif.19.2017.02.03.18.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 18:36:58 -0800 (PST)
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1486147623.22276.70.camel@perches.com>
 <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
 <1486148236.22276.72.camel@perches.com> <20170203203609.GA14271@kroah.com>
 <50640771-abc2-dd9a-7418-7393afe23cd5@gmail.com>
 <20170203204427.GA14959@kroah.com>
Cc:     Joe Perches <joe@perches.com>,
        "Jayachandran C." <c.jayachandran@gmail.com>,
        devel@driverdev.osuosl.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5eb18f9b-d27c-3f35-9748-81e4ea2d2d70@gmail.com>
Date:   Fri, 3 Feb 2017 18:37:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170203204427.GA14959@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56635
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



On 02/03/2017 12:44 PM, Greg KH wrote:
> On Fri, Feb 03, 2017 at 12:38:45PM -0800, Florian Fainelli wrote:
>> On 02/03/2017 12:36 PM, Greg KH wrote:
>>> On Fri, Feb 03, 2017 at 10:57:16AM -0800, Joe Perches wrote:
>>>> On Fri, 2017-02-03 at 10:50 -0800, Florian Fainelli wrote:
>>>>> (with JC's other email)
>>>>
>>>> And now with Greg's proper email too
>>>>
>>>>> On 02/03/2017 10:47 AM, Joe Perches wrote:
>>>>>> 64 bit stats isn't implemented, but is that really necessary?
>>>>>> Anything else?
>>>>>
>>>>> Joe, do you have such hardware that you are interested in getting
>>>>> supported, or was that just to reduce the amount of drivers in staging?
>>>>> I am really not clear about what happened to that entire product line,
>>>>> and whether there is any interest in having anything supported these days...
>>>>
>>>> No hardware.  Just to reduce staging driver count.
>>>
>>> Without hardware or a "real" maintainer, it shouldn't be moved.
>>>
>>> Heck, if no one has the hardware, let's just delete the thing.
>>
>> I do have one, and other colleagues have some too, but I am not heavily
>> using it, nor do I have many cycles to spend on that... sounds like we
>> could keep it in staging for another 6 months and see what happens then?
> 
> Well, if it works for you, want to maintain it?  :)

I'd have to locate the documentation first, and you would have to reply
to my patch series about DSA ;)
-- 
Florian
