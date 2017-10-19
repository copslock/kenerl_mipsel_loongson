Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 23:59:18 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:50019
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992724AbdJSV7GQkXnL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 23:59:06 +0200
Received: by mail-qt0-x242.google.com with SMTP id k31so16328295qta.6;
        Thu, 19 Oct 2017 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DUg0ulB53QXyUVkscvWnBr6feaQiTjl4VEEwnYBJRQg=;
        b=IavtsRYRgqVcywo6cI7gk65UnRaVItz6YtVhIa5NNvC8f6qWk8bJ9yHCKyU0dv/qw1
         eW2afEVR8wEhRIzsYW0qsxtScnjpj9BOqmZj1miG+YyS+iJ1er2OGKsQmYzO7qqllIqq
         jymE76a/vQ0qAdzQypqubbERSr1KaB7rsZAF15sJXpH1fize4pH/4l1pg4ABJ2bb5ZJk
         De9qPmqD7Flz+QkJS4hxQGQL6LTt9mY4N30uJCIwc6RRWZmlyrhExs0D77Om8qmRq6bl
         5CXkuddqKyJnysMrh8pVKZ2jNLFNRgPqERrJbVFihr8G0F9k6iCJ897nUI8R/cVhbc+E
         eoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DUg0ulB53QXyUVkscvWnBr6feaQiTjl4VEEwnYBJRQg=;
        b=ZjtZ9wsmi7RmcReZwR1/YSBqCgOa0/3xvd8O5X/LzHraBfIeoou6s8ig2Kqn9cmLHI
         GA7rehS39ldeFJK+/X/APVF1mSXgxTrS+SUY6ldvMFxYT1L5jLCKUmeuX9oRKVKc2t1e
         hNyUPyhuQU+QEnwd69X4f7OIFMgLtlkVbKqzMTpW3zZI2wmIWlRUcTCpPwIq35bnZ4tv
         +eqWiLix1Tq5uOc7nCu5ypJuaP3k+TS/cqc15k9775B1MsMF2+5irT++SBevXjnSnmo8
         5BXxpmi+Vods2Mi7AEk0sEKpNUNXi3d8uxxVQ2LSBjuhHAuzy8eXtbQFSzE6R2IFIGQL
         xdAg==
X-Gm-Message-State: AMCzsaVJU2lXKRhxg0bXfmoIyjslV8EaVFmxybwfeqtkJwv7lZBPsEaU
        Fy7ilpcV+pVe9WTWi4fLOMo=
X-Google-Smtp-Source: ABhQp+SjHDwxuxeD8Tb3xQ9wUkeLPfmzVAClfurouDUFuy9H/OUoCuenW7BXSebS4/7ZA/NmLqMIJw==
X-Received: by 10.200.53.111 with SMTP id z44mr4521585qtb.12.1508450339761;
        Thu, 19 Oct 2017 14:58:59 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id v185sm9665363qkd.44.2017.10.19.14.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 14:58:58 -0700 (PDT)
Subject: Re: [PATCH 2/9] PCI: host: brcmstb: add DT docs for Brcmstb PCIe
 device
To:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
 <20171017202418.ykve2o4zvuwxjdgj@rob-hp-laptop>
 <CANCKTBt_gUF8qAEuhS1336Uce+WdP_98ApZhv1sxZgJsWGoiGQ@mail.gmail.com>
 <CAL_JsqLoqB0GF201ofJrjdYH8B-Ca=hGBtE4=VcrBxS7M52mVQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9fae640f-a9da-90bf-01d2-c62131611ef9@gmail.com>
Date:   Thu, 19 Oct 2017 14:58:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLoqB0GF201ofJrjdYH8B-Ca=hGBtE4=VcrBxS7M52mVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60486
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

