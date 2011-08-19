Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 19:23:39 +0200 (CEST)
Received: from e39.co.us.ibm.com ([32.97.110.160]:33711 "EHLO
        e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491816Ab1HSRXf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 19:23:35 +0200
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
        by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7JH8DxW002946
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 11:08:13 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p7JHNN1A053798
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 11:23:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p7JHNNTA031787
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 11:23:23 -0600
Received: from [9.50.17.119] (dyn9050017119.mts.ibm.com [9.50.17.119] (may be forged))
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p7JHNL2W031705;
        Fri, 19 Aug 2011 11:23:22 -0600
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
From:   john stultz <johnstul@us.ibm.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To:  <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 19 Aug 2011 10:23:19 -0700
Message-ID: <1313774600.2970.128.camel@work-vm>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14593

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
> 
> dmesg shows:
> 
> [    1.068000] i2c /dev entries driver
> [    1.072000] i2c-sibyte: i2c SMBus adapter module for SiByte board
> [    1.080000] rtc-m41t80 1-0068: chip found, driver version 0.06
> [    1.088000] rtc-m41t80 1-0068: rtc core: registered m41t81 as rtc0
> [    1.172000] rtc-m41t80 1-0068: setting system clock to 2011-08-18
> 19:56:53 UTC (1313697413)
> 
> I'm emailing you because I thought it might be the same problem as
> https://lkml.org/lkml/2011/1/20/306

Hmm. I thought we had gotten one that sorted. 

> Do you know what might be the problem?

I'll take a look and see what I find.

Thanks for the report!
-john
