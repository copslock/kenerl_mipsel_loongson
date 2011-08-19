Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 22:56:44 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:51376 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492181Ab1HSU4j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 22:56:39 +0200
Received: by vxj2 with SMTP id 2so3541934vxj.36
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PR/0EucgNe6xS3ONP7fI5kjy6FcrtJTB3LGIW1qPR0w=;
        b=OljYtI6K8G7uiHHfv/YdfnD+Rh7zGylF2hGdE1hJxhoqOzSqbLtPkA8g++I0Nlk/DI
         4s8/MKkn12j1gj5uMGdDR/h6WjUkTvBdVJVH0s+o/U8eLjYk3stPeYvRMXJKBflMWU3+
         q2k5m5+FSfn30lz0PmmAYMxjYviSkd5D0vx8s=
Received: by 10.52.138.68 with SMTP id qo4mr191776vdb.423.1313787393082; Fri,
 19 Aug 2011 13:56:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Fri, 19 Aug 2011 13:56:12 -0700 (PDT)
In-Reply-To: <1313786070.2970.144.camel@work-vm>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
 <1313777242.2970.131.camel@work-vm> <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com>
 <1313783990.2970.136.camel@work-vm> <CAEdQ38H5NC6B+T=gsF4-8Ue2DA=rfrFCi_i+RKC-=DFijjK2=g@mail.gmail.com>
 <1313786070.2970.144.camel@work-vm>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 19 Aug 2011 16:56:13 -0400
Message-ID: <CAEdQ38H7tHa3d83SOAbhUWFgwMgxCaP9ibJxNAGHAT2gmdEm=w@mail.gmail.com>
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
To:     john stultz <johnstul@us.ibm.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14719

On Fri, Aug 19, 2011 at 4:34 PM, john stultz <johnstul@us.ibm.com> wrote:
> On Fri, 2011-08-19 at 16:06 -0400, Matt Turner wrote:
>> Nope, just hangs.
>>
>> Current RTC date/time is 19-8-2011, 00:20:51.
>> Alarm time now set to 00:20:56.
>> Waiting 5 seconds for alarm...
>
> Ok. That confirms the alarm irq isn't working.
>
>> Would it at least help if I booted 2.6.37 to confirm that this test
>> program works there? I'd hate to waste a bunch of your time only to
>> find out that it's a problem with my patches.
>
> Yea, that's probably a good idea.
>
> From there we can instrument the code to see why the alarm irq isn't
> working.
>
> Thanks again for the testing!
> -john

With 2.6.37 the original rtctest program gives

			RTC Driver Test Example.

RTC_UIE_ON ioctl: Invalid argument

and the modified version hangs in the same way. :(

With 2.6.37, hwclock did work:

bcm91250a-be ~ # date
Fri Aug 19 16:52:21 EDT 2011
bcm91250a-be ~ # hwclock --systohc
bcm91250a-be ~ # date 082016522011
Sat Aug 20 16:52:00 EDT 2011
bcm91250a-be ~ # hwclock --hctosys
bcm91250a-be ~ # date
Fri Aug 19 16:53:02 EDT 2011

With 3.1.0-rc2+, it does not
bcm91250a-be ~ # date
Fri Aug 19 16:54:32 EDT 2011
bcm91250a-be ~ # hwclock --systohc
select() to /dev/rtc0 to wait for clock tick timed out
bcm91250a-be ~ # date 082016542011
Sat Aug 20 16:54:00 EDT 2011
bcm91250a-be ~ # hwclock --hctosys
select() to /dev/rtc0 to wait for clock tick timed out
bcm91250a-be ~ # date
Sat Aug 20 16:54:11 EDT 2011

So, even if the alarm never worked, there is some sort of regression here.

Thanks,
Matt
