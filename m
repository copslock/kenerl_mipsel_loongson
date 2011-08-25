Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2011 19:30:32 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:48535 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493755Ab1HYRa2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Aug 2011 19:30:28 +0200
Received: by vws8 with SMTP id 8so2647634vws.36
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=x5+K6VQ/4Hq1tfFAjlOSAL1mw6k4mCljPsBGRmeqgJU=;
        b=DsWYedd8rgdqxdRfMRzZ8vheHKVJsYOxwT3psdOtVOQbK+vkBkmXueiO9AgAYnHwML
         L686caPkQqegBM2pmPad/4zsVTohjQKSDqM/Afew249G1BW7QEbRaxr1TQ5RLPLpI7Z4
         ifAw1zjgvJXOVfLDlXkD/IoeV3uJs652vHdX4=
Received: by 10.52.65.240 with SMTP id a16mr6934532vdt.490.1314293422148; Thu,
 25 Aug 2011 10:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Thu, 25 Aug 2011 10:30:02 -0700 (PDT)
In-Reply-To: <CAEdQ38Gg2FWJNacoa51+=eu8JQRr2mSA7jCjosOGbv8FKPFDpw@mail.gmail.com>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
 <1313777242.2970.131.camel@work-vm> <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com>
 <1313783990.2970.136.camel@work-vm> <CAEdQ38H5NC6B+T=gsF4-8Ue2DA=rfrFCi_i+RKC-=DFijjK2=g@mail.gmail.com>
 <1313786070.2970.144.camel@work-vm> <CAEdQ38H7tHa3d83SOAbhUWFgwMgxCaP9ibJxNAGHAT2gmdEm=w@mail.gmail.com>
 <1313788912.2970.152.camel@work-vm> <CAEdQ38Gg2FWJNacoa51+=eu8JQRr2mSA7jCjosOGbv8FKPFDpw@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 25 Aug 2011 13:30:02 -0400
Message-ID: <CAEdQ38G7csFL61Ye1h-3Jszh2nDHytm1ms0rS4nGBC1E0QEfzQ@mail.gmail.com>
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
To:     john stultz <johnstul@us.ibm.com>
Cc:     linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19194

On Fri, Aug 19, 2011 at 5:48 PM, Matt Turner <mattst88@gmail.com> wrote:
> On Fri, Aug 19, 2011 at 5:21 PM, john stultz <johnstul@us.ibm.com> wrote:
>> On Fri, 2011-08-19 at 16:56 -0400, Matt Turner wrote:
>>> With 2.6.37 the original rtctest program gives
>>>
>>>                       RTC Driver Test Example.
>>>
>>> RTC_UIE_ON ioctl: Invalid argument
>>>
>>> and the modified version hangs in the same way. :(
>>
>> Ok, so the AIE/alarm irq isn't working (but returns as if it should),
>> and in the older case, the UIE mode properly returned an error.
>>
>> So I'm guessing since we now use AIE mode interrupts to emulate UIE, the
>> UIE code thinks alarms will work and so doesn't return an error,
>> confusing the hwclock code.
>>
>>> With 2.6.37, hwclock did work:
>>>
>>> bcm91250a-be ~ # date
>>> Fri Aug 19 16:52:21 EDT 2011
>>> bcm91250a-be ~ # hwclock --systohc
>>> bcm91250a-be ~ # date 082016522011
>>> Sat Aug 20 16:52:00 EDT 2011
>>> bcm91250a-be ~ # hwclock --hctosys
>>> bcm91250a-be ~ # date
>>> Fri Aug 19 16:53:02 EDT 2011
>>
>> Running strace on the hwclock --hctosys might prove the theory above.
>>
>>
>>> With 3.1.0-rc2+, it does not
>>> bcm91250a-be ~ # date
>>> Fri Aug 19 16:54:32 EDT 2011
>>> bcm91250a-be ~ # hwclock --systohc
>>> select() to /dev/rtc0 to wait for clock tick timed out
>>> bcm91250a-be ~ # date 082016542011
>>> Sat Aug 20 16:54:00 EDT 2011
>>> bcm91250a-be ~ # hwclock --hctosys
>>> select() to /dev/rtc0 to wait for clock tick timed out
>>> bcm91250a-be ~ # date
>>> Sat Aug 20 16:54:11 EDT 2011
>>>
>>> So, even if the alarm never worked, there is some sort of regression here.
>>
>> Yea, since we depend on the alarm irq for more functionality now, it not
>> working in this case is causing more trouble.
>>
>> I suspect either fixing the driver alarm code so it either works or
>> provides a proper error code will resolve it.
>>
>> thanks
>> -john
>
> Indeed, looks like that's the case.
>
> 2.6.37: ioctl(3, PRESTO_GETMOUNT or RTC_UIE_ON, 0) = -1 EINVAL
> 3.1.0: ioctl(3, PRESTO_GETMOUNT or RTC_UIE_ON, 0) = 0
>
> (Attaching full gz'd logs for posterity.)
>
> Thanks,
> Matt

I looked through the datasheet and tried to find a place where we're
doing something wrong in the driver, but I didn't see anything.

http://www.datasheetcatalog.com/datasheets_pdf/M/4/1/T/M41T80.shtml

Any ideas?

Matt
