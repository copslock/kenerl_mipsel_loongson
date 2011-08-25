Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2011 08:56:28 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:32772 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491082Ab1HYG4V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2011 08:56:21 +0200
Received: by yxk8 with SMTP id 8so1779634yxk.36
        for <multiple recipients>; Wed, 24 Aug 2011 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zGQc2KuIiC4ZBnR5hhOkw84GQVo6BIvi1B8nV1K6TkA=;
        b=LM5GamP9+lLopoOhoQ2z7X5y4cAFq5Jmu4TvvjpyGFzNaLrEjVC7zHwp2oqEuux0WN
         Ly037LBfvQQB/WO0yMy53cpRCIvwDuI+BnTfepSuIQ/dIcrBhfKBEryAUVq8ews/OfoD
         5pRbEaYMoK3vwB3i3LJrJMoEanBYN4frN7888=
MIME-Version: 1.0
Received: by 10.236.178.68 with SMTP id e44mr37360116yhm.131.1314255375725;
 Wed, 24 Aug 2011 23:56:15 -0700 (PDT)
Received: by 10.236.207.73 with HTTP; Wed, 24 Aug 2011 23:56:15 -0700 (PDT)
In-Reply-To: <CAErSpo56V1eHaLTz72gLHcdONsNSUM01upKr4K+DtoU58ea5Ag@mail.gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
        <1314167063-15785-3-git-send-email-dengcheng.zhu@gmail.com>
        <CAErSpo56V1eHaLTz72gLHcdONsNSUM01upKr4K+DtoU58ea5Ag@mail.gmail.com>
Date:   Thu, 25 Aug 2011 14:56:15 +0800
Message-ID: <CAOfQC9_S9q9fE6VyDaLseUFZD_GxZcEOYw8YsvRWkr9-2S=RRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] PCI: Pass available resources into pci_create_bus()
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18495

2011/8/24 Bjorn Helgaas <bhelgaas@google.com>:
> I like this approach a lot.  Thanks for working it up.  It's a nice
> small change with very little impact to other architectures, and you
> have a nice clear changelog.  You might mention something about the
> fact that by default, the bus starts out with all of ioport_resource
> and iomem_resource -- that will mean something to people who know how
> host bridges work.

Thanks! And I'll add this info to the patch description.

> Using pci_bus_add_resource() here *seems* like it should be the right
> thing, but I don't think it will work correctly.
>
> The problem is that struct pci_bus has both a table of resources
> (bus->resource[]) *and* a list (bus->resources).
> pci_bus_add_resource() always puts the new resource on the list, but
> various arch code still references the table directly, e.g., sparc has
> "pbus->resource[0] = &pbm->io_space" in pcibios_fixup_bus().
>
> As written, I think this patch will break sparc because the host
> bridge will end up with both pbm->io_space (in the table) and
> ioport_resource (in the list).

Good catch! I overlooked this point.

> I think something like this would work, though:
>
>    if (bus_res)
>        list_add_tail(&b->resources, &bus_res->list);
>    else {
>        b->resource[0] = &ioport_resource;
>        b->resource[1] = &iomem_resource;
>    }

Yes, it should work.


Thanks again for your time,

Deng-Cheng
