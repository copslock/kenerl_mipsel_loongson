Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2010 03:24:00 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:55242 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491073Ab0FTBXx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Jun 2010 03:23:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 9B63B7E1;
        Sun, 20 Jun 2010 03:23:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0aiS+dF9YdEx; Sun, 20 Jun 2010 03:23:46 +0200 (CEST)
Received: from [172.31.16.228] (d044235.adsl.hansenet.de [80.171.44.235])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 141B77E0;
        Sun, 20 Jun 2010 03:23:30 +0200 (CEST)
Message-ID: <4C1D6D76.8030109@metafoo.de>
Date:   Sun, 20 Jun 2010 03:23:02 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Wan ZongShun <mcuos.com@gmail.com>
CC:     rtc-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: [rtc-linux] [PATCH v3] RTC: Add JZ4740 RTC driver
References: <1276924111-11158-16-git-send-email-lars@metafoo.de> <1276975790-25623-1-git-send-email-lars@metafoo.de> <4C1D6B27.7070408@gmail.com>
In-Reply-To: <4C1D6B27.7070408@gmail.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13680

Wan ZongShun wrote:
>
>> This patch adds support for the RTC unit on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Paul Gortmaker <p_gortmaker@yahoo.com>
>> Cc: rtc-linux@googlegroups.com
>>
>> -- 
>> Changes since v1
>> - Use dev_get_drvdata directly instead of wrapping it in dev_to_rtc
>> - Add common implementation for jz4740_rtc_{alarm,update}_irq_enable
>> - Check whether rtc structure could be allocated
>> - Remove deadlocks which could occur if the HW was broken
>>
>> Changes since v2
>> - Use kzalloc instead of kmalloc
>> - Propagate errors in jz4740_rtc_reg_write up to its callers
>
> Acked-by: Wan ZongShun <mcuos.com@gmail.com>
>
> Andrew, the v3 patch has fixed some above issues, it looks good to me
> now.
> Could you please consider merging it to your git tree?
>
Hi

As written in the introduction mail to this thread it would be good if
the majority of the patches could go through Ralfs tree.
So if the patch is good an "Acked-by:" would be preferable.

Thanks,
- Lars
