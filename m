Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 20:05:54 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:33781
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdISSFreYHYW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 20:05:47 +0200
Received: by mail-qt0-x242.google.com with SMTP id b1so268550qtc.0
        for <linux-mips@linux-mips.org>; Tue, 19 Sep 2017 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UeUirkkL9biszv//tMsmWqmcEbbAyFJelgl79oSDdjc=;
        b=qfvTwiiNRG+dyzTqF8aDhX5sHOX0ZxRKu80mIrfKPViajhS5BspkV5ZhiO4nr2R1uo
         yI1PhLeMNH0QARMpkRsgKKvDjYXGSbGOMbh+fNqSiY6IuoweR7gS+/LdzAbtzMZa5EZF
         BPJD6YL1vh7caBxqDyKxnFJdyRQgRmewr0lNs4HAz6ubyveqmRK33YS9sCX3mlYuKO53
         5KrsBzS6C/QYujh3pInVx7tyEQ8cGK/qhnYbYjpbjtNTMcsZeaRpOIUaVZadxPih2Wvg
         I9PuoKtmvyKP2S54apDNCC/0I0wNlH8CC875139/S9+2jsM4LjkTmW6xpb36j7tIdVOT
         gyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UeUirkkL9biszv//tMsmWqmcEbbAyFJelgl79oSDdjc=;
        b=SKuOOaKUIVmXHMjRd9FdMaclIDMaTTu4pHbDIef6n7y9ikRUWB1Fag4qSXI2LJTU7Z
         RyoQ2Dw8upeJbqS62Qr0OpmdJnfh+27X7lSlQvqP5LZE//qQlo3O5ZYUIsZEukMbrHlv
         F9IljnpvSyIjZHCuGdUSO1f7ycesyb23Oq8kuRp8o4PW2gF09HzZvDV8eCe0EZWynfUc
         /Irpjn/SXRNNb8bbZqMuaSXY397stBDIsHKEB/SZi9aO9sZVARdp+iz8joah3uZqc1sX
         g1IYcDw4Nc3EQGiPWu46nZ5/S81ISWfsc7IIiy+DzWhVeyHb00SioJ5w8CjTYibdOiZ1
         LKsA==
X-Gm-Message-State: AHPjjUhkh1qeW3HYtEKzwSHj1tBb+5ofuZlqyBQMm2SnZltW6erUz+Rn
        qFlgydpH/ctbJd/XrIMAvGc=
X-Google-Smtp-Source: AOwi7QC4txgQYSMLtWlMTjSgY/RWNRpR12Y+QWOkKOsLcj+JDUc+FNjYVJe9i8HOm0la9yDPvApsXg==
X-Received: by 10.200.25.78 with SMTP id g14mr3358913qtk.48.1505844341260;
        Tue, 19 Sep 2017 11:05:41 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id u17sm7398122qtc.15.2017.09.19.11.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Sep 2017 11:05:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Add support for BCM7271 style interrupt controller
To:     Doug Berger <opendmb@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Mans Rullgard <mans@mansr.com>, Mason <slash.tmp@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
References: <20170919010000.32072-1-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <db82458e-5656-1eb2-b4b8-051cc12e7095@gmail.com>
Date:   Tue, 19 Sep 2017 11:05:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170919010000.32072-1-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60075
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

On 09/18/2017 05:59 PM, Doug Berger wrote:
> This patch set extends the functionality of the irq-brcmstb-l2 interrupt
> controller driver to cover a hardware variant first introduced in the
> BCM7271 SoC.  The main difference between this variant and the block
> found in earlier brcmstb SoCs is that this variant only supports level
> sensitive interrupts and therefore does not latch the interrupt state
> based on edges.  Since there is no longer a need to ack interrupts with
> a register write to clear the latch the register map has been changed.
> 
> Therefore the change to add support for the new hardware block is to
> abstract the register accesses to accommodate different maps and to
> identify the block with a new device-tree compatible string.
> 
> I also took the opportunity to make some small efficiency enhancements
> to the driver.  One of these was to make use of the slightly more
> efficient irq_mask_ack method.  However, I discovered that the defined
> irq_gc_mask_disable_reg_and_ack() generic irq function was insufficient
> for my needs.  Previous submissions offered candidate solutions to
> address my needs within the generic irqchip library, but since those
> submissions appear to have stalled I am submitting this version that
> includes the function in the driver to prevent controversy and allow
> the new functionality to be included. 

For this entire series:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Doug.

> 
> Changes in v4:
> 
> - The first three commits were removed from the patch set to remove any
>   dependencies on changing the generic irqchip or irqchip-tango imple-
>   mentations. If there is a will to make those changes in the future
>   they can be applied at that time, but they needn't hold up the accept-
>   ance of this patch set.
>   
> Changes in v3:
> 
> - I did not submit a v3 patch set, but Marc Gonzalez included a PATCH v3
>   in a response to the v2 patch so I am skipping ahead to v4 to avoid
>   confusion.
>   
> Changes in v2:
> 
> - removed unused permutations of irq_mask_ack methods
> - added Reviewed-by and Acked-by responses from first submission
> 
> Doug Berger (3):
>   irqchip: brcmstb-l2: Remove some processing from the handler
>   irqchip: brcmstb-l2: Abstract register accesses
>   irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller
> 
>  .../bindings/interrupt-controller/brcm,l2-intc.txt |   3 +-
>  drivers/irqchip/irq-brcmstb-l2.c                   | 171 +++++++++++++++------
>  2 files changed, 126 insertions(+), 48 deletions(-)
> 


-- 
Florian
