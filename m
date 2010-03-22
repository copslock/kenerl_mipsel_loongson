Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2010 02:04:08 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:43461 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492711Ab0CVBEF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Mar 2010 02:04:05 +0100
Received: by gyg10 with SMTP id 10so2548256gyg.36
        for <linux-mips@linux-mips.org>; Sun, 21 Mar 2010 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=TCSZf5E5P183cdHnzF8ZAIoZzey6b/GHx5IIVby3KO0=;
        b=qZvN6bDuxyMTMCDzPuEWWMrs7I6AxCbUrquAR4HdOh1QI1eBj7IBLpw99bZ5g3G3LC
         KZnmIkrz4S5dwgN7L/6xchl7SIUxIjpmgRNlhei63VYHtWxyYOtvaDF3TqFIBqeZe1cd
         +F8pyYV40zZFwE3hV0/dexd91FJ3+UCr8JOWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lHmvoGfPDpjG7udp6eriKaMhsIOikHVoS5ryHr7O+4tZr+Zqu/noX7gT+n43Pdhdvh
         CcQgXWVsF85Oh2gvZsMtm2f8f9K92hQQYHr64VdcgxnZyWUj0ToPT9jAfxxUGq05cgtj
         Y+Z5i/Vs43b/+U8u+ssUji/bg81DvxMws7y20=
Received: by 10.90.22.18 with SMTP id 18mr220143agv.77.1269219837553;
        Sun, 21 Mar 2010 18:03:57 -0700 (PDT)
Received: from [10.0.0.96] (cpe-76-173-26-187.socal.res.rr.com [76.173.26.187])
        by mx.google.com with ESMTPS id 34sm1506366yxf.54.2010.03.21.18.03.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 18:03:56 -0700 (PDT)
Message-ID: <4BA6C208.6010000@gmail.com>
Date:   Sun, 21 Mar 2010 18:04:08 -0700
From:   "Justin P. mattock" <justinmattock@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091114 Lightning/1.0pre Thunderbird/3.0b4
MIME-Version: 1.0
To:     Randy Dunlap <rdunlap@xenotime.net>
CC:     trivial@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-audit@redhat.com, uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, selinux@tycho.nsa.gov,
        sparclinux@vger.kernel.org, x86@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cosmetic:Partially remove deprecated __initcall() and
 change to
References: <1269028291-9103-1-git-send-email-justinmattock@gmail.com> <4BA40115.2000509@xenotime.net> <4BA407AC.5030506@gmail.com> <4BA6BAF3.10603@xenotime.net>
In-Reply-To: <4BA6BAF3.10603@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <justinmattock@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinmattock@gmail.com
Precedence: bulk
X-list: linux-mips

On 03/21/2010 05:33 PM, Randy Dunlap wrote:
> On 03/19/10 16:24, Justin P. Mattock wrote:
>> On 03/19/2010 03:56 PM, Randy Dunlap wrote:
>>> On 03/19/10 12:51, Justin P. Mattock wrote:
>>>> After doing some things on a small issue,
>>>> I noticed through web surfing, that there were patches
>>>> submitted pertaining that __initcall is deprecated,
>>>> and device_initcall should be used.
>>>
>>> Where was this discussion?  Do you have any pointers to it?
>>>
>>
>> The best info on this is scripts/checkpatch.pl
>> line #2664
>>
>> when I found this I just did a quick search of __initcall
>> (which gives hits here and there)
>> https://patchwork.kernel.org/patch/23344/
>> (also found others at around 2008 or so)
>
> Thanks.  IMO there should be something in the kernel source tree
> that says explicitly that __initcall is deprecated and should be
> replaced by using<whatever should be used>.  That's missing.
>

agree..

I should of searched the source tree for something
that says deprecated and so forth before doing anything(the 
checkpatch.pl was something I noticed down the line but doesn't say 
deprecated(say's explicitly).


>
>>> I don't see any mention of __initcall being deprecated in
>>> Linus' mainline git tree, or in linux-next, or in mmotm.
>>> Where are those patches?
>>>
>>
>> I don't know(I'm out of the social pipeline when it comes to Linux news,
>> and updates)..
>> like in the explanation part of the patch
>> I was looking into something else, then ran into this,
>> so as a break(from what I was originally doing)
>> decided to do this and submit.
>>
>>>
>>>> So as a change of subject(since what I was looking at
>>>> was frustrating me),I decided to grep the whole tree
>>>> and make the change(partially).
>>>>
>>>> Currently I'm running this patch on my system, kernel compiles
>>>> without any errors or warnings.(thought there would be a speed increase
>>>> but didn't see much(if any)).
>>>
>>> No, __initcall(x) is just a shorthand version of typing
>>> device_initcall(x).  They do the same thing.
>>>
>>
>> yep, that's what I found out as well(reason for the cosmetic
>> in the subject line).
>>
>>>> Biggest problem I have though is testing this on other hardware types
>>>> (I only have a macbook,and an iMac).
>>>> So please if you have the access to other arch/hardware types please
>>>> test.
>>>>
>>>> Now what I mean by partially is the __initcall function is still
>>>> there, so(if any) userspace apps/libs depend on this it's there
>>>> so they dont break and/or any other subsystem, that needs time
>>>> to make the changes.
>>>
>>> The only thing that might be affected is building out-of-tree drivers,
>>> but those are easy to fix.
>>>
>>
>> alright..main concern is making sure things don't break in the
>> kernel(even though things do).
>>
>> I can have a go at the header files, submit
>> then if it's something people agree they want to do, then they
>> can go from there(if not it's fine as well).
>>
>>>> Note:
>>>> the remaining files that still have __initcall in them are:
>>>> (according to grep)
>>>>
>>>> arch/um/include/shared/init.h
>>>> include/linux/init.h
>>>> scripts/checkpatch.pl
>>>>
>>>> either I or somebody else, can change this(although a bit
>>>> concerned about breaking things).
>>>>
>>>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>>> ---
>
>


In any case I'll leave this to you guys to decide.
The patch is in cyberspace now, so if/when this ever
is decided it's there(patch), then can be used then.

Justin P. Mattock
