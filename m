Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 23:22:53 +0200 (CEST)
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46553 "EHLO e3.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492163Ab1HSVWt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2011 23:22:49 +0200
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
        by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7JKwOFd024291
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 16:58:24 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p7JLLvuI472988
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 17:22:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p7JLLt2q002344
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 17:21:56 -0400
Received: from [9.50.17.119] (dyn9050017119.mts.ibm.com [9.50.17.119] (may be forged))
        by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p7JLLs1H002172;
        Fri, 19 Aug 2011 17:21:54 -0400
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
From:   john stultz <johnstul@us.ibm.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To:  <CAEdQ38H7tHa3d83SOAbhUWFgwMgxCaP9ibJxNAGHAT2gmdEm=w@mail.gmail.com>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
         <1313777242.2970.131.camel@work-vm>
         <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com>
         <1313783990.2970.136.camel@work-vm>
         <CAEdQ38H5NC6B+T=gsF4-8Ue2DA=rfrFCi_i+RKC-=DFijjK2=g@mail.gmail.com>
         <1313786070.2970.144.camel@work-vm>
         <CAEdQ38H7tHa3d83SOAbhUWFgwMgxCaP9ibJxNAGHAT2gmdEm=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 19 Aug 2011 14:21:52 -0700
Message-ID: <1313788912.2970.152.camel@work-vm>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14736

On Fri, 2011-08-19 at 16:56 -0400, Matt Turner wrote:
> With 2.6.37 the original rtctest program gives
> 
> 			RTC Driver Test Example.
> 
> RTC_UIE_ON ioctl: Invalid argument
> 
> and the modified version hangs in the same way. :(

Ok, so the AIE/alarm irq isn't working (but returns as if it should),
and in the older case, the UIE mode properly returned an error.

So I'm guessing since we now use AIE mode interrupts to emulate UIE, the
UIE code thinks alarms will work and so doesn't return an error,
confusing the hwclock code.

> With 2.6.37, hwclock did work:
> 
> bcm91250a-be ~ # date
> Fri Aug 19 16:52:21 EDT 2011
> bcm91250a-be ~ # hwclock --systohc
> bcm91250a-be ~ # date 082016522011
> Sat Aug 20 16:52:00 EDT 2011
> bcm91250a-be ~ # hwclock --hctosys
> bcm91250a-be ~ # date
> Fri Aug 19 16:53:02 EDT 2011

Running strace on the hwclock --hctosys might prove the theory above. 


> With 3.1.0-rc2+, it does not
> bcm91250a-be ~ # date
> Fri Aug 19 16:54:32 EDT 2011
> bcm91250a-be ~ # hwclock --systohc
> select() to /dev/rtc0 to wait for clock tick timed out
> bcm91250a-be ~ # date 082016542011
> Sat Aug 20 16:54:00 EDT 2011
> bcm91250a-be ~ # hwclock --hctosys
> select() to /dev/rtc0 to wait for clock tick timed out
> bcm91250a-be ~ # date
> Sat Aug 20 16:54:11 EDT 2011
> 
> So, even if the alarm never worked, there is some sort of regression here.

Yea, since we depend on the alarm irq for more functionality now, it not
working in this case is causing more trouble.

I suspect either fixing the driver alarm code so it either works or
provides a proper error code will resolve it.

thanks
-john
