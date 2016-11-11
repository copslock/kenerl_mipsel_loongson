Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 19:18:55 +0100 (CET)
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34794 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992202AbcKKSStJ8xdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2016 19:18:49 +0100
Received: by mail-pg0-f67.google.com with SMTP id e9so2081091pgc.1;
        Fri, 11 Nov 2016 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=akXkPrA33wN6DOwMMVHVVwKr0sGlXX68h6dfP56rKbI=;
        b=HxXaGzY7JY38kkI74OfF0eyiHQtZ8DpO7Ny/BZQ3zsh7W5PA5Z54HcPmw/7mILpz3Z
         G06nW84d82Uv9CS+qpmadp0d8wbMA2KAzCvvrC1lWGDfqLkwg7TcZblpU6f4Cetm4gNk
         65Fpei3c6UVS8MjFY/WG7Jq9bOw00kmfpuoCW2P2C0QFbuabMaAS4ISXpTVOQRel+GqO
         4/O9/ctoLtY4Ot5i3x90xaA0mOEDJUFsxlzUnpdVk7C50KhBg+rPzyzKlJiarbrc0tsk
         ZnYNCSeQ0x4jJSKbRWvoVbQsQdu/YklVEFCWdwj8xkiF6t2G61E8S6j5rcbRS6C0VMwo
         9UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=akXkPrA33wN6DOwMMVHVVwKr0sGlXX68h6dfP56rKbI=;
        b=YFuJ+a639KxXPrdQphY80/LYej96am2CGtKb1rF5ML6Bncpn+qJvISiLwqdhKo+Rh+
         UNJj7CleAzy+aAuDJMBydBrX6l8czN9MorymbNFuQImfDmAR9cTbzo39e+773fTpTSd1
         9+LfF13ualLvhFAuO6e4vMUtTC3Qevo8zUjaseV5EWiB6+gYdqIo4a4UhdJGKGTJgdp4
         wZcbxpCPGD/zJmwt7P5NlLhXsHFdxRAyJx4Bu5LQABdlhkY6i+S7wRgw7iAe7imNIoGL
         Xrx4BshYrxdw9Wj9yvt057/6JzUrsfVXEhBnWdrXhJBC9ao1Tj548tEGJTGW4UcFTtfE
         HP6g==
X-Gm-Message-State: ABUngvdhDydHJlegTrgz1yGkRqb2SOxl9KQWqKZGGcjHurHgIRvpa+nNLILzKPngk2shnQ==
X-Received: by 10.98.192.148 with SMTP id g20mr9390034pfk.36.1478888323259;
        Fri, 11 Nov 2016 10:18:43 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id yc7sm16766272pab.24.2016.11.11.10.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 10:18:42 -0800 (PST)
Subject: Re: [PATCH 0/2] MIPS: BMIPS: Fix interrupt affinity migration
To:     linux-mips@linux-mips.org
References: <1477948607-12899-1-git-send-email-f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linuxtronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b55fb49c-8efa-7582-a7e4-626c26157694@gmail.com>
Date:   Fri, 11 Nov 2016 10:18:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1477948607-12899-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 10/31/2016 02:16 PM, Florian Fainelli wrote:
> Hi,
> 
> These two patches are against Thomas' irq/core branch as of today:
> 
> 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let ksoftirqd do its job")
> 
> Patches can be taken indepdently or together, your call.

Thomas, Jason, any feedback ont his?

> 
> Florian Fainelli (2):
>   irqchip/bcm7038-l1: Implement irq_cpu_offline
>   MIPS: BMIPS: Migrate interrupts during bmips_cpu_disable
> 
>  arch/mips/kernel/smp-bmips.c     |  2 ++
>  drivers/irqchip/irq-bcm7038-l1.c | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 


-- 
Florian
