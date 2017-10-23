Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2017 02:18:50 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:51115
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdJWASnMh2-a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2017 02:18:43 +0200
Received: by mail-pf0-x244.google.com with SMTP id b6so15811762pfh.7;
        Sun, 22 Oct 2017 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6QPXxkMZcpym4a5qgUL7tvWXz9ZJhW3ZmaT6u1ExmOI=;
        b=vHsuwgoJnVOMJX3ZFdCWj1Df8eNCR1j2PiraQE9rQUdwDmkVC7hN1byk+jO2MmEBHN
         nCMk28NTKE9cgqjLBC62jp5vPOXmZVlxIwieZu+pqza0i4m8O1ZnjnzMJFfeiE+99oOx
         cW3xp5zxLFyJUXQtf2HBJhE0RadRowIj6bBt8s8F3RkbNbmR7xP1fPL1u0/5MwM7Ppz3
         oAVu64KTgLVf5rcG80IZKJJdBydrqQpwlEmJXzCj/p3eNkt1t6PuSMFJvi5C9rzzK6WE
         beCOJlG1J9UKEcEy87u4cLONEXPRNC0/P7w6sWa1l7lm/GQL/cGf9jiczex2X/Wuzi1A
         w66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6QPXxkMZcpym4a5qgUL7tvWXz9ZJhW3ZmaT6u1ExmOI=;
        b=pqqEELZU5XBLuqMYVqXv4ndtVgoYZ6MVvHDz7sldXO02UQZ4pFuUKYKkdiVje7LUIR
         TzauwOAm+pJYZyp+GK7o3e4pW+2PhLkomupV0PR9k1xLQeY8OR0S/gBHxPwuFuAeWl4o
         8WKLeIgdUAIX8tFGDrlsNkKXQIYF4+sLHx//RbpNMQWM2ZFMS9w0UeFEqIZ38Mh8wZMM
         Jj8Ur92hO2GPCSnQ5uBA9sGD6VgNLXqmCXqwJaExsx8EI6v/QoCvE38PleX6CJY7eiSU
         C2Yyp96hEd8cz5oeK2+oNANTBsKqiqatXrgcjSk4H7ZfbaNzs8EqbZAOWAAGKCTF1TY5
         CAqQ==
X-Gm-Message-State: AMCzsaWRfMvxOX6dcvynlY3noRd/uD5J3zqiTJpdsK1ztVkOhNZGQ1uD
        iZr4Ahf7zpM+Qq7RmupTIWE=
X-Google-Smtp-Source: ABhQp+RK2gkjMHa+f3BsXSDXhh+aOT6U8jM12O1pQhjZrb6aCxSJ3Y4MeAKyXigPBm0Bb58xlI9oZw==
X-Received: by 10.159.214.139 with SMTP id n11mr8599328plp.289.1508717915097;
        Sun, 22 Oct 2017 17:18:35 -0700 (PDT)
Received: from [192.168.10.2] (99-74-168-106.lightspeed.sntcca.sbcglobal.net. [99.74.168.106])
        by smtp.gmail.com with ESMTPSA id e6sm10758326pfg.42.2017.10.22.17.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Oct 2017 17:18:34 -0700 (PDT)
Subject: Re: [linux-mips] [openwrt] [sc16is7xx] [bitbang I2C] Any suggestions
 on board reboot caused by "sched: RT throttling activated"?
From:   Xuebing Wang <xbing6@gmail.com>
To:     openwrt-devel@lists.openwrt.org, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Josh Cartwright <joshc@ni.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        Jon Ringle <jringle@gridpoint.com>,
        Jean Delvare <khali@linux-fr.org>
References: <06038463-d39b-90f6-57fd-dcbde6831ffe@gmail.com>
Message-ID: <61bc75ef-17d6-8f24-97bb-70f2b2e259a9@gmail.com>
Date:   Mon, 23 Oct 2017 08:18:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <06038463-d39b-90f6-57fd-dcbde6831ffe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <xbing6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xbing6@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi community,

