Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 19:30:33 +0100 (CET)
Received: from mail-it0-x22c.google.com ([IPv6:2607:f8b0:4001:c0b::22c]:38239
        "EHLO mail-it0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdBGSaZtb1GV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 19:30:25 +0100
Received: by mail-it0-x22c.google.com with SMTP id c7so85724267itd.1
        for <linux-mips@linux-mips.org>; Tue, 07 Feb 2017 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9APAum9Qam6ST13VBG1+pjx7gaHJGJrMLCEeuxlEuD0=;
        b=b+gnD0PvmKcqNdYCwU4Jbq9kbptFlXnRaq9YbAEgV7clCh1gzuHLNns7Kkp8GJAq5t
         7kt3dFMedszPpfJccxcZjm1tBDqbUvIZjFyB9vmAfS2Uvp25TRlfpidcGMhVJ0JrjI7h
         4YwMkkp8NOK5MLrWAPx57E7Nmkpz8HWWStH+IPbBhrU+Z+ggRAoQOCZRTHtplllZR99N
         HPNWhSESS0npJSguZwWRQH9482waWVZeXW9ic6TV6pqpQq8RrBBCTMalDaX8R1Kkfyyi
         sc4dx6FwkzkKyyhOm2di4dTi6KU7cpcmha/e6rQhQSCqhtbS/yp+n1B8ZlN0NrUP8Pgm
         buSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9APAum9Qam6ST13VBG1+pjx7gaHJGJrMLCEeuxlEuD0=;
        b=iVnBn2aSqh0EWW3WrDPQoPEDnS75Qmwa6vuM3tGDTEuOEfcWX7azs8ThTfxfn7P+kh
         jaf/jeBKFcnBodK9yDZHJvFyaJvZWUgRKq9Su77Bx/wOUD6aOTcF7hZReG+wqHCqiz+Z
         zryfHDbUWfv9H5ZD0fOapRD4EuQ6Jk6tEEuMQRpsUHrUv8YtbkLVESog4G07Uujo8i3Z
         an3iFVFa9AkLvTTTOwAZrMpv4vYLJIIlNxbPkkhZg2DFK/Y6gLJcRW9QVq8KaxjTzFg1
         UUy7y2pz8OEvR5iaivX5ht0u+63+KmaGDz7K49TyPHemXTmOBBxcFXCNpqA97054s199
         mVJg==
X-Gm-Message-State: AIkVDXIpre9wZLmlbSZWR3x9ED+tO5nmCqG+1ETRnNOdJe5wdFDpJj+iOeRMgI5/pE0KDZG/A0CBflXQnGPX/YHB
X-Received: by 10.36.25.83 with SMTP id b80mr13197712itb.98.1486492219959;
 Tue, 07 Feb 2017 10:30:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.153.66 with HTTP; Tue, 7 Feb 2017 10:29:59 -0800 (PST)
In-Reply-To: <20170207061356.8270-13-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org> <20170207061356.8270-13-kumba@gentoo.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 7 Feb 2017 12:29:59 -0600
Message-ID: <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Linux/MIPS" <linux-mips@linux-mips.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56699
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

Hi Joshua,

First of all, apologies for breaking IP27 and the inconvenience this
caused you.  And thanks a lot for tracking down the problem and
proposing a solution!

On Tue, Feb 7, 2017 at 12:13 AM, Joshua Kinard <kumba@gentoo.org> wrote:
> From: Joshua Kinard <kumba@gentoo.org>
>
> Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
> will now explicitly claim PCI resources instead of skipping the sizing
> of the bridges and assigning resources.  This is okay for IP30's PCI
> code, which doesn't use physical address space to access I/O resources.
>
> However, IP27 is completely different in this regard.  Instead of using
> ioremapped addresses for I/O, IP27 has a dedicated address range,
> 0x92xxxxxxxxxxxxxx, that is used for all I/O access.  Since this is
> uncached physical address space, the generic MIPS PCI code will not
> probe it correctly and thus, the original behavior of PCI_PROBE_ONLY
> needs to be restored only for the IP27 platform to bypass this logic
> and have working PCI, at least for the IO6/IO6G board that houses the
> base devices, until a better solution is found.

It sounds like there's something different about how ioremap() works
on these platforms and PCI probing is tripping over that.  I'd really
like to understand more about this difference to see if we can
converge that instead of adding back the PCI_PROBE_ONLY usage.

Drivers shouldn't know whether they're running on IP27 or IP30, and
they should be using ioremap() in both cases.  Does ioremap() work
differently on IP27 and IP30?  Does this have something to do with
plat_ioremap() or fixup_bigphys_addr()?

Is there any chance you can collect complete dmesg logs and
/proc/iomem contents from IP27 and IP30?  Maybe "lspci -vv" output,
too?  I'm not sure where to look to understand the ioremap() behavior.

What exactly is the PCI probe failure without this patch?  If you have
a console log (with "ignore_loglevel") it might have a clue, too.

> Fixes: 046136170a56 ("MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups")
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/pci/pci-bridge.c | 15 +++++++++++++++
>  arch/mips/pci/pci-legacy.c | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/arch/mips/pci/pci-bridge.c b/arch/mips/pci/pci-bridge.c
> index 9df13ce313b5..af7073dba36b 100644
> --- a/arch/mips/pci/pci-bridge.c
> +++ b/arch/mips/pci/pci-bridge.c
> @@ -62,6 +62,21 @@ bridge_probe(nasid_t nasid, int widget_id, int masterwid)
>         unsigned long offset = NODE_OFFSET(nasid);
>         struct bridge_controller *bc;
>
> +#ifdef CONFIG_SGI_IP27

I don't know how MIPS multi-platform support works.  If you enable
CONFIG_SGI_IP27, does that mean the resulting kernel will *only* run
on IP27?  Or can you enable several platforms, e.g., SGI_IP22,
SGI_IP27, SGI_IP28, SGI_IP32, etc., and end up with a kernel that will
boot on any of those platforms?  From Kconfig, it looks like these
options are not mutually exclusive, so my guess is maybe the latter?

If so, I would think whatever we do should be based on a run-time test
for SGI_IP27 instead of a compile-time test.

> +       /*
> +        * Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
> +        * will now explicitly claim PCI resources instead of skipping the
> +        * sizing of the bridges and assigning resources.  This is okay for
> +        * the IP30's PCI code, which uses normal, ioremapped addresses to
> +        * do I/O.  IP27, however, is different and uses a hardware-specific
> +        * address range of 0x92xxxxxxxxxxxxxx for all I/O access.  As such,
> +        * the generic MIPS PCI code will not probe correctly and thus make
> +        * PCI on IP27 completely unusable.  Thus, we must restore the
> +        * original logic only for IP27 until a better solution can be found.
> +        */
> +       pci_set_flags(PCI_PROBE_ONLY);
> +#endif
> +
>         /* XXX: Temporary until the IP27 "mega update". */
>         bc = &bridges[num_bridges];
>         if (!num_bridges)
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index 68268bbb15b8..5590af4f367f 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -107,6 +107,20 @@ static void pcibios_scanbus(struct pci_controller *hose)
>                 need_domain_info = 1;
>         }
>
> +#ifdef CONFIG_SGI_IP27
> +       /*
> +        * Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
> +        * will now explicitly claim PCI resources instead of skipping the
> +        * sizing of the bridges and assigning resources.  This is okay for
> +        * the IP30's PCI code, which uses normal, ioremapped addresses to
> +        * do I/O.  IP27, however, is different and uses a hardware-specific
> +        * address range of 0x92xxxxxxxxxxxxxx for all I/O access.  As such,
> +        * the generic MIPS PCI code will not probe correctly and thus make
> +        * PCI on IP27 completely unusable.  Thus, we must restore the
> +        * original logic only for IP27 until a better solution can be found.
> +        */
> +       if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +#else
>         /*
>          * We insert PCI resources into the iomem_resource and
>          * ioport_resource trees in either pci_bus_claim_resources()
> @@ -115,6 +129,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>         if (pci_has_flag(PCI_PROBE_ONLY)) {
>                 pci_bus_claim_resources(bus);
>         } else {
> +#endif
>                 pci_bus_size_bridges(bus);
>                 pci_bus_assign_resources(bus);
>         }
> --
> 2.11.1
>
