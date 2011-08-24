Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 16:35:53 +0200 (CEST)
Received: from mail-pz0-f69.google.com ([209.85.210.69]:49100 "EHLO
        mail-pz0-f69.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493646Ab1HXOfq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2011 16:35:46 +0200
Received: by pzd13 with SMTP id 13so25560pzd.8
        for <linux-mips@linux-mips.org>; Wed, 24 Aug 2011 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IfuV3V4M8pVYzo3x9gkpg1BvlVgxXwQAa0TvlJ6J1r0=;
        b=LCXOU4VtiD4wmLpLf58BASOmypf7vfav1a47/U7bEgDNxlZWYNCFlcW8+TVckNP55E
         XUs0DGyskH2V2N2+QbGA==
Received: by 10.142.127.21 with SMTP id z21mr2440939wfc.396.1314196539663;
        Wed, 24 Aug 2011 07:35:39 -0700 (PDT)
Received: by 10.142.127.21 with SMTP id z21mr2440921wfc.396.1314196539441;
 Wed, 24 Aug 2011 07:35:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.142.216.14 with HTTP; Wed, 24 Aug 2011 07:35:19 -0700 (PDT)
In-Reply-To: <1314167063-15785-2-git-send-email-dengcheng.zhu@gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com> <1314167063-15785-2-git-send-email-dengcheng.zhu@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 24 Aug 2011 08:35:19 -0600
Message-ID: <CAErSpo4091J2pGvzZKPbKK68LWWkDyVApA7suZYn7miq=tXrQg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] MIPS: PCI: Use pci_bus_remove_resources()/pci_bus_add_resource()
 to set up root resources
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17928

On Wed, Aug 24, 2011 at 12:24 AM, Deng-Cheng Zhu
<dengcheng.zhu@gmail.com> wrote:
> Use this new style (instead of filling in the pci_bus->resource[] array
> directly) to hide some ugly implementation details.
>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  arch/mips/pci/pci.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 33bba7b..7473214 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -261,6 +261,14 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
>        }
>  }
>
> +static void __devinit
> +pcibios_setup_root_resources(struct pci_bus *bus, struct pci_controller *ctrl)
> +{
> +       pci_bus_remove_resources(bus);
> +       pci_bus_add_resource(bus, ctrl->io_resource, 0);
> +       pci_bus_add_resource(bus, ctrl->mem_resource, 0);
> +}
> +
>  void __devinit pcibios_fixup_bus(struct pci_bus *bus)
>  {
>        /* Propagate hose info into the subordinate devices.  */
> @@ -270,8 +278,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
>        struct pci_dev *dev = bus->self;
>
>        if (!dev) {
> -               bus->resource[0] = hose->io_resource;
> -               bus->resource[1] = hose->mem_resource;
> +               pcibios_setup_root_resources(bus, hose);
>        } else if (pci_probe_only &&
>                   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
>                pci_read_bridge_bases(bus);

I don't understand this patch.

Wouldn't it be enough to have [PATCH 2/3], which adds the
pci_create_bus() argument with nobody using it yet, then [PATCH 3/3],
which makes mips supply the new argument, and add a hunk to [PATCH
3/3] that completely removes the bus->resource fixups in
pcibios_fixup_bus() at the same time?

Bjorn
