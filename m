Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:19:56 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36004 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbcJaVSVjlfb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 22:18:21 +0100
Received: by mail-pf0-f195.google.com with SMTP id n85so9651432pfi.3;
        Mon, 31 Oct 2016 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rM4CzEZZHR0RfYt9g8lQO4LVlWmuDcV9TW7Guagv8BA=;
        b=JW5PXwXN1sh/9KsWaO1TzureDnXBXxMjDInPevFUhPFcFv/fUhE+ZO/F39RACE/32E
         PbMLRYi111wc4B32XWbGy0sEHpjz61jZJBnR/+8om5kDv2FBo5XrQWIue3iPiXVSFiK6
         xACdjG0HlUwtHsDtJysuSlRjq/K8DNGjud7mWCg9twtoxHpha060htUeLaEU8CDkQ9Ix
         YBaeKHeeIE+B7w14dGwkcq63Z2Zzp60+WSNjX0jPqi4yWqe89O7PAubpLKwL0SXgjvOu
         RNWuIe52WdJD2xJueO3NDnqaw+f3XZiWrUaBODsSwoQ+TNoSr15iHsgqmp5Pxo8pmTSa
         8lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rM4CzEZZHR0RfYt9g8lQO4LVlWmuDcV9TW7Guagv8BA=;
        b=j+kpjB6T0+hRb9M6rr4DsMNzf92mVFa5bH90vUeWwdbRJbyq2w/Hklehp9ESKODK0p
         9xeX7FidU/Aon9fiJrE9kJEqkkTKKD6bmKA1o0u2awoord+nFxPMZVAr1JNk5WEdldfG
         3jTs7W2TAJ/eHIH/uBM4Eh9vaqBpqKkH9Ar5dnimpFWHy61gqcqtvmd5Bc6Wo7GOwZU+
         pH2IK94A0LI9cJAiDAtjaIq7csgvlQopasUd+BtvUlr2bHfW7iGtdlKfOL35Ofig0yns
         Ylokew8xd+n9gvCp/kia2lxhDe72mwqwmzTlTCsjwTxZIRRPzxZsvx8QMFcwS+hxNaOG
         ZS3A==
X-Gm-Message-State: ABUngvc+w9VKKkegUJFA+Y9kNBMPjHskgakc+tgUWWNpyWiA9+vr0KzTycaPggHZAXH98A==
X-Received: by 10.98.219.5 with SMTP id f5mr11550744pfg.131.1477948695901;
        Mon, 31 Oct 2016 14:18:15 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id p62sm37536899pfb.42.2016.10.31.14.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 14:18:15 -0700 (PDT)
Subject: Re: [PATCH 0/2] MIPS: BMIPS: Fix interrupt affinity migration
To:     linux-mips@linux-mips.org
References: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linutronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e0a60cc0-ccc5-a94d-1e57-1c843034f1ee@gmail.com>
Date:   Mon, 31 Oct 2016 14:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55629
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

On 10/31/2016 02:17 PM, Florian Fainelli wrote:
> Hi,
> 
> These two patches are against Thomas' irq/core branch as of today:
> 
> 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let ksoftirqd do its job")
> 
> Patches can be taken indepdently or together, your call.

Resending since I goofed on Thomas' address the first time..

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
