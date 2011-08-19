Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 20:07:38 +0200 (CEST)
Received: from e9.ny.us.ibm.com ([32.97.182.139]:60772 "EHLO e9.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491860Ab1HSSHd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2011 20:07:33 +0200
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
        by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7JHXqGS031610
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 13:33:52 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p7JI7QC2182956
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 14:07:26 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p7JI7PEU005119
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 14:07:25 -0400
Received: from [9.50.17.119] (dyn9050017119.mts.ibm.com [9.50.17.119] (may be forged))
        by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p7JI7O4i005105;
        Fri, 19 Aug 2011 14:07:25 -0400
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
From:   john stultz <johnstul@us.ibm.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To:  <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 19 Aug 2011 11:07:22 -0700
Message-ID: <1313777242.2970.131.camel@work-vm>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14614

On Fri, 2011-08-19 at 00:16 -0400, Matt Turner wrote:
> Hi John,
> 
> I just sent a patch series to linux-mips@ that enables the RTC on a
> particular Broadcom MIPS motherboard (BCM91250A SWARM). The RTC is an
> M41T80.
> 
> When I first found the patchset (it was originally sent a a few years
> ago) and applied it to 2.6.37, it worked perfectly.
> 
> Applied to 3.x (and I think even 2.6.38) I get the following when I run hwclock:
> 
> # hwclock --systohc
> select() to /dev/rtc0 to wait for clock tick timed out

So do alarm interrupts actually work on the hardware? 

The rtc-m41t80.c driver looks like it should support them ok.

Does the test program at the end of Documentation/rtc.txt do much?

thanks
-john
