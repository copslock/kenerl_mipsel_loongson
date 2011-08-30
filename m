Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 17:13:35 +0200 (CEST)
Received: from smtp-out.google.com ([74.125.121.67]:54171 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491805Ab1H3PN2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 17:13:28 +0200
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
        by smtp-out.google.com with ESMTP id p7UFDRmf016325
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2011 08:13:27 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1314717207; bh=lMQ3wERfJEFHMUlwfJ55Zk9rs+o=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type:Content-Transfer-Encoding;
        b=aoJlBt7REFKdo6Ff8AqTReVvHzWJAENvcvUeRvQNRWZN/3YUzwEwsbzNbXWwgDr26
         4PWklWFdnkOpGYgXMz7kQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:
        content-transfer-encoding:x-system-of-record;
        b=aPWVeVuAw1EY57/b2DCj3ZlKT95cMKixh2JyJbdHwi7RtgRMjRkVrmeQHl4NK1ZQC
        zIMiyIsde+NR1PZhuDD/w==
Received: from gyf3 (gyf3.prod.google.com [10.243.50.67])
        by hpaq14.eem.corp.google.com with ESMTP id p7UFDDvd021803
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2011 08:13:26 -0700
Received: by gyf3 with SMTP id 3so7578961gyf.17
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2011 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IlqRJ7YFD473cUuxpXD0ZeYRpP5tSiO7lop7/hpVu00=;
        b=SeNY/lbyvfNDZmrhvFrD1vZayGTbpqBcHx2KiGm4Rwc8wLWyO/YgybxBL1WpHgUkH9
         qlM49oRF7VIP8gRiJxZg==
Received: by 10.150.138.3 with SMTP id l3mr6074893ybd.384.1314717203353;
        Tue, 30 Aug 2011 08:13:23 -0700 (PDT)
Received: by 10.150.138.3 with SMTP id l3mr6074854ybd.384.1314717202102; Tue,
 30 Aug 2011 08:13:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.48.2 with HTTP; Tue, 30 Aug 2011 08:13:02 -0700 (PDT)
In-Reply-To: <CAErSpo5PgXs4tuihh_JZCePzD8FWWzwp=-VHxFGCCuRKRKOYFQ@mail.gmail.com>
References: <1314349633-13155-1-git-send-email-dczhu@mips.com> <CAErSpo5PgXs4tuihh_JZCePzD8FWWzwp=-VHxFGCCuRKRKOYFQ@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 30 Aug 2011 09:13:02 -0600
Message-ID: <CAErSpo506Mz3QSxxdpbxyCUuZvqMTNL+fT5R81ivoj7cDTFyJg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Pass resources to pci_create_bus() and fix MIPS
 PCI resources
To:     Deng-Cheng Zhu <dczhu@mips.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
X-archive-position: 31016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22560

On Fri, Aug 26, 2011 at 7:54 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Aug 26, 2011 at 3:07 AM, Deng-Cheng Zhu <dczhu@mips.com> wrote:
>> Change the pci_create_bus() interface to pass in available resources to get them
>> settled down early. This is to avoid possible resource conflicts while doing
>> pci_scan_slot() in pci_scan_child_bus(). Note that pcibios_fixup_bus() can get
>> rid of such conflicts, but it's done AFTER scanning slots.
>>
>> In addition, MIPS PCI resources are now fixed using this new interface.
>>
>> -- Changes --
>> v3 - v2:
>> o Do not do fixups for root buses in pcibios_fixup_bus().
>> o Skip bus creation when bus resources cannot be allocated.
>> o PCI domain/bus numbers added to the error info in controller_resources().
>>
>> v2 - v1:
>> o Merge [PATCH 1/3] to [PATCH 3/3], so now 2 patches in total.
>> o Add more info to patch description.
>> o Fix arch breaks in default resource setup discovered by Bjorn Helgaas.
>>
>> Deng-Cheng Zhu (2):
>>  PCI: Pass available resources into pci_create_bus()
>>  MIPS: PCI: Pass controller's resources to pci_create_bus() in
>>    pcibios_scanbus()
>>
>>  arch/microblaze/pci/pci-common.c |    3 +-
>>  arch/mips/pci/pci.c              |   61 +++++++++++++++++++++++++++++++++-----
>>  arch/powerpc/kernel/pci-common.c |    3 +-
>>  arch/sparc/kernel/pci.c          |    3 +-
>>  arch/x86/pci/acpi.c              |    2 +-
>>  drivers/pci/probe.c              |   15 +++++++--
>>  include/linux/pci.h              |    3 +-
>>  7 files changed, 73 insertions(+), 17 deletions(-)
>
> This is beautiful.  Thanks for doing this work!  I hope other
> architectures will follow your lead and get rid of their root bus
> resource fixups.
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>

One logistical issue here is that the first patch touches several
architectures at once, which puts Jesse in a bit of a pinch.  If he
applies it, there's always the possibility that an arch patch will
conflict with it, which makes merging harder.

It might be easier if, instead of changing the pci_create_bus()
interface, you added a new one (it could call pci_create_bus() then
replace the resources, so the implementation could still be mostly
shared.)  We already have a plethora of "create bus" methods
(pci_create_bus(), pci_scan_bus_parented(), pci_scan_bus()), but if
you added a pci_create_root_bus() or something similar, maybe we could
try to converge on it and obsolete the others.

Then the first patch would touch only the PCI core, and the second
would touch only MIPS, which would make merging more straightforward.

Bjorn
