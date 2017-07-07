Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 21:34:20 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:34723
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993949AbdGGTeMflcxc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 21:34:12 +0200
Received: by mail-qt0-x242.google.com with SMTP id m54so5467181qtb.1
        for <linux-mips@linux-mips.org>; Fri, 07 Jul 2017 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kP//8jGyvR7jRjO8JEbG1V4ntX7xDMUlrgYhDGu5V8s=;
        b=SbPG+w92SYpSxHkCPZFJnV1T58Ci3b0HNWRerdntUJXA6EScSoGu79bmS4UeOGlZRW
         IrrjVx+nu8HLNYUnUtXqsWShMqKHFkZTyVtGGdxm1D4xoF3zu8ZM2YLLefyYq/+I+FLI
         9g3yrLAPzAX7xQFBeaagX0elOUKbZA0yf/G0QzYKBj3dRudpcm2WpGqnvuKm5goyeKwl
         J4Rc10CEL2P6LSvKc1VwnUTcpui1hmvufso8ERLTl3aLFXT/PiV5P3iQV0nt7uBdQAeu
         udLl8utKF4zjGvoP957fglTmJbIaKYwsVJz5N9nqApCZg9XWQC0Kqu7z4OGpMsOB6dP+
         Cf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kP//8jGyvR7jRjO8JEbG1V4ntX7xDMUlrgYhDGu5V8s=;
        b=gNmRNThWLigqkaD7l4WkK2Ui8gVeb8l8lmnfOtmy3u1uS2c9btx+P8CZQ+pM6czR39
         w0o4be8t6P1hioXQ/TuxBtS0QlStosApYDs9jbr/G4YVWh0QoESgMqYiqLzIJ91vGZVh
         JFd7BY/5NAO0r36UDA6NAeuBo8omCT8JSszglNZ0XzuPbFp+ZYOieBaPj/pX6m0q25Fh
         8FsQHWU5Qsh0uwmul1/2S0XDLypcyGCaWanh3agjZx3e2fqMhi2CyfV4Z4UU5k8Py/cv
         9kjkFhifcAPkIDhRJg+H9A134YYEyswX2olPALNMM2Z9xLVjYBbOT/0thF5RUVtj2HqE
         rkaA==
X-Gm-Message-State: AKS2vOyYjFg6GqeV1w5V5tbUAwd6e8Xe57G7xQHzdELJdRIK9XuTW+Ke
        0A05SrP6Q0ou5A==
X-Received: by 10.200.55.168 with SMTP id d37mr66619773qtc.94.1499456046768;
        Fri, 07 Jul 2017 12:34:06 -0700 (PDT)
Received: from [10.13.138.155] ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id o39sm3383852qto.10.2017.07.07.12.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 12:34:06 -0700 (PDT)
Subject: Re: [PATCH 0/6] Add support for BCM7271 style interrupt controller
References: <20170707192016.13001-1-opendmb@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
From:   Doug Berger <opendmb@gmail.com>
Message-ID: <a801afb1-2f54-2137-6fed-d8f83fe3f8ea@gmail.com>
Date:   Fri, 7 Jul 2017 12:34:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170707192016.13001-1-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opendmb@gmail.com
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

Sorry, messed up the CC list.

On 07/07/2017 12:20 PM, Doug Berger wrote:
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
> for my needs.  The first three commits of this set are intended to be a
> correction and extension of the existing generic irq implementation to
> provide a set of functions that can be used by interrupt controller
> drivers for their irq_mask_ack method.
> 
> I believe these first three commits should be added to the irq/core
> repository and the remaining commits should be added to the Broadcom
> github repository but have included the complete set here for improved
> context.  This entire set is therefore based on the irq/core master
> branch.  Please let me know if you would like a different packaging.
> 
> If the changes to genirq are not acceptable I can implement the
> irq_mask_ask method locally in the irq-brcmstb-l2 driver and submit
> that on its own.
> 
> Doug Berger (5):
>   genirq: generic chip: add generic irq_mask_ack functions
>   genirq: generic chip: remove irq_gc_mask_disable_reg_and_ack()
>   irqchip: brcmstb-l2: Remove some processing from the handler
>   irqchip: brcmstb-l2: Abstract register accesses
>   irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller
> 
> Florian Fainelli (1):
>   irqchip/tango: Use irq_gc_mask_disable_and_ack_set
> 
>  .../bindings/interrupt-controller/brcm,l2-intc.txt |   3 +-
>  drivers/irqchip/irq-brcmstb-l2.c                   | 145 ++++++++++++++-------
>  drivers/irqchip/irq-tango.c                        |   2 +-
>  include/linux/irq.h                                |   7 +-
>  kernel/irq/generic-chip.c                          | 110 +++++++++++++++-
>  5 files changed, 214 insertions(+), 53 deletions(-)
> 
