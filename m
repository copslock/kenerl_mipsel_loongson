Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 22:09:01 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:35477
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993853AbdFWUIz2VBpL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 22:08:55 +0200
Received: by mail-wr0-x241.google.com with SMTP id z45so15055784wrb.2;
        Fri, 23 Jun 2017 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XXMHEFtqescakFEXS+ka7gsNCMAGoic+1trKkQvPrk8=;
        b=aveAxdfEYoU3pLxHhBrkeBkzVOD4IVE0SJaoi0dwzwGCkGh2VUcgTVmpnJgpvJrGJk
         uaZoCnvSj2AV4Q5TW8gDIh+wqQSEcHIsRzeBW6+FGMMnV8W7n1ZCMkqT+iw5hGMz2IOv
         L6jRAK113u9hSVLhN4U0XR8UvE8G/X7Y34C0awg91t719hk7BVV2151Aaqtf5Glqn4ED
         miv1tYPXCN7or+KGAo/9qAjd0wH6DSRZ/h8qM2HHN5B9JnE6E1kzQ7rXGyq5ANocMm2o
         wtOwYswayoF6DDDzJZDQVEh912Evl1NLAXxamgWiOaYEXRfdCAb9vOetWdFFw25cKhMf
         tOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XXMHEFtqescakFEXS+ka7gsNCMAGoic+1trKkQvPrk8=;
        b=sg+tLtvDTScnq3xtnpdnR2LaEEh6mIn2e9AzA+aPTRDOTzLga/mPTfZN26RzcDlNjs
         B+ydGg10+pe9mtrCWWHqvEtlJOLt3m4OcKUJ8KLJqgrLFe0fa6zPDxoBDJmriI9TRoHZ
         hS1KWoo2Jacibvkyrkv3CSa955/ys8yhl6kMhjrS0HelzeMtAg6n1jGynpaDWv5JVHyn
         LGx1IQ5zzOsayIQFyAxbgvBxZtpM7vqp/VDhUzKD4woZbNbmYVMbCa22+K+Fyt0FM1dp
         zmlH+WcL4TLDi8fgDCfe9dQrtNpuXmFD/Podddu9Va3hOj7cViT145XtuVFFb0NH2aAu
         EL7g==
X-Gm-Message-State: AKS2vOzrw8Jgs9E1zLx3WafyBtJRsn/2R9w1UGoBHEAZZiY1CMhYSqOm
        YhrQO/WArJoRdw==
X-Received: by 10.223.131.162 with SMTP id 31mr3049403wre.161.1498248529892;
        Fri, 23 Jun 2017 13:08:49 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id l46sm6764879wrl.15.2017.06.23.13.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 13:08:49 -0700 (PDT)
Subject: Re: [PATCH 4/5] dt-bindings: Document MIPS Broadcom STB power
 management nodes
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
 <20170616213703.21487-5-f.fainelli@gmail.com>
 <20170623200229.p6pp4g2hvkei4doj@rob-hp-laptop>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e21d2356-4096-a53c-2d55-7f3b8f09ff0a@gmail.com>
Date:   Fri, 23 Jun 2017 13:08:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170623200229.p6pp4g2hvkei4doj@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58769
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

On 06/23/2017 01:02 PM, Rob Herring wrote:
> On Fri, Jun 16, 2017 at 02:37:02PM -0700, Florian Fainelli wrote:
>> Document the different nodes required for supporting S2/S3/S5 suspend
>> states on MIPS-based Broadcom STB SoCs.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../devicetree/bindings/mips/brcm/soc.txt          | 77 ++++++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> index e4e1cd91fb1f..f7413168d938 100644
>> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> @@ -11,3 +11,80 @@ Required properties:
>>  
>>  The experimental -viper variants are for running Linux on the 3384's
>>  BMIPS4355 cable modem CPU instead of the BMIPS5000 application processor.
>> +
>> +Power management
>> +----------------
>> +
>> +For power management (particularly, S2/S3/S5 system suspend), the following SoC
>> +components are needed:
>> +
>> += Always-On control block (AON CTRL)
>> +
>> +This hardware provides control registers for the "always-on" (even in low-power
>> +modes) hardware, such as the Power Management State Machine (PMSM).
>> +
>> +Required properties:
>> +- compatible     : should contain "brcm,brcmstb-aon-ctrl"
> 
> Exact same block on all SoCs?

Not quite exactly the same, I will put something more SoC-specific in
the binding here.

> 
>> +- reg            : the register start and length for the AON CTRL block
>> +
>> +Example:
>> +
>> +aon-ctrl@410000 {
> 
> syscon@...
> 
>> +	compatible = "brcm,brcmstb-aon-ctrl";
>> +	reg = <0x410000 0x400>;
>> +};
>> +
>> += Memory controllers
>> +
>> +A Broadcom STB SoC typically has a number of independent memory controllers,
>> +each of which may have several associated hardware blocks, which are versioned
>> +independently (control registers, DDR PHYs, etc.). One might consider
>> +describing these controllers as a parent "memory controllers" block, which
>> +contains N sub-nodes (one for each controller in the system), each of which is
>> +associated with a number of hardware register resources (e.g., its PHY). See
>> +the example device tree snippet below.
> 
> What example?

Whoops, that's indeed missing.

> 
>> +
>> +== MEMC (MEMory Controller)
>> +
>> +Represents a single memory controller instance.
>> +
>> +Required properties:
>> +- compatible     : should contain "brcm,brcmstb-memc" and "simple-bus"
> 
> No registers for the controller?

There are indeed registers, thanks for catching that.

> 
>> +
>> +Should contain subnodes for any of the following relevant hardware resources:
>> +
>> +== DDR PHY control
>> +
>> +Control registers for this memory controller's DDR PHY.
>> +
>> +Required properties:
>> +- compatible     : should contain one of these
>> +	"brcm,brcmstb-ddr-phy-v64.5"
>> +	"brcm,brcmstb-ddr-phy"
>> +
>> +- reg            : the DDR PHY register range
>> +
>> +== MEMC Arbiter
>> +
>> +The memory controller arbiter is responsible for memory clients allocation
>> +(bandwidth, priorities etc.) and needs to have its contents restored during
>> +deep sleep states (S3).
>> +
>> +Required properties:
>> +
>> +- compatible	: should contain one of these
>> +	"brcm,brcmstb-memc-arb-v10.0.0.0"
>> +	"brcm,brcmstb-memc-arb"
>> +
>> +- reg		: the DDR Arbiter register range
>> +
>> +== Timers
>> +
>> +The Broadcom STB chips contain a timer block with several general purpose
>> +timers that can be used.
>> +
>> +Required properties:
>> +
>> +- compatible	: should contain "brcm,brcmstb-timers"
>> +- reg		: the timers register range
>> +
>> -- 
>> 2.9.3
>>


-- 
Florian
