Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 15:54:30 +0200 (CEST)
Received: from smtp-out.google.com ([74.125.121.67]:47483 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492094Ab1HZNyX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2011 15:54:23 +0200
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
        by smtp-out.google.com with ESMTP id p7QDsLia027225
        for <linux-mips@linux-mips.org>; Fri, 26 Aug 2011 06:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1314366862; bh=IJUZAMijF09miexognkruib5sYM=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type:Content-Transfer-Encoding;
        b=gIp6A1CBAMDDI4vLhEQQptjkFX3bUfRYR/xqfzapoN4L9a0t4PM1vqQen85JmegB9
         oy7U8Y0JdgLdmICOJZjXw==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:
        content-transfer-encoding:x-system-of-record;
        b=vo1631kIGQ+XShmZQI5ra1lGhZjK+fvuB5XS7AgHqcRt/7END8r/8sq0iRRQdAIvi
        3AB/C30QyCOjg55m+9hZQ==
Received: from gyd8 (gyd8.prod.google.com [10.243.49.200])
        by hpaq12.eem.corp.google.com with ESMTP id p7QDs6Qw018277
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 26 Aug 2011 06:54:20 -0700
Received: by gyd8 with SMTP id 8so2954879gyd.38
        for <linux-mips@linux-mips.org>; Fri, 26 Aug 2011 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0jj/350DOUoTSu2VscFTgfALSNpVgwzm8MEBKxp6tNY=;
        b=U5u3frhd1UlgzOhmceugi6iRyQ/zNfWNQyTLb24ir90XNW1ARfmyEbE09rrccembcI
         WsULfsay8pq1AW2MP2Aw==
Received: by 10.151.25.6 with SMTP id c6mr2255871ybj.213.1314366860259;
        Fri, 26 Aug 2011 06:54:20 -0700 (PDT)
Received: by 10.151.25.6 with SMTP id c6mr2255857ybj.213.1314366860092; Fri,
 26 Aug 2011 06:54:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.48.2 with HTTP; Fri, 26 Aug 2011 06:53:59 -0700 (PDT)
In-Reply-To: <1314349633-13155-1-git-send-email-dczhu@mips.com>
References: <1314349633-13155-1-git-send-email-dczhu@mips.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 26 Aug 2011 07:54:00 -0600
Message-ID: <CAErSpo5PgXs4tuihh_JZCePzD8FWWzwp=-VHxFGCCuRKRKOYFQ@mail.gmail.com>
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
X-archive-position: 31000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19945

On Fri, Aug 26, 2011 at 3:07 AM, Deng-Cheng Zhu <dczhu@mips.com> wrote:
> Change the pci_create_bus() interface to pass in available resources to get them
> settled down early. This is to avoid possible resource conflicts while doing
> pci_scan_slot() in pci_scan_child_bus(). Note that pcibios_fixup_bus() can get
> rid of such conflicts, but it's done AFTER scanning slots.
>
> In addition, MIPS PCI resources are now fixed using this new interface.
>
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

This is beautiful.  Thanks for doing this work!  I hope other
architectures will follow your lead and get rid of their root bus
resource fixups.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
