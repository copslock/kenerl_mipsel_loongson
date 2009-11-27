Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 05:45:30 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:63627 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492036AbZK0Ep1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2009 05:45:27 +0100
Received: by yxe31 with SMTP id 31so1057299yxe.21
        for <multiple recipients>; Thu, 26 Nov 2009 20:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UjrkyaCu/519Ro70cXVykuoGOIntb1jGTKYyawFu0Cc=;
        b=UC5O31fjyBCgsyqsJkb0+gsazN0ngXIJ+cn1ND4kcq0iMAIiihwh+QfSlsqHmCelVW
         pH8UqSUfvfzC1pReGBLRr2BKNIEiyJJObVu9fTWf2Y+QBsso5cyOYeGbDPoxCERZ9qOM
         zQQ3f+WgrW4K3YPZNL7O8jA4alsG1p17UXTTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=G9IKn84r3UT2YdDL/t69gCrEnOrA7mhvRuB78E1AdDVdkyt2DC5i2NA80tCioE7QiE
         QG6ddseWWSK9VjCRgl/4FI4k1264WHttmxxww0pYatT3tm6VdbnUeNW0whU2T0WLgE2L
         7fOS10gBsJr9z7519cJSzbXkLGeDYaKUFbNN4=
Received: by 10.91.203.25 with SMTP id f25mr937095agq.13.1259297120438;
        Thu, 26 Nov 2009 20:45:20 -0800 (PST)
Received: from dd_xps.caveonetworks.com (adsl-68-122-43-200.dsl.pltn13.pacbell.net [68.122.43.200])
        by mx.google.com with ESMTPS id 23sm665694yxe.18.2009.11.26.20.45.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 20:45:19 -0800 (PST)
Message-ID: <4B0F595C.5000204@gmail.com>
Date:   Thu, 26 Nov 2009 20:45:16 -0800
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Thunderbird/3.0b4
MIME-Version: 1.0
To:     wuzhangjin@gmail.com, Ralf Baechle <ralf@linux-mips.org>
CC:     Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v5] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
References: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>         <4B0A8A0B.60405@ru.mvista.com>  <4B0EC5CB.5060701@ru.mvista.com> <1259291134.3197.86.camel@falcon.domain.org>
In-Reply-To: <1259291134.3197.86.camel@falcon.domain.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 11/26/2009 07:05 PM, Wu Zhangjin wrote:
> On Thu, 2009-11-26 at 21:15 +0300, Sergei Shtylyov wrote:
[...]
>>>
>>>     I don't think this is really good name for this file (one might think
>>> that this is another implementation of clocksource instead of some
>>> sched_clock() code tied to this particular clocksource), and I don't
>>>        
>>      Seriously, if this file have to live a life of its own, name it like
>> sched-r4k.c but not the way you named it -- this is not another clocksource
>> module...
>>
>>      
> Hello, Sergei Shtylyov, I will use hres_sched_clock.c instead of
> sched-r4k.c, is it okay?
>
> Hi, Ralf, which one will you apply? If hres_sched_clock.c is okay, I
> will resend it asap.
>    

Like Sergei, I think putting this in a seperate file is a bad idea.  
This sched_clock is just a slightly different view of the csrc-r4k.c  
put it in there.

Octeon has its own clock source (cavium-octeon/scrc-octeon.c) and 
doesn't use csrc-r4k, so if you put it in a seperate file, there will 
have to be makefile hackery to keep this thing out of an octeon kernel.

When and if you add this to csrc-r4k, I will submit the patch (already 
written) that adds a high resolution sched_clock() to csrc-octeon.c.

Thanks,
David Daney
