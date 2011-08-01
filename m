Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 12:14:01 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:62714 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491137Ab1HAKN4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Aug 2011 12:13:56 +0200
Received: by yxj20 with SMTP id 20so3501949yxj.36
        for <multiple recipients>; Mon, 01 Aug 2011 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5rfmg5VHVCeYO3pSpVmJpCyiIlomfIme0OILFD5KBBM=;
        b=MEwwKfBUd3NZDl2xUrTCjzEL4s+o2pNryeoaag1M7TD9yXwIXDpfiFUbw+hlrPhg01
         GDumaBz4z6pjxdBqL92s0hoEB7dbU356OeeaXT6xJm/RlueW2DXqv+bJdOG9fv8fLBLI
         0vcQEty0NR2GOFKxp14UB+//HUlCI7wIlj6Yk=
MIME-Version: 1.0
Received: by 10.236.77.227 with SMTP id d63mr3143628yhe.299.1312193630174;
 Mon, 01 Aug 2011 03:13:50 -0700 (PDT)
Received: by 10.236.105.130 with HTTP; Mon, 1 Aug 2011 03:13:49 -0700 (PDT)
In-Reply-To: <CAErSpo6SLCLxh6vOwLaj5AYXNLrUEtQgfMU_hFCKJVH1dC5neQ@mail.gmail.com>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
        <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
        <20110728115330.GA29899@linux-mips.org>
        <CAOfQC9-Z31SSv8agzxZ_hvPOOLY8p0F6yc1=o-QPbDwbNxavTg@mail.gmail.com>
        <CAErSpo6SLCLxh6vOwLaj5AYXNLrUEtQgfMU_hFCKJVH1dC5neQ@mail.gmail.com>
Date:   Mon, 1 Aug 2011 18:13:49 +0800
Message-ID: <CAOfQC9-vT0F-atsuQ1DRg1cFMzRq3rjfa3hvsemLqnRCJedFkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict
 resources as appropriate
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 274

It was found that PCI quirks claim resources (by calling pci_claim_resource())
*BEFORE* pcibios_fixup_bus() is called. In pcibios_fixup_bus(),
pci_bus->resource[0] for the root bus DOES point to msc_io_resource. If PCI
quirks do the resource claim after the arch-defined pcibios_fixup_bus() being
called, then the problem with Malta goes away.

So, it looks like 2 solutions out there:

1) To manage the call sequence. This seems not a desired one as it affects other
arches.

2) To raise the start point of the system controller's io_resource in
mips_pcibios_init() in arch/mips/mti-malta/malta-pci.c. This will place PCI
quirks' resources at the same level of the system controller's resources.

Ralf and Bjorn, which one sounds good to you?


Deng-Cheng


2011/7/30 Bjorn Helgaas <bhelgaas@google.com>:
> On Fri, Jul 29, 2011 at 12:32 AM, Deng-Cheng Zhu
> <dengcheng.zhu@gmail.com> wrote:
>> I noticed that at 79896cf42f Linus changed the function from insert_resource()
>> to request_resource() (and later evolved into request_resource_conflict()) and
>> he explained the reason. So, in the NIC's case, the problem is that in
>> pci_claim_resource() the function pci_find_parent_resource() returns the root
>> (0x0-0xffffff) rather than the MSC PCI I/O (0x1000-0xffffff).
>
> This seems like the real problem: PCI has the wrong idea of the
> resources available on bus 00.  The pci_bus->resource[0] for bus 00
> points to ioport_resource (the default put there by pci_create_bus()),
> when it should point to to msc_io_resource instead.
>
> Some architectures fill in the pci_bus->resource[] array directly for
> host bridges (for examples, try 'grep -r "resource\[0\] = " arch/').
> On x86 and ia64, we use pci_bus_remove_resources() and
> pci_bus_add_resource(), and I'd prefer that style for new code because
> it hides some ugly implementation details.
>
> I'm a little puzzled that we don't see this problem on more
> architectures.  The grep above only found a few arches that update the
> root bus resources.  I would expect most of the ones it didn't find to
> be broken the same way Malta is.
>
> Bjorn
>
