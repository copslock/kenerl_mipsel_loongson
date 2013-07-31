Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jul 2013 21:22:37 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63714 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827280Ab3GaTWYmOsx6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jul 2013 21:22:24 +0200
Received: by mail-pd0-f169.google.com with SMTP id y11so1117951pdj.14
        for <linux-mips@linux-mips.org>; Wed, 31 Jul 2013 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/LsFLiozx6360zatOgzF73MkInT4FcrZfMgBxH8VIhg=;
        b=Jh1W1cXOYdZuH0c8bOuC/VwAhRd0o8Igs3vbVioA8xskA6Uyp2riqc+J7jTrfvXkCk
         up8H7XMpR08DqLtDzBxxziXxS3pBGZvFqzqVKhF0DJ0vjOQ8k3azp/hc7oxWn9UM5cah
         BnG/1A6oW74zxmW6u7vvJ7EJhjSgns8zb4vmQMWKhmcYw+QlZl5Qg0x2pSmOyf0SXpVU
         cPQGJT9EFXjLjZVofglJoWe27fHAIhQmnpJcVRzR1sAtoNS9x4cs/9M5zLsVhTELFM14
         iASCfCl1YAEandeTxY4RKcJyqWJYD+ioRzopOKTf4KAXP9OT7fcEF5d2QTUpel/0Sm0a
         AAaw==
X-Received: by 10.66.2.164 with SMTP id 4mr83617820pav.55.1375298538069;
        Wed, 31 Jul 2013 12:22:18 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id bg3sm3716084pbb.44.2013.07.31.12.22.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 12:22:17 -0700 (PDT)
Message-ID: <51F963E7.50407@gmail.com>
Date:   Wed, 31 Jul 2013 12:22:15 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     John Crispin <john@phrozen.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org> <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com> <51F6495D.9000008@phrozen.org> <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com>
In-Reply-To: <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 07/29/2013 04:14 AM, Florian Fainelli wrote:
> 2013/7/29 John Crispin <john@phrozen.org>:
[...]
>>
>>> It looks to me like you are moving the irq setup later just to ensure
>>> that your ralink clockevent device has been registered before and has
>>> set cp0_timer_irq_installed when the set_mode() r4k clockevent device
>>> runs, such that it won't register the same IRQ that your platforms
>>> uses. If that it the case, cannot you just ensure that you run your
>>> cevt device registration before mips_clockevent_init() is called?
>>
>>
>> i dont like relying on the order in which the modules get loaded.
>
> plat_time_init() runs before mips_clockevent_init() and the ordering
> is explicit, would not that work for what you are trying to do?
>
>>
>> the actual problem is not the irq sharing but that the cevt-r4k registers
>> the irq when the cevt is registered and not when it is activated. i believe
>> that the patch fixes this problem
>
> Your patch certainly does what you say it does, but that is kind of an
> abuse of the set_mode() callback.
>

I might as add my $0.02...

There are many other clockevent drivers that do this type of thing 
aren't there?  The clockevent framework uses this to 
install/remove/switch drivers, so why should cevt-r4k not be made to 
work like this?

David Daney
