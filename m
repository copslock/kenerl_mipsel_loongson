Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 12:59:59 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:46373 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013515AbbCLL7yRpQrs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Mar 2015 12:59:54 +0100
Received: by lbiz11 with SMTP id z11so15289780lbi.13
        for <linux-mips@linux-mips.org>; Thu, 12 Mar 2015 04:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EzBLhzUlRfFXD0nxBvbUYwAhe6UXFDJjbjsPAI2fI/c=;
        b=UnKhcRqXi39nQSWACN/4GVdzyk5wfNyfaLAU0Ot65b6QZZ1tz9CqQ5ciqXWhdXhOQN
         0LgLadhbd7Y8dbL+SoflOT9MwL3z4q4t2kGoM/85h9x3yhYhULfX/Dq32mQUcUrUZ967
         Nl/solr+HOK444vY/yfgk8tTmsFUCkKnqOd0pIQKHA5r+vedwL0OS+wMwHjMPJTOurZY
         pavNDzTQ67uHnMPEy0tRoa8Pyq0HlFiKkWuaBSeocOaWuQbaRdR+IhYtzr6jKHZMoo2b
         bVH5xtq4x7PuRAqpFElnRp3KC4bHKQsV+dj/ZtJj8LQ9z1zkzeiBUz+tPyEEBZD6PY+X
         LXOA==
X-Gm-Message-State: ALoCoQm8woBun2YYtQvKjACiHrkQIPbBzhKEfl1wkRmCqON/kz0+asivpmXrrD0GarA1siIgBGZj
X-Received: by 10.112.161.66 with SMTP id xq2mr38758562lbb.103.1426161589393;
        Thu, 12 Mar 2015 04:59:49 -0700 (PDT)
Received: from [192.168.3.154] (ppp83-237-248-81.pppoe.mtu-net.ru. [83.237.248.81])
        by mx.google.com with ESMTPSA id dk7sm1278036lbc.28.2015.03.12.04.59.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2015 04:59:47 -0700 (PDT)
Message-ID: <55017FB2.2070804@cogentembedded.com>
Date:   Thu, 12 Mar 2015 14:59:46 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction
References: <1426132266-30379-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1426132266-30379-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 3/12/2015 6:51 AM, Huacai Chen wrote:

> HPET irq is routed to i8259 and then to MIPS CPU irq (cascade). After

    IRQ.

> commit a3e6c1eff5 (MIPS: IRQ: Fix disable_irq on CPU IRQs), if without

    "If" not needed, I think.

> IRQF_NO_SUSPEND in cascade_irqaction, HPET interrupts will lost during

    Will be lost.

> suspend. The result is machine cannot be waken up.

    Woken up.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

    Perhaps Ralf could fix these when applying...

WBR, Sergei