On 10/19/2017 02:49 PM, Rob Herring wrote:
> On Tue, Oct 17, 2017 at 5:42 PM, Jim Quinlan <jim2101024@gmail.com> wrote:
>> On Tue, Oct 17, 2017 at 4:24 PM, Rob Herring <robh@kernel.org> wrote:
>>> On Wed, Oct 11, 2017 at 06:34:22PM -0400, Jim Quinlan wrote:
>>>> The DT bindings description of the Brcmstb PCIe device is described.  This
>>>> node can be used by almost all Broadcom settop box chips, using
>>>> ARM, ARM64, or MIPS CPU architectures.
>>>>
>>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>>> ---
>>>>  .../devicetree/bindings/pci/brcmstb-pci.txt        | 106 +++++++++++++++++++++
>>>>  1 file changed, 106 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>>>> new file mode 100644
>>>> index 0000000..2f699da
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>>>> @@ -0,0 +1,106 @@
>>>> +Brcmstb PCIe Host Controller Device Tree Bindings
>>>> +We don't; this line is erroneous.
>>>> +Introduction:
>>>> +  The brcmstb host controller closely follows the example set in
>>>> +
>>>> +     [1] http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
>>>> +
>>>> +  The rest of this document explains some added customizations and
>>>> +  offers an example Brcmstb PCIe host controller DT node.
>>>> +
>>>> +Required Properties:
>>>> +  reg -- the register start address and length for the PCIe block.
>>>> +      Additional start,length pairs may be specified for clock addresses.
>>>
>>> Kind of vague and why do you need clock addresses and the clock binding?
>>>
>> We don't;  this line is erroneous and will be removed.
>>
>>> Also, typically the config space is defined here? Is that missing or you
>>> don't support memory mapped config space?
>>>
>> We do not support memory mapped config space.
>>
>>>> +  interrupts -- two interrupts are specified; the first interrupt is for
>>>> +      the PCI host controller and the second is for MSI if the built-in
>>>> +      MSI controller is to be used.
>>>> +  interrupt-names -- names of the interrupts (above): "pcie" and "msi".
>>>> +  compatible -- must be one of: "brcm,bcm7425-pcie", "brcm,bcm7435-pcie",
>>>> +      or "brcm,bcm7278-pcie".
>>>
>>> One compatible per line.
>>>
>> Will fix.
>>
>>>> +  #address-cells -- the number of address cells for PCI-space.
>>>> +  #size-cells -- the number of size cells for PCI-space.
>>>> +  ranges -- See [1]; a specification of the outbound windows for the host
>>>> +      controller.  Each outbound window is described by a n-tuple:
>>>> +          (3 cells) -- PCIe space start address; one cell for attributes
>>>> +                       and two cells for the 64-bit PCIe address.
>>>> +          (x cells) -- CPU/System start address, number of cells is determined
>>>> +                       by the parent node's #address-cells.
>>>> +          (y cells) -- Size of region, number of cells determined by the
>>>> +                       parent node's #size-cells.
>>>> +      Due to hardware limitations, there may be a maximum of four
>>>> +      non-contiguous ranges specified.We don't; this line is erroneous.
>>>> +  #interrupt-cells -- number of cells used to describe the interrupt.
>>>
>>> How many cells?
>>>
>> This line will be removed.
> 
> Humm, why? You need it to have interrupt-map. You just need to say
> what the value is, not what the property is.
> 
>>>> +  interrupt-map-mask -- see [1]; four cells, the first three are zero
>>>> +      for our uses and the fourth cell is the mask (val = 0x7) for
>>>> +      the legacy interrupt number [1..4].
>>>> +  interrupt-map -- See [1]; there are four interrupts (INTA, INTB,
>>>> +      INTC, and INTD) to be mapped; each interrupt requires 5 cells
>>>> +      plus the size of the interrupt specifier.
>>>> +  linux,pci-domain -- the domain of the host controller.
>>>> +
>>>> +Optional Properties:
>>>> +  clocks -- list of clock phandles.  If specified, this should list one
>>>> +      clock.
>>>> +  clock-names -- the "local" names of the clocks specified in 'clocks'.  Note
>>>> +      that if the 'clocks' property is given, 'clock-names' is mandatory,
>>>> +      and the name of the clock is expected to be "sw_pcie".
>>>> +  dma-ranges -- Similar in structure to ranges, each dma region is
>>>> +      specified with a n-tuple.  Dma-regions describe the inbound
>>>> +      accesses from EP to RC; it translates the pci address that the
>>>> +      EP "sees" to the CPU address in memory.  This property is needed
>>>> +      because the design of the Brcmstb memory subsystem often precludes
>>>> +      idenity-mapping between CPU address space and PCIe address space.
>>>> +      Each range is described by a n-tuple:
>>>> +          (3 cells) -- PCIe space start address; one cell for attributes
>>>> +                       and two cells for the 64-bit PCIe address.
>>>> +          (x cells) -- CPU/System start address, number of cells is determined
>>>> +                       by the parent node's #address-cells.
>>>> +          (y cells) -- Size of region, number of cells determined by the
>>>> +                       parent node's #size-cells.
>>>
>>> There's no need to describe standard properties. Just put whatever is
>>> specific to your platform. That applies throughout this doc.
>>>
>> Will fix.
>>
>>>> +  msi-parent -- if MSI is to be used, this must be a phandle to the
>>>> +      msi-parent.  If this prop is set to the phandle of the PCIe
>>>> +      node, or if the msi-parent prop is missing, the PCIE controller
>>>> +      will attempt to use its built in MSI controller.
>>>> +  msi-controller -- this property should only be specified if the
>>>> +      PCIe controller is using its internal MSI controller.
>>>> +  brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
>>>> +  brcm,gen --  (integer) indicates desired generation of link:
>>>> +      1 => 2.5 Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps.
>>>
>>> We have a standard property for this IIRC.
>>>
>> Yes, BrianN pointed that out and it will be fixed.
>>
>>>> +  supply-names -- the names of voltage regulators that the root
>>>> +      complex should turn off/on/on on suspend/resume/boot.  This
>>>> +      is a string list.
>>>> +  supplies -- A collection of phandles to a regulator nodes, see
>>>> +      Documentation/devicetree/bindings/regulator/ for specificWe don't; this line is erroneous.
>>>> +      bindings. The number and order of phandles must match
>>>> +      exactly the number of strings in the "supply-names" property.
>>>
>>> This is not the regulator binding. Use the standard binding.
>>>
>> The reason we do it this way is because the PCIe controller does not
>> know or care what the names of the supplies are, or how many there
>> will be.  The list of regulators can be different for each board we
>> support, as these regulators turn on/off the downstream EP device.
>> All the PCIe controller does is turn on/off this list of regulators
>> when booting,resuming/suspending.
>>
>> An alternative would have the node specifying the standard properties
>>
>> xyz-supply = <&xyz_reg>;
>> abc-supply = <&abc_reg>;
>> pdq-supply = <&pdq_reg>;
>> ...
>>
>> and then have this driver search all of the properties in the PCIe
>> node for names matching /-supply$/, and then create a list of phandles
>> from that.  Is that what you would like?
> 
> Really, you should have child nodes of the PCIe devices and have the
> supplies in there.

While that would be technically more correct this poses a number of issues:

- there is precedence in that area, and you already Acked binding
documents proposing the same thing:
	* Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt (commit
c26ebe98a103479dae9284fe0a86a95af4a5cd46)
	* Documentation/devicetree/bindings/pci/rockchip-pcie.txt (commit
828bdcfbdb98eeb97facb05fe6c96ba0aed65c4a and before)

(which may indicate those should also be corrected, at the possible
expense of creating incompatibilities)

- there is a chicken and egg problem, you can't detect the EP without
turning its regulator on, and if you can't create a pci_device, you
certainly won't be able to associate it with an device_node counterpart

- PCIe being dynamic by nature, can you have "wildcard" PCIE EP DT node
that would be guaranteed to match any physically attached PCIE EP which
is discovered by the PCI bus layer (and then back to issue #2)

If we can solve #2 and #3, it would be reasonable to move the regulator
to a PCIE EP node. Ideally, we may want the generic PCI layer to be
responsible for managing regulators within pci_enable_device() and
pci_disable_device() for instance?

> 
> The driver could do what you describe, but you've still got to define
> the names here.
> 
> Rob
> 


-- 
Florian
