Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 06:17:01 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:38863 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab1HSEQl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 06:16:41 +0200
Received: by vws8 with SMTP id 8so2557838vws.36
        for <linux-mips@linux-mips.org>; Thu, 18 Aug 2011 21:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=kjKVTMNZ7lxCzamrq6wMO7f2Qx33HIRvJIk8bn+iXzE=;
        b=f8OEOv6PUgkUANhtuT8Ut8pmjp8iwSj1MwIgrjI8fr/jl+4gVunPXvNy10yXA9aty/
         rSoRbyOXcQVnQ+A+yJYjXeqGWaWSOtItAnz6kfBQMZRlXGu7lop1uIq7Xet8aPugylHF
         Wxe9RYkNrU35RPghclcisH8NYUBwPnPcmyTJ0=
Received: by 10.52.71.41 with SMTP id r9mr1428302vdu.289.1313727394220; Thu,
 18 Aug 2011 21:16:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.168.133 with HTTP; Thu, 18 Aug 2011 21:16:14 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 19 Aug 2011 00:16:14 -0400
Message-ID: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
Subject: select() to /dev/rtc0 to wait for clock tick timed out
To:     john stultz <johnstul@us.ibm.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13833

Hi John,

I just sent a patch series to linux-mips@ that enables the RTC on a
particular Broadcom MIPS motherboard (BCM91250A SWARM). The RTC is an
M41T80.

When I first found the patchset (it was originally sent a a few years
ago) and applied it to 2.6.37, it worked perfectly.

Applied to 3.x (and I think even 2.6.38) I get the following when I run hwclock:

# hwclock --systohc
select() to /dev/rtc0 to wait for clock tick timed out

dmesg shows:

[    1.068000] i2c /dev entries driver
[    1.072000] i2c-sibyte: i2c SMBus adapter module for SiByte board
[    1.080000] rtc-m41t80 1-0068: chip found, driver version 0.06
[    1.088000] rtc-m41t80 1-0068: rtc core: registered m41t81 as rtc0
[    1.172000] rtc-m41t80 1-0068: setting system clock to 2011-08-18
19:56:53 UTC (1313697413)

I'm emailing you because I thought it might be the same problem as
https://lkml.org/lkml/2011/1/20/306

Do you know what might be the problem?

The patch series can be found here [1], if they did not find their way
to you through another mailing list.

Thanks,
Matt

[1] http://www.linux-mips.org/archives/linux-mips/2011-08/threads.html
