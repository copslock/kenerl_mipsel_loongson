Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 14:47:15 +0200 (CEST)
Received: from mail-qc0-f180.google.com ([209.85.216.180]:35207 "EHLO
        mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009142AbbDDMrMv5TFx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 14:47:12 +0200
Received: by qcbii10 with SMTP id ii10so81339975qcb.2
        for <linux-mips@linux-mips.org>; Sat, 04 Apr 2015 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4NB6s0QyN/nmgbXXTo+WF37M55j1VcCdFq/+rU5rDsY=;
        b=dYQb/6zolGd/mWPR1s9djGQgeukqgMa41NZiHY25nw1nlE4faVfkeunr+Ldgr5zdik
         O7iCE845+ykKMHiEbN6JEV2bNePpX3dBV3nu/3paOoqiY6ntiyzuoJm3eknrOw6PgRfM
         EDH52iKO3ciN77ZRTXuyTJDfS669I5z6USOGiPZn3h4rJ/0Wz8wQaWTy1Dkbs6B9DcQN
         wEJhDbtszupb/08j7LrBAf1Ih3u+Ujgzdf3MjvMev46E4OzzT3P3BdMr2BPv09hystMS
         CQ9Z51rC9CF4QnmauKUP/cvgs1gr1RdJSoU9UOp1kPdjX92dG46FQsZGGONrb1ERL5z4
         BOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4NB6s0QyN/nmgbXXTo+WF37M55j1VcCdFq/+rU5rDsY=;
        b=CJuBfEnypUeK0gSRGo6OoKlNMlgjs6PHPHTunXJbbxiwTvuT0v1Wj58liuDu1cA25T
         Yu9E/HRjAIJsO9KLE5rr1SON7Q1GHispIKPMz/58FMpvB+Y86S1ZwMpijhSTgqK14YT/
         MJWlT+COjEBHW3TU/pH17rIapCVLTDpjQZf4QnJ/Cl0KHuffzO4eWQh2eXjCeRHMx/ee
         31TrhfcPjl2r3XvUOOp+xIB33VCENpQv3QMaDLxl6J0ktIH0qCsEAx8/K7XxybH09NAq
         jYDOnVb7S8yx4OYOclchsL2oyHaR9MX5b0qq1j7zRtpoqUKWd9AdGJOxt+fBLSJ4EReR
         uHxA==
X-Gm-Message-State: ALoCoQmpupgSjdu4RCONwqG1FbdTjMtBrUF7giLi5oEQ2q/99f6RyTJielLaavUmvbpvYvJNPNiX
X-Received: by 10.140.234.17 with SMTP id f17mr7985659qhc.64.1428151627754;
 Sat, 04 Apr 2015 05:47:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.163.78 with HTTP; Sat, 4 Apr 2015 05:46:47 -0700 (PDT)
In-Reply-To: <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org> <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com> <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat, 4 Apr 2015 07:46:47 -0500
Message-ID: <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
To:     Yinghai Lu <yinghai@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        David Ahern <david.ahern@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Fri, Apr 3, 2015 at 10:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Apr 3, 2015 at 1:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Sam (commented on previous versions), Russell, linux-arm-kernel, Ralf,
>> linux-mips, Ben, linuxppc-dev, x86]
>>
>> On Fri, Apr 03, 2015 at 02:32:34PM -0500, Bjorn Helgaas wrote:
>>> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
>>> > David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
>>> > to fit in upstream windows") broke booting on sparc/T5-8.
>>> >
>>> > In the boot log, there is
>>> >   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>>> >   0x110204000)
>>> > but that only could happen when dma_addr_t is 32-bit.
>>> >
>>> > According to David Miller, all DMA occurs behind an IOMMU and these
>>> > IOMMUs only support 32-bit addressing, therefore dma_addr_t is
>>> > 32-bit on sparc64.
>>> >
>>> > Let's introduce pci_bus_addr_t instead of using dma_addr_t,
>>> > and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
>>> >
>>> > Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
>>> > Fixes: commit 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
>>> > Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
>>> > Reported-by: David Ahern <david.ahern@oracle.com>
>>> > Tested-by: David Ahern <david.ahern@oracle.com>
>>> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>> > Cc: <stable@vger.kernel.org> #3.19
>>> > ---
>>> >  drivers/pci/Kconfig |  4 ++++
>>> >  drivers/pci/bus.c   | 10 +++++-----
>>> >  drivers/pci/probe.c | 12 ++++++------
>>> >  include/linux/pci.h | 12 +++++++++---
>>> >  4 files changed, 24 insertions(+), 14 deletions(-)
>>> >
>>> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> > index 7a8f1c5..6a5a269 100644
>>> > --- a/drivers/pci/Kconfig
>>> > +++ b/drivers/pci/Kconfig
>>> > @@ -1,6 +1,10 @@
>>> >  #
>>> >  # PCI configuration
>>> >  #
>>> > +config PCI_BUS_ADDR_T_64BIT
>>> > +   def_bool y if (64BIT || X86_PAE)
>>> > +   depends on PCI
>>>
>>> We're going to use pci_bus_addr_t in some places where we previously used
>>> dma_addr_t, which means pci_bus_addr_t should be at least as large as
>>> dma_addr_t.  Can you enforce that directly, e.g., with something like this?
>>>
>>>     def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT || X86_PAE)
>
> then should use
>
> def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)

OK, would you mind updating this series, incorporating the doc
updates, and reposting it?

I think there's still an unresolved question about the OF parsing code.

Bjorn
