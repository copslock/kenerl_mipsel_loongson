Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 21:33:18 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:34244 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903605Ab2HQTdM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 21:33:12 +0200
Received: by ghbf20 with SMTP id f20so4621830ghb.36
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2012 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=Dyvp5GoUSBiIE8N634qEH0xxnkyt3SR05gB86ibeWA8=;
        b=Xy0nsLcZTvhknsp1R9vY4nLJz5r0dvVxF7qW9rj8xUqxDR1zxR/YYsTRNZpUk42l07
         3E4Xk6xbIx0X1227W5Z9mGmz7Bxpqedz9PwaQZMhsj7g16eEHrjVvfNJRua3qrq4HYeQ
         ww0viJby1zPyz0AYpftaEluL93PzUOYRz/T25YfU6u4Rea+1hSmA+QQdJLCziG4Xu/0Y
         v8lDRbIRx6SjwTfOBS01rExRVVANwHVf7alfkXVP1QA/VxZbreOfUxhh/8VxWhSNvBcm
         OgpYAcaVM7DfVinJMrwXcdnekJF2ENOWpg3ryGwoe9QlNuDAmU6fL5qTmJTtsfnSLPaK
         ZTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=Dyvp5GoUSBiIE8N634qEH0xxnkyt3SR05gB86ibeWA8=;
        b=VeebBX9VsKIdXaCE7Fq+AkjQ+YUOn+HjW0t2wivozNuPsW2Rr1d4V1ZKk6DBVZ4ATo
         5xYi8gv+X/EhwLSiQMFMvhRJhvlkgeTQR2N7tZmAL57WK98Nv/+PRoLUYKgaobc5Q528
         nc7osfSPlBgxapOG5Wk/pYnOoE/8PEaSpuZkqRh9FB/rSW+LooxYEMWXZM7hkYnWRZbe
         cfbsSyV6vPmxo+FgZOMlGaJWlgu91EqRlwJCodgB8Y9hRA9hrh0vfxDv04qFpaVuoght
         vGDGbGjzztl988eGm12+lyEuoTlsC0xYchphnUYsrNMTQ+37U9UgkRwOm/NyidAb7aHQ
         l2VQ==
Received: by 10.50.156.133 with SMTP id we5mr2969747igb.62.1345231985919;
        Fri, 17 Aug 2012 12:33:05 -0700 (PDT)
Received: by 10.50.156.133 with SMTP id we5mr2969733igb.62.1345231985749; Fri,
 17 Aug 2012 12:33:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.26.99 with HTTP; Fri, 17 Aug 2012 12:32:45 -0700 (PDT)
In-Reply-To: <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
References: <502E8115.90507@gmail.com> <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 17 Aug 2012 13:32:45 -0600
Message-ID: <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkL5HAJpWz0O4HuOUSPz5zbYICP9rGBOpvWLjaKJVGYZxcxoFspgYD2xfKp3LMQES32Vu32PVVNVCIh+FMBXUJ1T1lWYd+M3GAIvast53umJCay+WBiWbknqjTF+qfpFiNt8EGMAWclnrjZcvtGFzsEUkYRx+TGotQyDgXEyHHUDD/5VR3hvhbuZ5nLJdHp/f1GZQzT2aLwZPxM48KMZPZzrUL6fw==
X-archive-position: 34258
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
>> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irqs()
>> > around after init) causes:
>> >
>> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from the
>> > function pci_fixup_irqs() to the function .init.text:pcibios_update_irq()
>> >
>> > The MIPS implementation of pcibios_update_irq() is __init, so there is
>> > conflict with the removal of __init from pci_fixup_irqs() and
>> > pdev_fixup_irq().
>> >
>> > Can you guys either remove the patch from linux-next, or improve it to also
>> > fix up any architecture implementations of pdev_update_irq()?
>>
>> Crap, there are lots of arches with this issue.  I'll fix it up.
>> Thanks for pointing it out!
>
> Oh wow... looks like I've opened a can of worms there. This requires
> quite a lot of other functions to have their annotations removed as
> well. Bjorn, how do you want to handle this?

David said "pdev_update_irq()," but I think he meant "pcibios_update_irq()."

Almost all the pcibios_update_irq() implementations are identical, so
I think I'll just supply a weak implementation and remove the
redundant arch versions.

This is just about the only thing in my "next" branch, so I'll clear
it out for now, until we get this resolved.

Bjorn
