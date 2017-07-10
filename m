Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 17:55:11 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:35565
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993868AbdGJPzEBjPIg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2017 17:55:04 +0200
Received: by mail-lf0-x244.google.com with SMTP id z78so11211500lff.2
        for <linux-mips@linux-mips.org>; Mon, 10 Jul 2017 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pv7xIaSjwU8uMYNSs0onN/Q8dZf+HStXyIz+A//03fw=;
        b=Ajq9ipp+7BpZ7DYdAlbLun7ysTdAegHRsshv1SprVS8txc8Hww8CEmSgcM0RkR5Q7o
         +BOGVY9X0VVfIDfqyyk6jjI1qGa1JVHofa6u7rKXre62b4Ii4Lk2+thetSjz54yKpR2/
         TIgSYV8blhtLTw6AExyAu3wGztadqlSVCFkCx49U2B77jNezhqYb79W1gC8KwASreuC+
         dp1wFHikwpHv60mMmi+xZCod7CTrEw8gj09LUEOjNA87MGgkCTVuYwCMPDPBvE+YPxTB
         1pG6KOJd6VEr9GUdwaGukwAhVqhvsR0QF6MLUQENNj+0OlFSECIX5g8VHoeaooT+574D
         qY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pv7xIaSjwU8uMYNSs0onN/Q8dZf+HStXyIz+A//03fw=;
        b=f5mzlFm6bLjFhf+v20A8weVoag0bOhZ6ncpHl/lcWb8Z5dm4ocKE8aMnAg9AUoCu+j
         rk5BfkvzMEIYAVk0cdAbVBpE5pvfh3KgEkZceP1aLYeKtCHKGv71LX4wWSuWT2AE2Nlw
         FaNMr8ONuQIdY1DXXtNzH9n0icI7WeBly2LKT1ziDwy8VLfFfmsYAhh4t4cb/bo5sTQN
         D9mC/k9p3N5yRVz0fXaVY4ZSBQERHGsZ8vYxsifBvYDhcV3QvhXsJL8RgI+BCKPrmq95
         ttQqnIryQLpyWFczVQ5ZmaG+Bu15LZnHkFqonM8l46icWDaaR/NxZO/UO7+cfTN3zurG
         V6oA==
X-Gm-Message-State: AIVw1136X2ntR4JwJG63+5QIadQe0wYTzvOCIMDAfaA0c97VCgSXk4+4
        eRV/+QQvC1HBRQ==
X-Received: by 10.28.178.203 with SMTP id b194mr8357146wmf.36.1499702094358;
        Mon, 10 Jul 2017 08:54:54 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id 63sm10136730wmi.8.2017.07.10.08.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 08:54:53 -0700 (PDT)
Subject: Re: [PATCH 6/6] irqchip: brcmstb-l2: Add support for the BCM7271 L2
 controller
To:     Doug Berger <opendmb@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-7-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cdf386bc-84ad-392c-098f-fa1558cbcf1b@gmail.com>
Date:   Mon, 10 Jul 2017 08:54:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170707192016.13001-7-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59085
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
> Add the initialization of the generic irq chip for the BCM7271 L2
> interrupt controller.  This controller only supports level
> interrupts and uses the "brcm,bcm7271-l2-intc" compatibility
> string.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
