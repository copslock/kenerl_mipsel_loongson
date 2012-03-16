Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2012 09:54:53 +0100 (CET)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:62506 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901172Ab2CPIyt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2012 09:54:49 +0100
Received: by wibhj13 with SMTP id hj13so390864wib.6
        for <linux-mips@linux-mips.org>; Fri, 16 Mar 2012 01:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=7P9rO672wMRoR88BjKPOosa8a6dT2CJyXJxVjm37s2o=;
        b=jdd1v4SG8KJ1ziuSM/oC0A5IfAOLjB+NmNxPpkh0bslkTxdiGwfPiR18SPfg2uwQ9a
         zj237dHCtM+qbtDfJ3SOk7jR+ZqH03SU9c62+vTjM/wAByvMieoqzylrHHTswkgjhFGA
         W030SIgIyhFuBR4I7tN3vm5/hao1X1c/NV39sycRx5yXHHuD1bB3bUXKtgh0muUqbOJB
         ThnSXUdO2WI7v/ZbdjW6PaKvDruTRWxrv2+fICKVKTcLdIzYMuNxPBOBT6hY087l1wet
         TJ48HubwrHpjGde/w9fbemxkwWUDwoQ2fcJQo6SlAZiTp2AfKu5CZA4KEfHzXbX33LSa
         Zx/Q==
Received: by 10.180.105.69 with SMTP id gk5mr38721728wib.3.1331888084136;
        Fri, 16 Mar 2012 01:54:44 -0700 (PDT)
Received: from [10.8.0.6] (fidelio.qi-hardware.com. [213.239.211.82])
        by mx.google.com with ESMTPS id fl2sm19740427wib.4.2012.03.16.01.54.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 01:54:43 -0700 (PDT)
Message-ID: <4F62FFA6.4040101@openmobilefree.net>
Date:   Fri, 16 Mar 2012 16:53:58 +0800
From:   Xiangfu Liu <xiangfu@openmobilefree.net>
Organization: http://www.openmobilefree.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     john stultz <johnstul@us.ibm.com>
CC:     Matt Turner <mattst88@gmail.com>, linux-mips@linux-mips.org,
        rtc-linux@googlegroups.com
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>         <1313777242.2970.131.camel@work-vm>         <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com> <1313783990.2970.136.camel@work-vm> <4EFD76F9.50204@openmobilefree.net>
In-Reply-To: <4EFD76F9.50204@openmobilefree.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnePO+VQ2IApFOH4mMNLUlsfV4nnXJfObf8CVN3jE9Hw4ctR9zWBYv4kGOfb5/ErIwxerNU
X-archive-position: 32724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiangfu@openmobilefree.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi

After I update kernel to linux v3.2.1. the problem still there.
Please give me some advice, how to fix this issue?

Thanks

On 12/30/2011 04:31 PM, Xiangfu Liu wrote:
> Hi John Stultz
>
> I meet the same problem on MIPS jz4740, here is the step I try to find out the problem:
>
> 1. when I direct run 'hwclock' it will give
>     "select() to /dev/rtc0 to wait for clock tick timed out"
>     attachment 'hwclock.time.out' is the strace log
>
> 2. run 'rtctest' program. it works fine. the output is here[1]
>
> 3. after 'rtctest', run 'hwclock' again. then it works fine
>     attachment 'hwclock.wors' is the strace log
>
> without 'rtctest' run first. 'hwclock' never works.
> the hwclock works fine in 2.6.27.6, failed under '3.0.0'
>
> Please give me some tips how to fix this problem. shoule I modify the driver code
> or is that relate to 'CONFIG_RTC_INTF_DEV_UIE_EMUL'?
>
> thanks in advance.
> xiangfu
