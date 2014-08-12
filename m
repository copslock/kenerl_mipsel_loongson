Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 20:03:41 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:56739 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854401AbaHLSDjAg-DD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 20:03:39 +0200
Received: by mail-ig0-f170.google.com with SMTP id h3so8783853igd.1
        for <linux-mips@linux-mips.org>; Tue, 12 Aug 2014 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sFzdjP0vfUlOic84hcjbyNo8yoxAdwPVGYwoEtZXWZQ=;
        b=lqdo/2TVlC453nvazyBrtlw2o+ewQcZejt2WYERxrVDmIoIRgvjyzuagaNvdBNIU7B
         Ssemqx/+wJsMo8BXsufTnLe03dAk8emF/3ZtdCUyVr1YCoYAkmUxDg/PbRnJTnKGws4D
         wRDxY7ILBoba+8Ll7AobVIvqfleJ7RopckOAcp1ZhuXsWmw7QvVrBdJUxzcaKwZZE4qy
         tIUhXsSQAKXe7qHdGUDDErClgCi4UlvittD48+GStIft6lMazTexAPyTeifSIfASspk7
         d2rVt6HjZ359G3Ptlhi2a2qpLcJ9EwzZEInlYxM9APlKbcfEDU0y34KS+XpOt77XRr5i
         mARA==
X-Received: by 10.42.201.134 with SMTP id fa6mr180495icb.73.1407866611569;
 Tue, 12 Aug 2014 11:03:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.148.135 with HTTP; Tue, 12 Aug 2014 11:02:51 -0700 (PDT)
In-Reply-To: <20140812072353.GC12230@mchandras-linux.le.imgtec.org>
References: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
 <1405677093-22591-4-git-send-email-markos.chandras@imgtec.com>
 <53E00F39.7@gmail.com> <20140812072353.GC12230@mchandras-linux.le.imgtec.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 12 Aug 2014 11:02:51 -0700
Message-ID: <CAGVrzcbZGUbkb=wXp7xwaobpVvzWkr++6L+rErXDyu+3W==6YA@mail.gmail.com>
Subject: Re: [PATCH 3/4] MIPS: cpu-probe: Set the write-combine CCA value on
 per core basis
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42025
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

Hi Markos,

2014-08-12 0:23 GMT-07:00 Markos Chandras <markos.chandras@imgtec.com>:
> Hi Florian,
>
> On Mon, Aug 04, 2014 at 03:54:49PM -0700, Florian Fainelli wrote:
>> Hi Markos,
>>
>> On 07/18/2014 02:51 AM, Markos Chandras wrote:
>> > Different cores use different CCA values to achieve write-combine
>> > memory writes. For cores that do not support write-combine we
>> > set the default value to CCA:2 (uncached, non-coherent) which is the
>> > default value as set by the kernel.
>> >
>> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> > ---
>> [snip]
>>                       break;
>> > @@ -765,67 +767,83 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>> >
>> >  static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
>> >  {
>> > +   c->writecombine = _CACHE_UNCACHED_ACCELERATED;
>>
>> Why do we set this writecombine setting by default, when later we are
>> going to override writecombine on a per-cpu basic.
>>
>> In the end, we have the following:
>>
>> cpu_probe()
>>       c->writecombine = _CACHE_UNCACHED;
>>
>>       cpu_probe_mips()
>>               c->writecombine = _CACHE_UNCACHED_ACCELERATED:
>>               ... per-cpu case ...
>>               c->writecombine = _CACHE_UNCACHED;
>>
>> Can't we just eliminate the various assignments in cpu_probe_mips() and
>> only override c->writecombine if _CACHE_UNCACHED is not suitable?
>>
> The reason I did it like this, is that new cores (eg *Aptiv family) will use
> _CACHE_UNCACHED_ACCELERATED and that's why it's the 'default' option for
> the MIPS cores. _CACHE_UNCACHED is only suitable for old cores.
> The way it is right now, allows us to not have to set this option whenever we
> add support for a new core since it will inherit the default option.

Ok, that makes sense, although we currently have more _CACHE_UNCACHED
platforms supported than _CACHE_UNCACHED_ACCELERATED, so maybe once
you reach a critical number of Aptiv cores or with similar caching
settings, we can reverse the tendency by then? This is not a strong
objection, I was just looking at a way to minimize the changes.
-- 
Florian
