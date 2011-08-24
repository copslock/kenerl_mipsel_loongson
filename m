Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 16:28:54 +0200 (CEST)
Received: from mail-pz0-f69.google.com ([209.85.210.69]:48479 "EHLO
        mail-pz0-f69.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493644Ab1HXO2p convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2011 16:28:45 +0200
Received: by pzd13 with SMTP id 13so25223pzd.8
        for <linux-mips@linux-mips.org>; Wed, 24 Aug 2011 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RBRQ1d4vjJpphG0/CqEq+Q4igR9KQ8sNZ/AC267urik=;
        b=KnRAScPPsLrZh0ZeN7UnMXRpxQoHk6Z0EyKRuiBou3QAZjIwz/RO6iCsI5NYyJ4el5
         gxZT6r4ATe1RA1dUXX+Q==
Received: by 10.142.170.15 with SMTP id s15mr2888112wfe.168.1314196118326;
        Wed, 24 Aug 2011 07:28:38 -0700 (PDT)
Received: by 10.142.170.15 with SMTP id s15mr2888096wfe.168.1314196118136;
 Wed, 24 Aug 2011 07:28:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.142.216.14 with HTTP; Wed, 24 Aug 2011 07:28:18 -0700 (PDT)
In-Reply-To: <1314167063-15785-3-git-send-email-dengcheng.zhu@gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com> <1314167063-15785-3-git-send-email-dengcheng.zhu@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 24 Aug 2011 08:28:18 -0600
Message-ID: <CAErSpo56V1eHaLTz72gLHcdONsNSUM01upKr4K+DtoU58ea5Ag@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] PCI: Pass available resources into pci_create_bus()
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17918

On Wed, Aug 24, 2011 at 12:24 AM, Deng-Cheng Zhu
<dengcheng.zhu@gmail.com> wrote:
> Currently, after pci_create_bus(), resources available on the bus could be
> handled by pci_scan_child_bus(). The problem is that, in
> pci_scan_child_bus(), before calling arch-dependent pcibios_fixup_bus(),
> PCI quirks will probably conflict (while doing pci_claim_resource()) with
> resources like system controller's I/O resource that have not yet been
> added to the bus. So, add those resources right before returning the newly
> created bus in pci_create_bus().

I like this approach a lot.  Thanks for working it up.  It's a nice
small change with very little impact to other architectures, and you
have a nice clear changelog.  You might mention something about the
fact that by default, the bus starts out with all of ioport_resource
and iomem_resource -- that will mean something to people who know how
host bridges work.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8473727..7735fe7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1516,7 +1516,8 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
>  }
>
>  struct pci_bus * pci_create_bus(struct device *parent,
> -               int bus, struct pci_ops *ops, void *sysdata)
> +               int bus, struct pci_ops *ops, void *sysdata,
> +               struct pci_bus_resource *bus_res)
>  {
>        int error;
>        struct pci_bus *b, *b2;
> @@ -1570,8 +1571,14 @@ struct pci_bus * pci_create_bus(struct device *parent,
>        pci_create_legacy_files(b);
>
>        b->number = b->secondary = bus;
> -       b->resource[0] = &ioport_resource;
> -       b->resource[1] = &iomem_resource;
> +
> +       /* Add initial resources to the bus */
> +       if (bus_res != NULL) {
> +               list_add_tail(&b->resources, &bus_res->list);
> +       } else {
> +               pci_bus_add_resource(b, &ioport_resource, 0);
> +               pci_bus_add_resource(b, &iomem_resource, 0);
> +       }

Using pci_bus_add_resource() here *seems* like it should be the right
thing, but I don't think it will work correctly.

The problem is that struct pci_bus has both a table of resources
(bus->resource[]) *and* a list (bus->resources).
pci_bus_add_resource() always puts the new resource on the list, but
various arch code still references the table directly, e.g., sparc has
"pbus->resource[0] = &pbm->io_space" in pcibios_fixup_bus().

As written, I think this patch will break sparc because the host
bridge will end up with both pbm->io_space (in the table) and
ioport_resource (in the list).

I think something like this would work, though:

    if (bus_res)
        list_add_tail(&b->resources, &bus_res->list);
    else {
        b->resource[0] = &ioport_resource;
        b->resource[1] = &iomem_resource;
    }

Bjorn
