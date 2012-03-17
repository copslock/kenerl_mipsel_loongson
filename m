Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2012 02:11:14 +0100 (CET)
Received: from e8.ny.us.ibm.com ([32.97.182.138]:40964 "EHLO e8.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903715Ab2CQBLJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Mar 2012 02:11:09 +0100
Received: from /spool/local
        by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <john.stultz@linaro.org>;
        Fri, 16 Mar 2012 21:11:02 -0400
Received: from d01dlp01.pok.ibm.com (9.56.224.56)
        by e8.ny.us.ibm.com (192.168.1.108) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 16 Mar 2012 21:11:01 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
        by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D851B38C8054
        for <linux-mips@linux-mips.org>; Fri, 16 Mar 2012 21:11:00 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
        by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2H1B0Cp251840
        for <linux-mips@linux-mips.org>; Fri, 16 Mar 2012 21:11:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2H1B0hL023367
        for <linux-mips@linux-mips.org>; Fri, 16 Mar 2012 22:11:00 -0300
Received: from [9.76.207.219] (sig-9-76-207-219.mts.ibm.com [9.76.207.219])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2H1AuI8023169;
        Fri, 16 Mar 2012 22:10:58 -0300
Message-ID: <4F63E4A0.3010603@linaro.org>
Date:   Fri, 16 Mar 2012 18:10:56 -0700
From:   John Stultz <john.stultz@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Xiangfu Liu <xiangfu@openmobilefree.net>
CC:     Matt Turner <mattst88@gmail.com>, linux-mips@linux-mips.org,
        jz47xx-kernel@lists.en.qi-hardware.com, rtc-linux@googlegroups.com
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com> <1313777242.2970.131.camel@work-vm> <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com> <1313783990.2970.136.camel@work-vm> <4EFD76F9.50204@openmobilefree.net>
In-Reply-To: <4EFD76F9.50204@openmobilefree.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12031701-9360-0000-0000-0000049E35DD
X-archive-position: 32729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john.stultz@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12/30/2011 12:31 AM, Xiangfu Liu wrote:
> I meet the same problem on MIPS jz4740, here is the step I try to find 
> out the problem:
>
> 1. when I direct run 'hwclock' it will give
>    "select() to /dev/rtc0 to wait for clock tick timed out"
>    attachment 'hwclock.time.out' is the strace log
>
> 2. run 'rtctest' program. it works fine. the output is here[1]
>
> 3. after 'rtctest', run 'hwclock' again. then it works fine
>    attachment 'hwclock.wors' is the strace log
>
> without 'rtctest' run first. 'hwclock' never works.
> the hwclock works fine in 2.6.27.6, failed under '3.0.0'
>
> Please give me some tips how to fix this problem. shoule I modify the 
> driver code
> or is that relate to 'CONFIG_RTC_INTF_DEV_UIE_EMUL'?

Sorry I missed this email originally, and thank you for pinging me.

Is CONFIG_RTC_INTF_DEV_UIE_EMUL set in the config you're seeing this 
with? Does disabling it change the behavior?

Just a shot in the dark, but does the following help at all?
thanks
-john

Signed-off-by: John Stultz<john.stultz@linaro.org>

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c

index 05ab227..c6c81ba 100644

--- a/drivers/rtc/rtc-jz4740.c

+++ b/drivers/rtc/rtc-jz4740.c

@@ -171,7 +171,8 @@ static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)

  static int jz4740_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)

  {

      struct jz4740_rtc *rtc = dev_get_drvdata(dev);

-    return jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AF_IRQ, enable);

+    return jz4740_rtc_ctrl_set_bits(rtc,

+                 JZ_RTC_CTRL_AE |JZ_RTC_CTRL_AF_IRQ, enable);

  }

  

  static struct rtc_class_ops jz4740_rtc_ops = {
