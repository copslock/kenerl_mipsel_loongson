Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 22:40:05 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:33646 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903551Ab2HQUkB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 22:40:01 +0200
Received: by iaai1 with SMTP id i1so1000271iaa.36
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2012 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=46MXoqiAbPX1OawZKzGTl91jBHlMzVjZO0AII6sU/s0=;
        b=NCc0azCuJZVmz2VICWi5iCa96xDU4f5NTZWHoiRWqU74He42rVyjyHQ3Mb9kOc0JoK
         +5d1qmQ9IVLs6pNRSnUyDcZ3LuDmmFikmhBSu89Ixgw0vt+5Ujdx1J2JNtLYGa/UJ8G4
         9ZRrUukCbv8wMua8kO2q3nPw+GH3QQVDbhqw/E/x7q/MbxDjhieWxwOPfhr2ZWEAbpTl
         XY285sQDLN9or7NlcMmz/g8tZOD21aRNXqIRfaDTL31LmIjOCrJtD4APdUSrbGYKBlMK
         WA5SxcnzyaQpL1SxS0cp5BvVXjFnsmls7I0WC+bP1yWxaFawjbvWK5p8hr+LbMpajM8X
         H0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=46MXoqiAbPX1OawZKzGTl91jBHlMzVjZO0AII6sU/s0=;
        b=pHHcK18zBuJg6Hc28rMF/g535daFnMOyIO3W7h9crp8pMnFVuzjKv2GpFXU/UNrrfs
         0TYBzesQ4D/GMUJ211NK00FosF44JOJGCTo4oOSbxKdGkTEFxrLbButaLr5D+daaRTWp
         AvsrmbrUL882EeOkUvBWZ7lu9r7QDUZBq1u+mx+L6H9BqdkK3jFpgbiqZcO+qs9os3TY
         /PTGT943SpVfGYmBRbcoT8KlPHlO4FaMRP6Lq0u11ilBu57TZ+WxKjmlqoJ2pKVNtdon
         7tW7evuRJt+OZUgqozFL15opQKf7QsdL155kmJ1gTGRaD+g+JHZwJnvEp0rDKic8S0fY
         QXoQ==
Received: by 10.43.48.129 with SMTP id uw1mr5434910icb.10.1345235994861;
        Fri, 17 Aug 2012 13:39:54 -0700 (PDT)
Received: by 10.43.48.129 with SMTP id uw1mr5434901icb.10.1345235994709; Fri,
 17 Aug 2012 13:39:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.26.99 with HTTP; Fri, 17 Aug 2012 13:39:34 -0700 (PDT)
In-Reply-To: <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
References: <502E8115.90507@gmail.com> <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com> <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 17 Aug 2012 14:39:34 -0600
Message-ID: <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQm4Q9JnCI2nc5KZVTMNtShCL/XXL8IFTs5VKgWlj0db8l9r7TiBEikMpUoDDXOr/2um7pNdSm3CjG9I07xnvljxvKlllY0+ClD6br53ECAN39oVTtoJ7JFgqKDFczOS4ey3HecwfiwZIe9Hp1bex+qnCMacoYdh0hHvGiatI6pTjSNml9eqlIBry4L7N/KHNcUinvosGMDhesshhD1Akgff9dY4zA==
X-archive-position: 34260
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

On Fri, Aug 17, 2012 at 2:07 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Aug 17, 2012 at 01:32:45PM -0600, Bjorn Helgaas wrote:
>> On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
>> >> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>> >> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irqs()
>> >> > around after init) causes:
>> >> >
>> >> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from the
>> >> > function pci_fixup_irqs() to the function .init.text:pcibios_update_irq()
>> >> >
>> >> > The MIPS implementation of pcibios_update_irq() is __init, so there is
>> >> > conflict with the removal of __init from pci_fixup_irqs() and
>> >> > pdev_fixup_irq().
>> >> >
>> >> > Can you guys either remove the patch from linux-next, or improve it to also
>> >> > fix up any architecture implementations of pdev_update_irq()?
>> >>
>> >> Crap, there are lots of arches with this issue.  I'll fix it up.
>> >> Thanks for pointing it out!
>> >
>> > Oh wow... looks like I've opened a can of worms there. This requires
>> > quite a lot of other functions to have their annotations removed as
>> > well. Bjorn, how do you want to handle this?
>>
>> David said "pdev_update_irq()," but I think he meant "pcibios_update_irq()."
>>
>> Almost all the pcibios_update_irq() implementations are identical, so
>> I think I'll just supply a weak implementation and remove the
>> redundant arch versions.
>
> That makes sense. However I've just tested a build with section mismatch
> debugging enabled on ARM and there are a few more that need __init or
> __devinit removed to get rid of the warnings:
>
>         pci_common_init()
>         pcibios_init_hw()
>         pcibios_init_resources()
>         pcibios_swizzle()
>         pcibios_update_irq()
>
> pci_scan_root_bus() also needs __devinit removed. I haven't checked the
> other architectures because I'll have to build cross-compilers for them
> first, but I suspect most of them will have a similar list. I'm not sure
> how well this kind of change is going to go down with the respective
> architecture maintainers, though.

Hmm, yeah, this is a mess, isn't it?  Just about everything in PCI
will need __devinit removed.  We've been assuming that the only way
for things to show up after init is via hotplug.  But you're breaking
that assumption by doing *all* enumeration after init.  There are
approximately a bajillion __init and __devinit annotations just in
drivers/pci, not to mention those in the architectures.

Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
affect you?  I think we would still have to change some __inits to
__devinit, including pcibios_update_irq(), but it might be more
manageable.

I started working on this, but it sounds like you're in a better
position to find problems and test fixes, so how about if I just let
you handle it? :)

Bjorn
