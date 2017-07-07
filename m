Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 21:40:00 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:34673
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993947AbdGGTjx4vqsc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 21:39:53 +0200
Received: by mail-qk0-x243.google.com with SMTP id 91so5586919qkq.1
        for <linux-mips@linux-mips.org>; Fri, 07 Jul 2017 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LbxrIe92Kd7T+NuwGuxXkcCTCsXt97Go75BJJQLnIvE=;
        b=OkrQ2Wdgr9UNHOJthnFsIPfARL28yncuzPFKuPmCwYpkp1vAz9WDdOTRtTKNaKXS9a
         wzQIzHakx0eLprRLq+u8fETC7LQfiYhf1qoFiJy7bcpCJ5gqOPjfwiuBlXdScMHMC14b
         2/XhUBadiYmCNBWRR2iNa8aY3RIvGV8bgo1TyYLpTj3MpXX0VudDzp5qNp2UwVRfLm9L
         SddWyX3hrC48j44uIkqvU7CkD1bS3cMRCUtGnfnFDqyXPFbgq6pdTfbnkjoYqcrrae5o
         jV/v+u9c//Roz4gnqufMqIepC/yLZ1zAzCB7rGOKWel/idrcSJqNzmKEPC4HlQLh3Nr3
         hRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LbxrIe92Kd7T+NuwGuxXkcCTCsXt97Go75BJJQLnIvE=;
        b=rmu7TDiVYMJwtKtPiBA6WtcBjmAOploOo9MjTNtW39no+9fQ4klJFRRx7JhVgLS8Ur
         ZQsFrVdZBOVjaU3pCv6IQReiPrLkg3pjzDXPJmgmQJMpGHuSyEmzpJrpeFBqLN9/TkPY
         num9pQI00HwGxWcrRJg0hmGVLUotClplVaQjE3SObOepAY3498RlPW4+aV6ddtOM1rWN
         6do/FvkGEDEzfy7sVHLi0ojsJ3VJVEixT+ohifc1JfRWcCPJp+ZH9DjHVYWzLLlyYDs3
         ZNGjNelKxJ/+Q3MyPgmRqpX/uKas0za8sYsIq/08GAXA3EmSRblHb1LgpBe7REC4J/Bh
         9gPA==
X-Gm-Message-State: AKS2vOzeqPwaPI80ezShI8Wa9kWkNFDsP4JYw+ukxlf+Z+ffgzBpKsfn
        jp1wyNxsdSSHgw==
X-Received: by 10.233.232.205 with SMTP id a196mr71133031qkg.238.1499456388376;
        Fri, 07 Jul 2017 12:39:48 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id z1sm2924914qkb.37.2017.07.07.12.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 12:39:47 -0700 (PDT)
Subject: Re: [PATCH 0/6] Add support for BCM7271 style interrupt controller
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
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
References: <20170707192016.13001-1-opendmb@gmail.com>
 <a801afb1-2f54-2137-6fed-d8f83fe3f8ea@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d8fe8d17-b330-4099-4cfe-647e18ce87ad@gmail.com>
Date:   Fri, 7 Jul 2017 12:39:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <a801afb1-2f54-2137-6fed-d8f83fe3f8ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59064
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

On 07/07/2017 12:34 PM, Doug Berger wrote:
> Sorry, messed up the CC list.
> 
> On 07/07/2017 12:20 PM, Doug Berger wrote:
>> This patch set extends the functionality of the irq-brcmstb-l2 interrupt
>> controller driver to cover a hardware variant first introduced in the
>> BCM7271 SoC.  The main difference between this variant and the block
>> found in earlier brcmstb SoCs is that this variant only supports level
>> sensitive interrupts and therefore does not latch the interrupt state
>> based on edges.  Since there is no longer a need to ack interrupts with
>> a register write to clear the latch the register map has been changed.
>>
>> Therefore the change to add support for the new hardware block is to
>> abstract the register accesses to accommodate different maps and to
>> identify the block with a new device-tree compatible string.
>>
>> I also took the opportunity to make some small efficiency enhancements
>> to the driver.  One of these was to make use of the slightly more
>> efficient irq_mask_ack method.  However, I discovered that the defined
>> irq_gc_mask_disable_reg_and_ack() generic irq function was insufficient
>> for my needs.  The first three commits of this set are intended to be a
>> correction and extension of the existing generic irq implementation to
>> provide a set of functions that can be used by interrupt controller
>> drivers for their irq_mask_ack method.
>>
>> I believe these first three commits should be added to the irq/core
>> repository and the remaining commits should be added to the Broadcom
>> github repository but have included the complete set here for improved
>> context.  This entire set is therefore based on the irq/core master
>> branch.  Please let me know if you would like a different packaging.

The irqchip maintainers (Thomas, Jason, Marc Z.) will probably want to
get irqchip drivers changes through their tree:

IRQCHIP DRIVERS
M:      Thomas Gleixner <tglx@linutronix.de>
M:      Jason Cooper <jason@lakedaemon.net>
M:      Marc Zyngier <marc.zyngier@arm.com>
L:      linux-kernel@vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
irq/core
T:      git git://git.infradead.org/users/jcooper/linux.git irqchip/core
F:      Documentation/devicetree/bindings/interrupt-controller/
F:      drivers/irqchip/

Will reply to the individual patches, thanks for getting this out.

>>
>> If the changes to genirq are not acceptable I can implement the
>> irq_mask_ask method locally in the irq-brcmstb-l2 driver and submit
>> that on its own.
>>
>> Doug Berger (5):
>>   genirq: generic chip: add generic irq_mask_ack functions
>>   genirq: generic chip: remove irq_gc_mask_disable_reg_and_ack()
>>   irqchip: brcmstb-l2: Remove some processing from the handler
>>   irqchip: brcmstb-l2: Abstract register accesses
>>   irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller
>>
>> Florian Fainelli (1):
>>   irqchip/tango: Use irq_gc_mask_disable_and_ack_set
>>
>>  .../bindings/interrupt-controller/brcm,l2-intc.txt |   3 +-
>>  drivers/irqchip/irq-brcmstb-l2.c                   | 145 ++++++++++++++-------
>>  drivers/irqchip/irq-tango.c                        |   2 +-
>>  include/linux/irq.h                                |   7 +-
>>  kernel/irq/generic-chip.c                          | 110 +++++++++++++++-
>>  5 files changed, 214 insertions(+), 53 deletions(-)
>>
> 


-- 
Florian