Any suggestions, thanks.

Xuebing Wang

On 10/19/2017 01:40 PM, Xuebing Wang wrote:
> Hi community,
>
> Any suggestions on how should I proceed with my issue?
>
> Description of my issue:
> -  My board kernel prints: "sched: RT throttling activated", then 
> reboot (there is no back-trace in UART console).
> -  I have sc16is752 (I2C based UART) on my board.
> -  As Atheros AR9331 does not have dedicated I2C controller, I am 
> using bitbang I2C.
> -  This is likely related to below line of sc16is752 driver 
> (drivers//tty/serial/sc16is7xx.c)
>         ret = devm_request_threaded_irq(dev, irq, NULL, sc16is7xx_ist,
> -  './ps -eo pid,nice,policy,cmd' confirms that above is a realtime 
> kernel thread (with SCHED_FIFO scheduling policy)
> -  Occurrence rate is about once or several times a day, after I 
> stress I2C/UART traffic.
> -  Occurrence rate is much lower if I do *NOT* stress I2C/UART traffic.
>
> My setup:
> -  Atheros AR9331 chip, which is MIPS32 24kc
> -  OpenWRT tag 15.05
> -  Linux kernel v3.18.29
> -  Not preempt kernel (CONFIG_PREEMPT_NONE=y)
> -  As AR9331 does not have dedicated I2C controller, I am using 
> bitbang I2C as below:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/i2c/algos/i2c-algo-bit.c?h=linux-3.18.y 
>
> -  source code of sc16is752 driver sc16is7xx.c is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/tty/serial/sc16is7xx.c?h=linux-3.18.y 
>
>
> Question 1): There seems a fundamental question about OpenWRT mips 
> linux kernel?
> -  OpenWRT tag 15.05
> -  In OpenWRT file target/linux/ar71xx/Makefile, there is CPU_TYPE=34kc
> -  Atheros AR9331 datasheet says it is 24kc (rather than 34kc)
> -  With CPU_TYPE=34kc, it uses gcc options "-mips32r2 -mtune=34kc"
>
> Question 2): I have no idea what causes the reboot? It is a chip 
> hardware reboot, or function similar to emergency_restart() is called 
> somewhere in the kernel? Kernel console only shows "sched: RT 
> throttling activated" and reboot, there is no back-trace.
>
> If I enable preempt kernel (CONFIG_PREEMPT=y), "RT throttling 
> activated" still happens, and there is no reboot.
> -  After "RT throttling activated" happens, I use "top -d 1" to check 
> CPU usage, I observed at least once sc16is752 threaded-irq handler 
> kernel thread occupies 95% of CPU for some seconds (not sure how many 
> seconds), then sc16is752 threaded-irq handler CPU usage drops to 
> normal, and the whole OpenWRT/Linux system is normal.
> -  I did observe once that sc16is752 threaded-irq handler CPU usage 
> stays at 95% forever, it seems like a dead-lock inside sc16is752 
> threaded-irq handler.
> -  It seems a dead-lock similar (in some way?) to below patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=linux-4.4.y&id=d78006d2345f87889918a8a7aa3764628ff84263 
>
>
> Question 3) Is there any explanation why board does not reboot when I 
> enable preempt kernel (CONFIG_PREEMPT=y)?
>
> Question 4) I am not sure if this is related to MIPS32r2 34kc (with 
> 9-stage pipeline multi-threaded processor core), while Atheros AR9331 
> is 24kc (with 8-stage pipeline processor core)?
> https://www.imgtec.com/mips/classic/
>
>
> I have a temporary work-around:
> -  In bitbang I2C driver, use hrtimer-backed usleep_range() (rather 
> than busywait udelay()), then this issue is gone (verified by stress 
> test).
> -  As I do not know how long it takes to arm hrtimer on AR9331 
> platform, I use usleep_range(10us, 20us), this greatly reduces bitbang 
> I2C throughput, and reduces sc16is752 (I2C based UART) baudrate.
>
> Thanks.
> Xuebing Wang
