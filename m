Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 21:49:25 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38828 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010451AbbDDTtXQCTo- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 21:49:23 +0200
Received: by wiun10 with SMTP id n10so991880wiu.1;
        Sat, 04 Apr 2015 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lt/3/WwXOV7tFZgdZYuda3BWyUtoR3z2+hDGfwmovAE=;
        b=w6aYyUtWA2yndqacH4XkoBLvItUFYHdnw5smN/Wrz5wO+xEv2uwYFnya/MjXP289GF
         08RwwlTvViEM1nlTDx5RB8oiMy1PkmiVnQb7RQiRv60kSY2klWPmQ7ptzST79IoFL/NX
         JV4Bsny3i2wYIh95Ghdqsy7cXOC+u6WlYE9ljfhopB23Q4uiRWFPbyFpR9NtJ3xVAIJg
         0bjGX9zzxMTxIVmctD+zKW6VyvKLxDXmXXT9X01+j/SVPQhKgXwmiSzCIK1NgcTve+MA
         G9O4+F++IHfsvgVMasQ6luIonK/GTAf/1Ojo9EqevQTriZ5l7ADSPqIKW4gN9t6MLvOf
         y1Kw==
X-Received: by 10.194.179.38 with SMTP id dd6mr7781945wjc.149.1428176959218;
 Sat, 04 Apr 2015 12:49:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.139.21 with HTTP; Sat, 4 Apr 2015 12:48:59 -0700 (PDT)
In-Reply-To: <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org> <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com> <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
 <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Sat, 4 Apr 2015 14:48:59 -0500
Message-ID: <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Yinghai Lu <yinghai@kernel.org>,
        David Ahern <david.ahern@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Miller <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Sat, Apr 4, 2015 at 7:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Apr 3, 2015 at 10:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Apr 3, 2015 at 1:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> [+cc Sam (commented on previous versions), Russell, linux-arm-kernel, Ralf,
>>> linux-mips, Ben, linuxppc-dev, x86]
>>>
>>> On Fri, Apr 03, 2015 at 02:32:34PM -0500, Bjorn Helgaas wrote:
>>>> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
>>>> > David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
>>>> > to fit in upstream windows") broke booting on sparc/T5-8.
>>>> >
>>>> > In the boot log, there is
>>>> >   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>>>> >   0x110204000)
>>>> > but that only could happen when dma_addr_t is 32-bit.
>>>> >
>>>> > According to David Miller, all DMA occurs behind an IOMMU and these
>>>> > IOMMUs only support 32-bit addressing, therefore dma_addr_t is
>>>> > 32-bit on sparc64.
>>>> >
>>>> > Let's introduce pci_bus_addr_t instead of using dma_addr_t,
>>>> > and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
>>>> >
>>>> > Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
>>>> > Fixes: commit 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
>>>> > Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
>>>> > Reported-by: David Ahern <david.ahern@oracle.com>
>>>> > Tested-by: David Ahern <david.ahern@oracle.com>
>>>> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>>> > Cc: <stable@vger.kernel.org> #3.19
>>>> > ---
>>>> >  drivers/pci/Kconfig |  4 ++++
>>>> >  drivers/pci/bus.c   | 10 +++++-----
>>>> >  drivers/pci/probe.c | 12 ++++++------
>>>> >  include/linux/pci.h | 12 +++++++++---
>>>> >  4 files changed, 24 insertions(+), 14 deletions(-)
>>>> >
>>>> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>>> > index 7a8f1c5..6a5a269 100644
>>>> > --- a/drivers/pci/Kconfig
>>>> > +++ b/drivers/pci/Kconfig
>>>> > @@ -1,6 +1,10 @@
>>>> >  #
>>>> >  # PCI configuration
>>>> >  #
>>>> > +config PCI_BUS_ADDR_T_64BIT
>>>> > +   def_bool y if (64BIT || X86_PAE)
>>>> > +   depends on PCI
>>>>
>>>> We're going to use pci_bus_addr_t in some places where we previously used
>>>> dma_addr_t, which means pci_bus_addr_t should be at least as large as
>>>> dma_addr_t.  Can you enforce that directly, e.g., with something like this?
>>>>
>>>>     def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT || X86_PAE)
>>
>> then should use
>>
>> def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
>
> OK, would you mind updating this series, incorporating the doc
> updates, and reposting it?
>
> I think there's still an unresolved question about the OF parsing code.

Got a pointer to what that is? I'll take a guess. Generally, we make
the parsing code independent of the kernel addr sizes and use u64
types. The DT sizes and kernel sizes are not always aligned. For
example, an LPAE capable platform running a non-LPAE kernel build.

Rob

>
> Bjorn
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
