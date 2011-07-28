Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2011 19:01:23 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.44.51]:8351 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491173Ab1G1RBS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jul 2011 19:01:18 +0200
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
        by smtp-out.google.com with ESMTP id p6SH1GAN017160
        for <linux-mips@linux-mips.org>; Thu, 28 Jul 2011 10:01:16 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1311872476; bh=VI5+wwD51qhtq8gMkNg7cYFjo44=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aTTaUNuOaPpEDuw1QfCQRSnVqwPyu3XL71La5S4YcNBeOsPoWqW1WOHQbVWpR8JBo
         jFcCwBdTydKXbdaAQMYag==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:x-system-of-record;
        b=rt2NDrUqN/NySWe4L9yPVe+IV6Bg8DGAffRMZqSQLF7fvZnYDpIMKzohp0hyBBxTY
        1a4Kgoje2IjgBbi9GQclw==
Received: from gwj20 (gwj20.prod.google.com [10.200.10.20])
        by wpaz33.hot.corp.google.com with ESMTP id p6SGvh8b032538
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 28 Jul 2011 10:01:15 -0700
Received: by gwj20 with SMTP id 20so2505248gwj.26
        for <linux-mips@linux-mips.org>; Thu, 28 Jul 2011 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XVNRZb0erbzIalvoLFoIDETo2VvFq8TBS0AwG55h0cs=;
        b=wNRT96LnahjRQJlOnOWG6gkwWfNZjLZ29lhDIL3dwc5/dxi1Pg0Eg9SZ8XW93Sejbo
         CdFfoMpA4DKcrV3ZpCiw==
Received: by 10.150.47.8 with SMTP id u8mr6ybu.441.1311872474781;
        Thu, 28 Jul 2011 10:01:14 -0700 (PDT)
Received: by 10.150.47.8 with SMTP id u8mr275119ybu.441.1311868763134; Thu, 28
 Jul 2011 08:59:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.156.20 with HTTP; Thu, 28 Jul 2011 08:59:03 -0700 (PDT)
In-Reply-To: <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com> <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 28 Jul 2011 09:59:03 -0600
Message-ID: <CAErSpo5hZGAzc17GApEfuzduvzh6haVLBKRvizcRxGLnh8ebuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict
 resources as appropriate
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        Ralf Baechle <ralph@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-archive-position: 30756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20921

On Thu, Jul 28, 2011 at 5:28 AM, Deng-Cheng Zhu <dengcheng.zhu@gmail.com> wrote:
> In resolving a network driver issue with the MIPS Malta platform, the root
> cause was traced into pci_claim_resource():
>
> MIPS System Controller's PCI I/O resources stay in 0x1000-0xffffff. When
> PCI quirks start claiming resources using request_resource_conflict(),
> collisions happen and -EBUSY is returned, thereby rendering the onboard AMD
> PCnet32 NIC unaware of quirks' region and preventing the NIC from functioning.
> For PCI quirks, PIIX4 ACPI is expected to claim 0x1000-0x103f, and PIIX4 SMB to
> claim 0x1100-0x110f, both of which fall into the MSC I/O range. Certainly, we
> can increase the start point of this range in arch/mips/mti-malta/malta-pci.c to
> avoid the collisions. But a fix in here looks more justified, though it seems to
> have a wider impact. Using insert_xxx as opposed to request_xxx will register
> PCI quirks' resources as children of MSC I/O and return OK, instead of seeing
> collisions which are actually resolvable.

What's the collision?  Can we see the dmesg log (which should have
that information) and maybe the /proc/ioports contents?  Did something
change the order in which we claim resources, so things that used to
work now cause conflicts?

I think insert_resource() (where the newly-inserted resource can
become the parent of something that was previously inserted) is sort
of a hack, and the fact that we need it is telling us that we're doing
things in the wrong order.  It's nicer when we can discover and claim
resources in a top-down hierarchical way.  But I recognize that may
not always be possible, or at least not convenient.

Bjorn
