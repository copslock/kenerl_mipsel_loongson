Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 07:40:40 +0200 (CEST)
Received: from mail-pg0-x22a.google.com ([IPv6:2607:f8b0:400e:c05::22a]:47463
        "EHLO mail-pg0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990396AbdJSFkdbKpfO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 07:40:33 +0200
Received: by mail-pg0-x22a.google.com with SMTP id r25so6195459pgn.4;
        Wed, 18 Oct 2017 22:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=195l5yG7d+YmUNdM+1JyLL3Rr8XATBxRHMHnMdFUhnM=;
        b=JOojmxdmItADWeUh/UjLrE/18vjpKzTuAZHrhlia8ig3ugRIaDDnLH1BoSBZMtubEp
         yGTCIc9JPVlXB4rWq5UTpKsRoRMWSwh8hajvQ2/W/SdT6LU2Y2QQHWHRqPSsTd2WF9zy
         ZAmGJMHPRZrVxrLvVzDYWnnCF3GW6+idehviS15kzIg9WYM9IHM7Cww5/HHTl2ETsGli
         T4gL7gLhTNYlHOszL57KSP2TbY10pEkeKg9xrECXyDAdvChshtpNyyjNSnoH/nQN9Su9
         l4aZGgqrTED3ubCXwhaw4499Qbckru+KjyuFa5n9aAZMhB0MjjKwIuIj+m7hi05g8xAA
         gIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=195l5yG7d+YmUNdM+1JyLL3Rr8XATBxRHMHnMdFUhnM=;
        b=lw3b09sVJdzujeEM/W4hJnuYIekix6nfxJy1UGxvIpY38aEZbKpNqNrWe+20Bb07A0
         NAPjR1Fh4j6jhfq+hB4tV2l4MBjj3iKhWh4QHAqkksETNFsiEXpoKE86PzAmfTrcwmYT
         cguU3McYIQQyOeHDD3HhdyV5bXnLWrKbu3EtMyDyrZdmCOoACeSi+AhOlcDKBHR1c7cO
         qy89UO4UUTHu/IspmdZKwCxZGME90csp4U+KsQQIsXjxQUWnpVIo8+d/MS4w4ISPxklU
         moom/FPL897UC0q3jWoX8TXXxZNCK1BHK93e3FWBEk/JovQ3CssEVAPdpl0t4PZ3VbLT
         ywmQ==
X-Gm-Message-State: AMCzsaUPXceSJGIRSmOi721EAfzwEBdYviAIFAMW0NWMWCzg1CT0zr8v
        BKAGOr1ybRylbBLV8nG0e9Q=
X-Google-Smtp-Source: ABhQp+QAGL+QbDiPHUqJQBn6abFkS9VRJVI+A/6H5k2qn1VitcHTs0ehi6xOtz95FJmoGpe5wICplg==
X-Received: by 10.98.80.69 with SMTP id e66mr454330pfb.112.1508391626698;
        Wed, 18 Oct 2017 22:40:26 -0700 (PDT)
Received: from [192.168.10.2] (99-74-168-106.lightspeed.sntcca.sbcglobal.net. [99.74.168.106])
        by smtp.gmail.com with ESMTPSA id j12sm20798522pgs.35.2017.10.18.22.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Oct 2017 22:40:25 -0700 (PDT)
To:     openwrt-devel@lists.openwrt.org, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Josh Cartwright <joshc@ni.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        Jon Ringle <jringle@gridpoint.com>,
        Jean Delvare <khali@linux-fr.org>
From:   Xuebing Wang <xbing6@gmail.com>
Subject: [linux-mips] [openwrt] [sc16is7xx] [bitbang I2C] Any suggestions on
 board reboot caused by "sched: RT throttling activated"?
Message-ID: <06038463-d39b-90f6-57fd-dcbde6831ffe@gmail.com>
Date:   Thu, 19 Oct 2017 13:40:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <xbing6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60451
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

Any suggestions on how should I proceed with my issue?

Description of my issue:
-  My board kernel prints: "sched: RT throttling activated", then reboot 
(there is no back-trace in UART console).
-  I have sc16is752 (I2C based UART) on my board.
-  As Atheros AR9331 does not have dedicated I2C controller, I am using 
bitbang I2C.
-  This is likely related to below line of sc16is752 driver 
(drivers//tty/serial/sc16is7xx.c)
         ret = devm_request_threaded_irq(dev, irq, NULL, sc16is7xx_ist,
-  './ps -eo pid,nice,policy,cmd' confirms that above is a realtime 
kernel thread (with SCHED_FIFO scheduling policy)
-  Occurrence rate is about once or several times a day, after I stress 
I2C/UART traffic.
-  Occurrence rate is much lower if I do *NOT* stress I2C/UART traffic.

My setup:
-  Atheros AR9331 chip, which is MIPS32 24kc
-  OpenWRT tag 15.05
-  Linux kernel v3.18.29
-  Not preempt kernel (CONFIG_PREEMPT_NONE=y)
-  As AR9331 does not have dedicated I2C controller, I am using bitbang 
I2C as below:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/i2c/algos/i2c-algo-bit.c?h=linux-3.18.y
-  source code of sc16is752 driver sc16is7xx.c is here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/tty/serial/sc16is7xx.c?h=linux-3.18.y

Question 1): There seems a fundamental question about OpenWRT mips linux 
kernel?
-  OpenWRT tag 15.05
-  In OpenWRT file target/linux/ar71xx/Makefile, there is CPU_TYPE=34kc
-  Atheros AR9331 datasheet says it is 24kc (rather than 34kc)
-  With CPU_TYPE=34kc, it uses gcc options "-mips32r2 -mtune=34kc"

Question 2): I have no idea what causes the reboot? It is a chip 
hardware reboot, or function similar to emergency_restart() is called 
somewhere in the kernel? Kernel console only shows "sched: RT throttling 
activated" and reboot, there is no back-trace.

If I enable preempt kernel (CONFIG_PREEMPT=y), "RT throttling activated" 
still happens, and there is no reboot.
-  After "RT throttling activated" happens, I use "top -d 1" to check 
CPU usage, I observed at least once sc16is752 threaded-irq handler 
kernel thread occupies 95% of CPU for some seconds (not sure how many 
seconds), then sc16is752 threaded-irq handler CPU usage drops to normal, 
and the whole OpenWRT/Linux system is normal.
-  I did observe once that sc16is752 threaded-irq handler CPU usage 
stays at 95% forever, it seems like a dead-lock inside sc16is752 
threaded-irq handler.
-  It seems a dead-lock similar (in some way?) to below patch:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=linux-4.4.y&id=d78006d2345f87889918a8a7aa3764628ff84263

Question 3) Is there any explanation why board does not reboot when I 
enable preempt kernel (CONFIG_PREEMPT=y)?

Question 4) I am not sure if this is related to MIPS32r2 34kc (with 
9-stage pipeline multi-threaded processor core), while Atheros AR9331 is 
24kc (with 8-stage pipeline processor core)?
https://www.imgtec.com/mips/classic/


I have a temporary work-around:
-  In bitbang I2C driver, use hrtimer-backed usleep_range() (rather than 
busywait udelay()), then this issue is gone (verified by stress test).
-  As I do not know how long it takes to arm hrtimer on AR9331 platform, 
I use usleep_range(10us, 20us), this greatly reduces bitbang I2C 
throughput, and reduces sc16is752 (I2C based UART) baudrate.

Thanks.
Xuebing Wang
