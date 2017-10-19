Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 23:50:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992675AbdJSVtyS9JKL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Oct 2017 23:49:54 +0200
Received: from mail-qt0-f182.google.com (mail-qt0-f182.google.com [209.85.216.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3277621923;
        Thu, 19 Oct 2017 21:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3277621923
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qt0-f182.google.com with SMTP id n61so16289551qte.10;
        Thu, 19 Oct 2017 14:49:49 -0700 (PDT)
X-Gm-Message-State: AMCzsaXQB1sGsy7i/eQS3oSNaQZxS4xuJOTpEVQJ6xd/3bPTc4ZSO8P8
        dpREqyS4Myh3yRsiVoKeKk9Et2DBstQoVMdrjA==
X-Google-Smtp-Source: ABhQp+Rbffl/C93YhCeuW6Ib3p1wrLgWuL7maaXZ5Whc+vTxjZZS9zfWFTsipSj+AWM5Ek22PnogaKjMu+bbMyb/C0A=
X-Received: by 10.200.35.147 with SMTP id q19mr4167895qtq.262.1508449788254;
 Thu, 19 Oct 2017 14:49:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.130.134 with HTTP; Thu, 19 Oct 2017 14:49:27 -0700 (PDT)
In-Reply-To: <CANCKTBt_gUF8qAEuhS1336Uce+WdP_98ApZhv1sxZgJsWGoiGQ@mail.gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-3-git-send-email-jim2101024@gmail.com> <20171017202418.ykve2o4zvuwxjdgj@rob-hp-laptop>
 <CANCKTBt_gUF8qAEuhS1336Uce+WdP_98ApZhv1sxZgJsWGoiGQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Oct 2017 16:49:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLoqB0GF201ofJrjdYH8B-Ca=hGBtE4=VcrBxS7M52mVQ@mail.gmail.com>
Message-ID: <CAL_JsqLoqB0GF201ofJrjdYH8B-Ca=hGBtE4=VcrBxS7M52mVQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] PCI: host: brcmstb: add DT docs for Brcmstb PCIe device
To:     Jim Quinlan <jim2101024@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60484
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

On Tue, Oct 17, 2017 at 5:42 PM, Jim Quinlan <jim2101024@gmail.com> wrote:
> On Tue, Oct 17, 2017 at 4:24 PM, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Oct 11, 2017 at 06:34:22PM -0400, Jim Quinlan wrote:
>>> The DT bindings description of the Brcmstb PCIe device is described.  This
>>> node can be used by almost all Broadcom settop box chips, using
>>> ARM, ARM64, or MIPS CPU architectures.
>>>
>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>> ---
>>>  .../devicetree/bindings/pci/brcmstb-pci.txt        | 106 +++++++++++++++++++++
>>>  1 file changed, 106 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>>> new file mode 100644
>>> index 0000000..2f699da
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>>> @@ -0,0 +1,106 @@
>>> +Brcmstb PCIe Host Controller Device Tree Bindings
>>> +We don't; this line is erroneous.
>>> +Introduction:
>>> +  The brcmstb host controller closely follows the example set in
>>> +
>>> +     [1] http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
>>> +
>>> +  The rest of this document explains some added customizations and
>>> +  offers an example Brcmstb PCIe host controller DT node.
>>> +
>>> +Required Properties:
>>> +  reg -- the register start address and length for the PCIe block.
>>> +      Additional start,length pairs may be specified for clock addresses.
>>
>> Kind of vague and why do you need clock addresses and the clock binding?
>>
> We don't;  this line is erroneous and will be removed.
>
>> Also, typically the config space is defined here? Is that missing or you
>> don't support memory mapped config space?
>>
> We do not support memory mapped config space.
>
>>> +  interrupts -- two interrupts are specified; the first interrupt is for
>>> +      the PCI host controller and the second is for MSI if the built-in
>>> +      MSI controller is to be used.
>>> +  interrupt-names -- names of the interrupts (above): "pcie" and "msi".
>>> +  compatible -- must be one of: "brcm,bcm7425-pcie", "brcm,bcm7435-pcie",
>>> +      or "brcm,bcm7278-pcie".
>>
>> One compatible per line.
>>
> Will fix.
>
>>> +  #address-cells -- the number of address cells for PCI-space.
>>> +  #size-cells -- the number of size cells for PCI-space.
>>> +  ranges -- See [1]; a specification of the outbound windows for the host
>>> +      controller.  Each outbound window is described by a n-tuple:
>>> +          (3 cells) -- PCIe space start address; one cell for attributes
>>> +                       and two cells for the 64-bit PCIe address.
>>> +          (x cells) -- CPU/System start address, number of cells is determined
>>> +                       by the parent node's #address-cells.
>>> +          (y cells) -- Size of region, number of cells determined by the
>>> +                       parent node's #size-cells.
>>> +      Due to hardware limitations, there may be a maximum of four
>>> +      non-contiguous ranges specified.We don't; this line is erroneous.
>>> +  #interrupt-cells -- number of cells used to describe the interrupt.
>>
>> How many cells?
>>
> This line will be removed.

Humm, why? You need it to have interrupt-map. You just need to say
what the value is, not what the property is.

>>> +  interrupt-map-mask -- see [1]; four cells, the first three are zero
>>> +      for our uses and the fourth cell is the mask (val = 0x7) for
>>> +      the legacy interrupt number [1..4].
>>> +  interrupt-map -- See [1]; there are four interrupts (INTA, INTB,
>>> +      INTC, and INTD) to be mapped; each interrupt requires 5 cells
>>> +      plus the size of the interrupt specifier.
>>> +  linux,pci-domain -- the domain of the host controller.
>>> +
>>> +Optional Properties:
>>> +  clocks -- list of clock phandles.  If specified, this should list one
>>> +      clock.
>>> +  clock-names -- the "local" names of the clocks specified in 'clocks'.  Note
>>> +      that if the 'clocks' property is given, 'clock-names' is mandatory,
>>> +      and the name of the clock is expected to be "sw_pcie".
>>> +  dma-ranges -- Similar in structure to ranges, each dma region is
>>> +      specified with a n-tuple.  Dma-regions describe the inbound
>>> +      accesses from EP to RC; it translates the pci address that the
>>> +      EP "sees" to the CPU address in memory.  This property is needed
>>> +      because the design of the Brcmstb memory subsystem often precludes
>>> +      idenity-mapping between CPU address space and PCIe address space.
>>> +      Each range is described by a n-tuple:
>>> +          (3 cells) -- PCIe space start address; one cell for attributes
>>> +                       and two cells for the 64-bit PCIe address.
>>> +          (x cells) -- CPU/System start address, number of cells is determined
>>> +                       by the parent node's #address-cells.
>>> +          (y cells) -- Size of region, number of cells determined by the
>>> +                       parent node's #size-cells.
>>
>> There's no need to describe standard properties. Just put whatever is
>> specific to your platform. That applies throughout this doc.
>>
> Will fix.
>
>>> +  msi-parent -- if MSI is to be used, this must be a phandle to the
>>> +      msi-parent.  If this prop is set to the phandle of the PCIe
>>> +      node, or if the msi-parent prop is missing, the PCIE controller
>>> +      will attempt to use its built in MSI controller.
>>> +  msi-controller -- this property should only be specified if the
>>> +      PCIe controller is using its internal MSI controller.
>>> +  brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
>>> +  brcm,gen --  (integer) indicates desired generation of link:
>>> +      1 => 2.5 Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps.
>>
>> We have a standard property for this IIRC.
>>
> Yes, BrianN pointed that out and it will be fixed.
>
>>> +  supply-names -- the names of voltage regulators that the root
>>> +      complex should turn off/on/on on suspend/resume/boot.  This
>>> +      is a string list.
>>> +  supplies -- A collection of phandles to a regulator nodes, see
>>> +      Documentation/devicetree/bindings/regulator/ for specificWe don't; this line is erroneous.
>>> +      bindings. The number and order of phandles must match
>>> +      exactly the number of strings in the "supply-names" property.
>>
>> This is not the regulator binding. Use the standard binding.
>>
> The reason we do it this way is because the PCIe controller does not
> know or care what the names of the supplies are, or how many there
> will be.  The list of regulators can be different for each board we
> support, as these regulators turn on/off the downstream EP device.
> All the PCIe controller does is turn on/off this list of regulators
> when booting,resuming/suspending.
>
> An alternative would have the node specifying the standard properties
>
> xyz-supply = <&xyz_reg>;
> abc-supply = <&abc_reg>;
> pdq-supply = <&pdq_reg>;
> ...
>
> and then have this driver search all of the properties in the PCIe
> node for names matching /-supply$/, and then create a list of phandles
> from that.  Is that what you would like?

Really, you should have child nodes of the PCIe devices and have the
supplies in there.

The driver could do what you describe, but you've still got to define
the names here.

Rob
