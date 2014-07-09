Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 18:07:59 +0200 (CEST)
Received: from mail-qc0-f173.google.com ([209.85.216.173]:49061 "EHLO
        mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861344AbaGIQHVSHlvD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 18:07:21 +0200
Received: by mail-qc0-f173.google.com with SMTP id c9so1003975qcz.32
        for <linux-mips@linux-mips.org>; Wed, 09 Jul 2014 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KZ7hEUleCbY1z3LZ6xM/bhFDKkWbTDXh83sZSt5Z2TY=;
        b=hi9BIQrxrsJhP/uQjcmtyFiFScpDhKZpZHSuvTrjlnbLeV/UJrSPzjr1x3prb/NTn4
         cJBdT4tradNrDJLztVE7TNoYjyVBRlMoxTnf0rSjWlrnwO5cT8ulHfcXmZHCqO0ir2Th
         HiHRk9DFHO2l+CkQwq5MTRgSYpuIK6+li84Rz/x/nF1hrB9/WYRElXyypGxrlbHeJoK0
         pyVHKfI0NqbQqvQTkzfaCV9XsRNa7DW4GXpQrO60dIQ6XEqgBXBPzYkkiu0aqTyYkKXU
         T87Hdxu86l9FO+VetMDoS/Q7ZwcrxzXoURO5YiCkUZ8wjGbObTpqPIrjhjqOyr83qnMz
         Pzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KZ7hEUleCbY1z3LZ6xM/bhFDKkWbTDXh83sZSt5Z2TY=;
        b=mByHzhy+ZGythG1XATvq3XGz4/w87n8LLbFDH5avuo3hZ7jsj0jHUs85Z1c12IUHj0
         kAXMD6zdEk89hhM367zKEvJ/+nrliTGrK75WmxSp4eHwJjlmX6Z3DsU5behGc6KeasOR
         Kbjj5W4VqdNNn7m2yxmDPFxzZyfXsNYd4hHcAkZ/mRRu39zZqTHuH9N3Qy7K23EulBv8
         4VgjAtO8kJuDoBEs7NI8UjfRj8eB6ewkhzKPF6UoNPuww6FV7pbTeHXMTtW5Mr9q9Tve
         JdrDQgTgy+RIz67jo6RswuMRCycUZFdofL5EsqJByylth3oqeFnFJB38e1p4NoDq5sEm
         wCoQ==
X-Gm-Message-State: ALoCoQliYjirbaP9CZNP9lR3bjpjZHofLO3VngKCSekBSnOclyb3nsCtEd5GJnrxpDOZ8XA37uLr
X-Received: by 10.140.51.175 with SMTP id u44mr67337796qga.69.1404922028246;
 Wed, 09 Jul 2014 09:07:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.17.198 with HTTP; Wed, 9 Jul 2014 09:06:48 -0700 (PDT)
In-Reply-To: <20140708122606.GB6270@dhcp-26-207.brq.redhat.com>
References: <cover.1402405331.git.agordeev@redhat.com> <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com> <20140704085741.GA12247@dhcp-26-207.brq.redhat.com>
 <CAErSpo6f6RXWv0DEtLBZX0jXoSUYJeWrSm7mubSJ_F-O7tQp6w@mail.gmail.com> <20140708122606.GB6270@dhcp-26-207.brq.redhat.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 9 Jul 2014 10:06:48 -0600
Message-ID: <CAErSpo4oiabgoOjsGdWZpCMPnmopK4xRzB2f3tM0AiUFrdhFww@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41102
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

On Tue, Jul 8, 2014 at 6:26 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> On Mon, Jul 07, 2014 at 01:40:48PM -0600, Bjorn Helgaas wrote:
>> >> Can you quantify the benefit of this?  Can't a device already use
>> >> MSI-X to request exactly the number of vectors it can use?  (I know
>> >
>> > A Intel AHCI chipset requires 16 vectors written to MME while advertises
>> > (via AHCI registers) and uses only 6. Even attempt to init 8 vectors results
>> > in device's fallback to 1 (!).
>>
>> Is the fact that it uses only 6 vectors documented in the public spec?
>
> Yes, it is documented in ICH specs.

Out of curiosity, do you have a pointer to this?  It looks like it
uses one vector per port, and I'm wondering if the reason it requests
16 is because there's some possibility of a part with more than 8
ports.

>> Is this a chipset erratum?  Are there newer versions of the chipset
>> that fix this, e.g., by requesting 8 vectors and using 6, or by also
>> supporting MSI-X?
>
> No, this is not an erratum. The value of 8 vectors is reserved and could
> cause undefined results if used.

As I read the spec (PCI 3.0, sec 6.8.1.3), if MMC contains 0b100
(requesting 16 vectors), the OS is allowed to allocate 1, 2, 4, 8, or
16 vectors.  If allocating 8 vectors and writing 0b011 to MME causes
undefined results, I'd say that's a chipset defect.

>> I know this conserves vector numbers.  What does that mean in real
>> user-visible terms?  Are there systems that won't boot because of this
>> issue, and this patch fixes them?  Does it enable bigger
>> configurations, e.g., more I/O devices, than before?
>
> Visibly, it ceases logging messages ('ahci 0000:00:1f.2: irq 107 for
> MSI/MSI-X') for IRQs that are not shown in /proc/interrupts later.
>
> No, it does not enable/fix any existing hardware issue I am aware of.
> It just saves a couple of interrupt vectors, as Michael put it (10/16
> to be precise). However, interrupt vectors space is pretty much scarce
> resource on x86 and a risk of exhausting the vectors (and introducing
> quota i.e) has already been raised AFAIR.

I'm not too concerned about the logging issue.  If necessary, we could
tweak that message somehow.

Interrupt vector space is the issue I would worry about, but I think
I'm going to put this on the back burner until it actually becomes a
problem.

>> Do you know how Windows handles this?  Does it have a similar interface?
>
> Have no clue, TBH. Can try to investigate if you see it helpful.

No, don't worry about investigating.  I was just curious because if
Windows *did* support something like this, that would be an indication
that there's a significant problem here and we might need to solve it,
too.  But it sounds like we can safely ignore it for now.

Bjorn
