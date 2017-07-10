Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 17:54:11 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:33659
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993376AbdGJPyE5hPLg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2017 17:54:04 +0200
Received: by mail-wr0-x244.google.com with SMTP id x23so25870239wrb.0
        for <linux-mips@linux-mips.org>; Mon, 10 Jul 2017 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNMhY3I4T61k/kAIYQi+Znh75YHZ90VoLDez3FaGs7g=;
        b=NsEIvXeCvLBnqv35r76tjLV9sHGW7ljyIxI20CQaY6QzGNTCWtxjclseApvr8lsozn
         D5UAC8s2+MNkHaqeRnLp2IoaN47+JgJLOpE4VHQUU5XFoAM3CFxMYaLmyRhDDUlpai5r
         bpxPJlfDn07J/yvYFm2Br6utVk5r0MMfbmvC/7kCPT7SIMZ7BI01M28vcrtm5BhvVx8o
         o8SSVG7Dms5hv7hIMHzie/pr0+nkC+VYdcpUJiUFd7VslPXiOqTZPWeGEOyC2rCnuQXZ
         l7wqiLBEJFki6UfnWTNVgAtLhBT0h9xjl7KCadmcOdjmU/toyCnv86uDGCDZv/qDqsYe
         01Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNMhY3I4T61k/kAIYQi+Znh75YHZ90VoLDez3FaGs7g=;
        b=IkBC3ZEvxO/MdUf7PGWV0dn7UQIAEeovuof7wQHuG0YIyXCUGZSvSIj3308YvJQgfI
         YCst0c2ic0Oqt/W2npHM7bTE1WzxNI12Amsjw5k9a6syyc2ZTRhOehMH4Gw2XP8T/lXG
         4wLwR52z1hVSVXKfR8lU2ulnoRrsC52M3BYZDicxVpUyVU+hwPuepM6auyaVV8e1lAyy
         D/MoLmH36s+/SSIrZxIRc0wmgWLTvatSO2wj8/kns16Dt7lQiRxC5jDIVMSTTGywDZB0
         XlHMStwX/hSpHMZnT28muFF6CX0KTRPKYLMK0UOigCo8PDSn3zraFJtLEmxJoOkWFbQf
         HZZQ==
X-Gm-Message-State: AIVw112xmM9sHqm3ehM9s/X9HB3Lp5Kr2MdJsEhzMgtxLY/pho6MLVkP
        xIdVTTqtv5jt/w==
X-Received: by 10.223.162.156 with SMTP id s28mr7736132wra.2.1499702039727;
        Mon, 10 Jul 2017 08:53:59 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id u187sm10657317wmd.26.2017.07.10.08.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 08:53:59 -0700 (PDT)
Subject: Re: [PATCH 4/6] irqchip: brcmstb-l2: Remove some processing from the
 handler
To:     Doug Berger <opendmb@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-5-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3a27d1b1-23ca-3237-92ba-d91299448f33@gmail.com>
Date:   Mon, 10 Jul 2017 08:53:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170707192016.13001-5-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59083
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

On 07/07/2017 12:20 PM, Doug Berger wrote:
> Saving the generic chip pointer in the brcmstb_l2_intc_data prevents
> the need to call irq_get_domain_generic_chip().  Also don't need to
> save parent_irq and base there since local variables in the
> brcmstb_l2_intc_of_init() function are just as good.
> 
> The handle_edge_irq flow or chained_irq_enter takes care of the
> acknowledgement of the interrupt so it is redundant to clear it in
> brcmstb_l2_intc_irq_handle().
> 
> irq_linear_revmap() is a fast path equivalent of irq_find_mapping()
> that is appropriate to use for domain controllers of this type.
> 
> Defining irq_mask_ack is slightly more efficient than just
> implementing irq_mask and irq_ack seperately.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
