Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2011 18:10:19 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.44.51]:24092 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493688Ab1HYQKM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2011 18:10:12 +0200
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
        by smtp-out.google.com with ESMTP id p7PGAAMg019868
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 09:10:10 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1314288611; bh=cNTGNnam95OslwnUfiwuCIQQoWY=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type:Content-Transfer-Encoding;
        b=AWZVg1SG0CXXxQCkTsFKn/rVSVBLLQqFRGIO0jok8EcONgUSqrhiQaqfwDanYi4ZV
         kjBSMDOxscO4HEUziaGPQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:
        content-transfer-encoding:x-system-of-record;
        b=yaotez9k1m6Xi/Jj2McGi3OpAKe/bRmKv/BCU1JNTkPdvcgZqFc1XUF28rTsUP6Mt
        oyngjAHy7Y84y6GHpYCzw==
Received: from gye5 (gye5.prod.google.com [10.243.50.5])
        by hpaq3.eem.corp.google.com with ESMTP id p7PG9RmM018302
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 09:10:09 -0700
Received: by gye5 with SMTP id 5so2490902gye.30
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MzUY4udQkTiz3jNMqMMahStHIpzyOhkQU4Gek6/Mb/w=;
        b=MkrDms4wYxRUh+WzxZRtRt78U3hIev1tQB+CcAnxf7ioTUVGf2wTD5a7B61myWvA1H
         ZF5hIze1F5YxU7abRoHg==
Received: by 10.150.7.17 with SMTP id 17mr1099151ybg.270.1314288608432;
        Thu, 25 Aug 2011 09:10:08 -0700 (PDT)
Received: by 10.150.7.17 with SMTP id 17mr1099132ybg.270.1314288608187; Thu,
 25 Aug 2011 09:10:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.48.2 with HTTP; Thu, 25 Aug 2011 09:09:48 -0700 (PDT)
In-Reply-To: <1314271117-32717-3-git-send-email-dczhu@mips.com>
References: <1314271117-32717-1-git-send-email-dczhu@mips.com> <1314271117-32717-3-git-send-email-dczhu@mips.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 25 Aug 2011 10:09:48 -0600
Message-ID: <CAErSpo5n-FJXwOd2h179tctw2LX0bZ7xcyxU5Mam+tmVoqgprw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MIPS: PCI: Pass controller's resources to
 pci_create_bus() in pcibios_scanbus()
To:     Deng-Cheng Zhu <dczhu@mips.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
X-archive-position: 30989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19056

On Thu, Aug 25, 2011 at 5:18 AM, Deng-Cheng Zhu <dczhu@mips.com> wrote:
> Use the new interface of pci_create_bus() so that system controller's
> resources are added to the root bus upon bus creation, thereby avoiding
> conflicts with PCI quirks before pcibios_fixup_bus() gets the chance to do
> right things in pci_scan_child_bus(). Also, since we are passing resources
> to pci_create_bus() and setting them up in the bus->resources list as
> opposed to the bus->resource[] array, we have to adopt the list style while
> doing bus fixups later on, or else, for example in this MIPS case, system
> controller's resources will stay in both bus->resources and
> bus->resource[].

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
> @@ -269,10 +313,9 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
>        struct list_head *ln;
>        struct pci_dev *dev = bus->self;
>
> -       if (!dev) {
> -               bus->resource[0] = hose->io_resource;
> -               bus->resource[1] = hose->mem_resource;
> -       } else if (pci_probe_only &&
> +       if (!dev)
> +               pcibios_setup_root_resources(bus, hose);

As I mentioned in my other response, I think you can just drop this
whole "if (!dev)" block since the root bus resources should already be
correct.  There's no need to move them from the bus->resource[] array
to the bus->resources list.

Someday, if all arches adopt your nice pci_create_bus() extension to
make root bus resources correct from the beginning, there should be no
arch references to the bus->resource[] array left, and then we can
remove it altogether.  At least, that's what I was hoping when I added
the list :)

In any case, all the *readers* of bus resources already use the
pci_bus_for_each_resource() interface, which knows how to look at both
the array and the list.

Bjorn
