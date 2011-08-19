Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 22:20:53 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:43121 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492179Ab1HSUUt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 22:20:49 +0200
Received: by vws8 with SMTP id 8so3268376vws.36
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OSn6QV41RgeYDeLg1ptEoWCrge3sU4FgbBHifHF8pN4=;
        b=EnfAAF/3CciDEW6QtGKU0maazzSVQ6dU+2Sqr5caLFb1MeTdWEVtLysxG5YxkAzi/j
         SoRB2HNw9Hn2EpBy9fumgZViaz8Oq5leePjEk+3o4mFne0olfBVSKzV2XQyHILNGDfM3
         s3LrY68GDQ0WjZ87XOubPeJ8UT/QnAfhtoo0o=
Received: by 10.52.88.133 with SMTP id bg5mr199390vdb.88.1313784412575; Fri,
 19 Aug 2011 13:06:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Fri, 19 Aug 2011 13:06:32 -0700 (PDT)
In-Reply-To: <1313783990.2970.136.camel@work-vm>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
 <1313777242.2970.131.camel@work-vm> <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com>
 <1313783990.2970.136.camel@work-vm>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 19 Aug 2011 16:06:32 -0400
Message-ID: <CAEdQ38H5NC6B+T=gsF4-8Ue2DA=rfrFCi_i+RKC-=DFijjK2=g@mail.gmail.com>
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
To:     john stultz <johnstul@us.ibm.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14693

On Fri, Aug 19, 2011 at 3:59 PM, john stultz <johnstul@us.ibm.com> wrote:
> On Fri, 2011-08-19 at 15:41 -0400, Matt Turner wrote:
>> On Fri, Aug 19, 2011 at 2:07 PM, john stultz <johnstul@us.ibm.com> wrote:
>> > On Fri, 2011-08-19 at 00:16 -0400, Matt Turner wrote:
>> > thanks
>> > -john
>>
>> Counting 5 update (1/sec) interrupts from reading /dev/rtc0:
>>
>> ... and then it doesn't count.
>>
>> Would it help if I tried to bisect this? (Is there an easy way to
>> bisect 2.6.37..master with my patches applied to each iteration?)
>
> I suspect bisecting won't help too much, as I've reworked a good chunk
> of the generic rtc code in 2.6.38, so its not likely to be one small
> change.
>
> How about this modified (cutting out the UIE testing) version of the
> Documentation/rtc.txt test below?
>
> I'm basically trying to find out if the alarm functionality is actually
> working or not, since with 2.6.38+ we use the one-shot style alarm mode
> to trigger UIE interrupts.
>
> thanks
> -john

Nope, just hangs.

Current RTC date/time is 19-8-2011, 00:20:51.
Alarm time now set to 00:20:56.
Waiting 5 seconds for alarm...

Would it at least help if I booted 2.6.37 to confirm that this test
program works there? I'd hate to waste a bunch of your time only to
find out that it's a problem with my patches.

Thanks,
MAtt
