Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 22:34:49 +0200 (CEST)
Received: from e39.co.us.ibm.com ([32.97.110.160]:40926 "EHLO
        e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492163Ab1HSUeo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 22:34:44 +0200
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
        by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7JKJOJq010254
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 14:19:24 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p7JKYYoc157558
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 14:34:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p7JKYYWb020122
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 14:34:34 -0600
Received: from [9.50.17.119] (dyn9050017119.mts.ibm.com [9.50.17.119] (may be forged))
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p7JKYWYW020039;
        Fri, 19 Aug 2011 14:34:33 -0600
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
From:   john stultz <johnstul@us.ibm.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To:  <CAEdQ38H5NC6B+T=gsF4-8Ue2DA=rfrFCi_i+RKC-=DFijjK2=g@mail.gmail.com>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
         <1313777242.2970.131.camel@work-vm>
         <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com>
         <1313783990.2970.136.camel@work-vm>
         <CAEdQ38H5NC6B+T=gsF4-8Ue2DA=rfrFCi_i+RKC-=DFijjK2=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 19 Aug 2011 13:34:30 -0700
Message-ID: <1313786070.2970.144.camel@work-vm>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14699

On Fri, 2011-08-19 at 16:06 -0400, Matt Turner wrote:
> Nope, just hangs.
> 
> Current RTC date/time is 19-8-2011, 00:20:51.
> Alarm time now set to 00:20:56.
> Waiting 5 seconds for alarm...

Ok. That confirms the alarm irq isn't working.

> Would it at least help if I booted 2.6.37 to confirm that this test
> program works there? I'd hate to waste a bunch of your time only to
> find out that it's a problem with my patches.

Yea, that's probably a good idea.

>From there we can instrument the code to see why the alarm irq isn't
working.

Thanks again for the testing!
-john
