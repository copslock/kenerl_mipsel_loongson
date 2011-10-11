Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2011 18:16:06 +0200 (CEST)
Received: from smtp-out.google.com ([74.125.121.67]:5758 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491178Ab1JKQP7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2011 18:15:59 +0200
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com [172.25.149.5])
        by smtp-out.google.com with ESMTP id p9BGFuXG010927
        for <linux-mips@linux-mips.org>; Tue, 11 Oct 2011 09:15:56 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1318349759; bh=i6bVgBGliiteWxs1f8CotbXdZYQ=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TxeEKiPVIQFOCNPlx3PDdqpgS42VpO2E4drPIj0TGbP+cipM97EvtJjYGn+ILepuF
         syl7onoGD5gR4zkfrp8mw==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type;
        b=HupOsJWMAs0WaWV3GY40Qw3t3te1RJVPR4BItRwoZpg4FeXqS8QP9oSO1guQ/RQkx
        Fs/Nd8D1STzfxrYvzxACg==
Received: from vws14 (vws14.prod.google.com [10.241.21.142])
        by hpaq5.eem.corp.google.com with ESMTP id p9BGFOpa026621
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 11 Oct 2011 09:15:55 -0700
Received: by vws14 with SMTP id 14so10837916vws.7
        for <linux-mips@linux-mips.org>; Tue, 11 Oct 2011 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=42EKK+bugRDdUFpQ1nnd8ipW/Eicjf4X8J0IChj8xj4=;
        b=ZZA+3QDpN3G5kEshjnvbsmX0L4LhZjyljGCQZyf2HgAdKEI/3lSoslanObR6Kfq1nW
         ePENsPwdfiy/z5Pv6WnQ==
Received: by 10.150.244.20 with SMTP id r20mr10776274ybh.50.1318349755412;
        Tue, 11 Oct 2011 09:15:55 -0700 (PDT)
Received: by 10.150.244.20 with SMTP id r20mr10776241ybh.50.1318349755238;
 Tue, 11 Oct 2011 09:15:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.198.8 with HTTP; Tue, 11 Oct 2011 09:15:34 -0700 (PDT)
In-Reply-To: <1318319295.29415.452.camel@pasglop>
References: <1314845309-3277-1-git-send-email-dczhu@mips.com>
 <CAErSpo5py82G1=6BOTG4RSAj6_SRzN4fng6sECU2sS+u9quixw@mail.gmail.com>
 <CAErSpo5HNKi7NSKBbyL3o39Ow+Xkncyccrj5PQNaoeMdLHJsFQ@mail.gmail.com>
 <BD04AF0D5BE72443A0B69C1C0486AD3ECE8D8973@exchdb03.mips.com> <1318319295.29415.452.camel@pasglop>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 11 Oct 2011 10:15:34 -0600
Message-ID: <CAErSpo5rU8aa=-joApUTYbsQrbrRz9x-7VA3V3H9gDg7k7nj+w@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/2] Pass resources to pci_create_bus() and fix
 MIPS PCI resources
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Zhu, DengCheng" <dczhu@mips.com>,
        "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "paulus@samba.org" <paulus@samba.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Barzilay, Eyal" <eyal@mips.com>,
        "Fortuna, Zenon" <zenon@mips.com>,
        "dengcheng.zhu@gmail.com" <dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7303

On Tue, Oct 11, 2011 at 1:48 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> I must admit I don't completely understand what this patch is about,
> other than it will most probably break the way we do resource management
> on powerpc :-)
>
> I don't understand the point about conflicts in scan_slot and I don't
> see what you win by "settling down early". Also keep in mind that the
> resources read from the device need to be remapped on some archs like
> powerpc which we do from a header quirk at the moment.

These patches only deal with root bus resources, i.e., the
non-architected PCI host bridge windows.  They don't have anything to
do with normal PCI BARs.

MIPS sets up root buses differently than powerpc, so it has a problem
that powerpc doesn't have.  Here's the original MIPS flow (before this
series):

              pci_scan_bus
                pci_scan_bus_parented
                  pci_create_bus        <-- A create root bus
                  pci_scan_child_bus
                    pci_scan_slot
                      pci_scan_single_device
                        pci_scan_device
                          pci_setup_device
                            pci_fixup_device (pci_fixup_early)  <-- B
                        pci_device_add
                          pci_fixup_device (pci_fixup_header)   <-- C
                    pcibios_fixup_bus   <-- D fill in root bus resources

At point A, we allocate a struct pci_bus for the root bus.
pci_create_bus() fills in defaults for the resources available on that
bus: ioport_resource and iomem_resource, which cover all possible
address space.  Later at point D, we replace those defaults with the
correct resources (hose->io_resource and hose->mem_resource in this
MIPS case).

The problem is that the root bus resources are wrong during the
interval between A and D.  Anything that looks at them may break.  In
the case Deng-Cheng found, the quirk_piix4_acpi() fixup at point C
claimed a region, which incorrectly became the child of
ioport_resource instead of host->io_resource.

Deng-Cheng's patches close this window by basically combining the
fixup at D with the root bus creation at A.

Powerpc doesn't have the same problem because it calls
pci_create_bus() directly so it can fix the root bus resources with
pcibios_setup_phb_resources() *before* it scans the bus.

Even though powerpc and many other architectures don't have the MIPS
problem, I think it's worth changing the code because the existing
pattern is poor.  In almost all cases, we know what the host bridge
apertures are before we create the root bus.  It's error-prone to have
pci_create_bus() fill in default resources, then rely on the
architecture to fix that up later.  I think it's better to supply the
resources up front.

Bjorn
