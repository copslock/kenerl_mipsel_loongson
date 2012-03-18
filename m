Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2012 08:03:33 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:50175 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab2CRHD3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2012 08:03:29 +0100
Received: by wibhj13 with SMTP id hj13so2244447wib.6
        for <linux-mips@linux-mips.org>; Sun, 18 Mar 2012 00:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=5kvqAU0oCjt2dy+5tD0GXDvD3t3bxhbqhA3KxyTWDVQ=;
        b=X+cUbGiKMi/iHscNSQP8DQp9iB/XG9XwJUEYpBtpB8gYimBAlQ0A4VqRvKeWddR8OB
         qdKxhGGXIdSlL1wlAS7H6HQMjJT0GcquwGDZB+rBeiCoZDHzINGx3Lpy7F/nj9LjK/+c
         dirp/IVvsQT/0++8lopS7ZypCkIsYyMVMheSkDrkYFa1XBXefrOuzeGqhcaO/sfoa0hr
         Bh7gLQQo7i98Pon8j2P5Ijij0EJ9H4mMlrKhYwpMHjHDMDQUkm6jUb0LbhD7z0sF88Nb
         f56E5jDR0ccKwvoizHlxKivAgqQlTvfpWD/4wgy756jpw1qmfMxkrNsPlSMYIkXj9Xdw
         QV0w==
Received: by 10.180.97.41 with SMTP id dx9mr10645355wib.9.1332054203274;
        Sun, 18 Mar 2012 00:03:23 -0700 (PDT)
Received: from [10.8.0.6] (fidelio.qi-hardware.com. [213.239.211.82])
        by mx.google.com with ESMTPS id b3sm14144659wib.4.2012.03.18.00.03.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 00:03:22 -0700 (PDT)
Message-ID: <4F6588AC.1010809@openmobilefree.net>
Date:   Sun, 18 Mar 2012 15:03:08 +0800
From:   Xiangfu Liu <xiangfu@openmobilefree.net>
Organization: http://www.openmobilefree.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Stultz <john.stultz@linaro.org>
CC:     Matt Turner <mattst88@gmail.com>, linux-mips@linux-mips.org,
        jz47xx-kernel@lists.en.qi-hardware.com, rtc-linux@googlegroups.com,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com> <1313777242.2970.131.camel@work-vm> <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com> <1313783990.2970.136.camel@work-vm> <4EFD76F9.50204@openmobilefree.net> <4F63E4A0.3010603@linaro.org>
In-Reply-To: <4F63E4A0.3010603@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkFFfoFsNyc49pzRA3Vq9fIDpDfOcbj+748HKkwF0QwujP/vB2S6Yf17aTicXyk4jaEzd+d
X-archive-position: 32730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiangfu@openmobilefree.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi John

Thanks for reply. the patch is not working. I found a work around.
checkout this patch:
  http://projects.qi-hardware.com/index.php/p/openwrt-xburst/source/tree/5a49fe26a5cefe0b1f8dcff1315cf3f2e12bc8f6/target/linux/xburst/patches-3.2/0029-rtc-jz4740-fix-hwclock-give-time-out.patch

after apply this patch. the hwclock worksf ine again. but it is may not a good patch.

Please take a look give me some advice. Thanks John
Xiangfu

On 03/17/2012 09:10 AM, John Stultz wrote:
> On 12/30/2011 12:31 AM, Xiangfu Liu wrote:
>> I meet the same problem on MIPS jz4740, here is the step I try to find out the problem:
>>
>> 1. when I direct run 'hwclock' it will give
>> "select() to /dev/rtc0 to wait for clock tick timed out"
>> attachment 'hwclock.time.out' is the strace log
>>
>> 2. run 'rtctest' program. it works fine. the output is here[1]
>>
>> 3. after 'rtctest', run 'hwclock' again. then it works fine
>> attachment 'hwclock.wors' is the strace log
>>
>> without 'rtctest' run first. 'hwclock' never works.
>> the hwclock works fine in 2.6.27.6, failed under '3.0.0'
>>
>> Please give me some tips how to fix this problem. shoule I modify the driver code
>> or is that relate to 'CONFIG_RTC_INTF_DEV_UIE_EMUL'?
>
> Sorry I missed this email originally, and thank you for pinging me.
>
> Is CONFIG_RTC_INTF_DEV_UIE_EMUL set in the config you're seeing this with? Does disabling it change the behavior?
>
> Just a shot in the dark, but does the following help at all?
> thanks
> -john
>
> Signed-off-by: John Stultz<john.stultz@linaro.org>
>
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
>
> index 05ab227..c6c81ba 100644
>
> --- a/drivers/rtc/rtc-jz4740.c
>
> +++ b/drivers/rtc/rtc-jz4740.c
>
> @@ -171,7 +171,8 @@ static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>
> static int jz4740_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
>
> {
>
> struct jz4740_rtc *rtc = dev_get_drvdata(dev);
>
> - return jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AF_IRQ, enable);
>
> + return jz4740_rtc_ctrl_set_bits(rtc,
>
> + JZ_RTC_CTRL_AE |JZ_RTC_CTRL_AF_IRQ, enable);
>
> }
>
>
>
> static struct rtc_class_ops jz4740_rtc_ops = {
>
>
>
>
