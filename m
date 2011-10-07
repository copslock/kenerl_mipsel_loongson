Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2011 23:51:24 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.44.51]:56948 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491196Ab1JGVvP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2011 23:51:15 +0200
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
        by smtp-out.google.com with ESMTP id p97LpBxX001360
        for <linux-mips@linux-mips.org>; Fri, 7 Oct 2011 14:51:11 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1318024273; bh=vu9HG0r02pKb8vJyBzdPooTpl68=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type:Content-Transfer-Encoding;
        b=K1wRG5gJ+6Vc5OD5m9DmInv1dPsxkdwVpgwD7MNzEPGJUjX669IGdkCb0z7YdYVeL
         bciBoXhIiO3PTS8j3jZ7Q==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:
        content-transfer-encoding:x-system-of-record;
        b=cswvRyEOvXoIo94yjTvhJ8IoA+2f1F70CDZVdialb+/iklPlzi3pkMlG0KR4YvdWf
        ue6Eevz6NtcYSliFTaeHA==
Received: from yxk36 (yxk36.prod.google.com [10.190.3.164])
        by wpaz1.hot.corp.google.com with ESMTP id p97Lp9bM013587
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 7 Oct 2011 14:51:10 -0700
Received: by yxk36 with SMTP id 36so5622736yxk.2
        for <linux-mips@linux-mips.org>; Fri, 07 Oct 2011 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wdheew5yIpxf//CcHXFdHacKe3CbzL0OhLJQAozjEr8=;
        b=poFWkvtEAYT67mvqQUizIlGo9tKlrLvBUn43AxHdlQj8lAOqWnsoH9sm9y6inTSMhH
         ZjGYF/14ywWPJCW4f0lA==
Received: by 10.150.239.8 with SMTP id m8mr2040208ybh.327.1318024269469;
        Fri, 07 Oct 2011 14:51:09 -0700 (PDT)
Received: by 10.150.239.8 with SMTP id m8mr2040178ybh.327.1318024269235; Fri,
 07 Oct 2011 14:51:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.198.8 with HTTP; Fri, 7 Oct 2011 14:50:49 -0700 (PDT)
In-Reply-To: <1314845309-3277-1-git-send-email-dczhu@mips.com>
References: <1314845309-3277-1-git-send-email-dczhu@mips.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 7 Oct 2011 15:50:49 -0600
Message-ID: <CAErSpo5py82G1=6BOTG4RSAj6_SRzN4fng6sECU2sS+u9quixw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/2] Pass resources to pci_create_bus() and fix
 MIPS PCI resources
To:     Deng-Cheng Zhu <dczhu@mips.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org, monstr@monstr.eu,
        benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        eyal@mips.com, zenon@mips.com, dengcheng.zhu@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
X-archive-position: 31213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5078

On Wed, Aug 31, 2011 at 8:48 PM, Deng-Cheng Zhu <dczhu@mips.com> wrote:
> (Resending the patch set to include more arch maintainers.)
>
> Change the pci_create_bus() interface to pass in available resources to get them
> settled down early. This is to avoid possible resource conflicts while doing
> pci_scan_slot() in pci_scan_child_bus(). Note that pcibios_fixup_bus() can get
> rid of such conflicts, but it's done AFTER scanning slots.
>
> In addition, MIPS PCI resources are now fixed using this new interface.

Jesse, I assume these are headed for the 3.2 merge window, right?

Do you have a git tree anywhere where we could check without having to
bother you?

Bjorn

> -- Changes --
> v3 - v2:
> o Do not do fixups for root buses in pcibios_fixup_bus().
> o Skip bus creation when bus resources cannot be allocated.
> o PCI domain/bus numbers added to the error info in controller_resources().
>
> v2 - v1:
> o Merge [PATCH 1/3] to [PATCH 3/3], so now 2 patches in total.
> o Add more info to patch description.
> o Fix arch breaks in default resource setup discovered by Bjorn Helgaas.
>
> Deng-Cheng Zhu (2):
>  PCI: Pass available resources into pci_create_bus()
>  MIPS: PCI: Pass controller's resources to pci_create_bus() in
>    pcibios_scanbus()
>
>  arch/microblaze/pci/pci-common.c |    3 +-
>  arch/mips/pci/pci.c              |   61 +++++++++++++++++++++++++++++++++-----
>  arch/powerpc/kernel/pci-common.c |    3 +-
>  arch/sparc/kernel/pci.c          |    3 +-
>  arch/x86/pci/acpi.c              |    2 +-
>  drivers/pci/probe.c              |   15 +++++++--
>  include/linux/pci.h              |    3 +-
>  7 files changed, 73 insertions(+), 17 deletions(-)
>
>
