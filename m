Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 17:53:29 +0200 (CEST)
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36313 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993423AbdGJPxWHV2kg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2017 17:53:22 +0200
Received: by mail-yw0-f194.google.com with SMTP id l21so5561997ywb.3
        for <linux-mips@linux-mips.org>; Mon, 10 Jul 2017 08:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UCsIkUF1kGLiYt0x7Rh5fARA7pFnExa4F0l9xv42Tso=;
        b=LioISNeS09yV0grzPfL2TdxVXvdC2H61ZRcKVYGX+12ya/6QcMitqHgrNbiVW+ywpx
         IT/aqpgP3s93qA9NeSnSHHQ2Sfng53LUMusKqOFuvARYmscXIdFfOFwLVPme/nF3U/+M
         xJTnQAyE81keNv+QPwjRc7QPlEf1JSRNFfZ6x3uyyDgcMq1VfHGnCr/StaDTFiJDvIqh
         Ra8/XJtPaCXa0/CCtN9crG6m/46KvUV+vOWYZYvsye57V71k9t7/KGHGsHVJXvtgw4Go
         2EXTQHr0x2DMG+6vE+j0YSzl1vv10s26YgKp8zVC7mj+GhtgFNB0TwFqUmhdOIBIIqwK
         Jbmg==
X-Gm-Message-State: AIVw113WyqQzMBLlNj4td0Q4IyVQpJEr3bi3PV/E3WcZM79OKLlkqjI7
        tnYywXUeNURULA==
X-Received: by 10.129.48.197 with SMTP id w188mr1214066yww.195.1499701996410;
        Mon, 10 Jul 2017 08:53:16 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id c9sm5088473ywk.20.2017.07.10.08.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jul 2017 08:53:15 -0700 (PDT)
Date:   Mon, 10 Jul 2017 10:53:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Subject: Re: [PATCH 6/6] irqchip: brcmstb-l2: Add support for the BCM7271 L2
 controller
Message-ID: <20170710155315.2sa6k3auolxpo2ns@rob-hp-laptop>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-7-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707192016.13001-7-opendmb@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Jul 07, 2017 at 12:20:16PM -0700, Doug Berger wrote:
> Add the initialization of the generic irq chip for the BCM7271 L2
> interrupt controller.  This controller only supports level
> interrupts and uses the "brcm,bcm7271-l2-intc" compatibility
> string.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  .../bindings/interrupt-controller/brcm,l2-intc.txt |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/irqchip/irq-brcmstb-l2.c                   | 86 ++++++++++++++++------
>  2 files changed, 66 insertions(+), 23 deletions(-)
