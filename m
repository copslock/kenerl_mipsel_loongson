Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 20:09:19 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.44.51]:59443 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491819Ab1G2SJM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jul 2011 20:09:12 +0200
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
        by smtp-out.google.com with ESMTP id p6TI99bK024271
        for <linux-mips@linux-mips.org>; Fri, 29 Jul 2011 11:09:09 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1311962950; bh=vFfPpDqK2gSULim9tfV1cPUOY9c=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=oQOFU0zW6OIpu9vSI3ltxV8/n1YwOCLE7+H16In6KqYc7C57MnWPez6s/ex3gbNFE
         zapuRve/RXrW9KU4NmYvw==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:x-system-of-record;
        b=MdjhUOxfol/n+uMUZ18zn4qzfx27K8vhgQxFmN7YdNdz78/sVrwVEvVOINJIicwtZ
        bR1zo0XboKJ0EhX+kxoaA==
Received: from yxk8 (yxk8.prod.google.com [10.190.3.136])
        by wpaz13.hot.corp.google.com with ESMTP id p6TI98nk001279
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 29 Jul 2011 11:09:08 -0700
Received: by yxk8 with SMTP id 8so4786226yxk.1
        for <linux-mips@linux-mips.org>; Fri, 29 Jul 2011 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7n8NNIcOuuUeX0p592tLwmLyR3+732GoefS8LEpqgnk=;
        b=D1FO1/6uJRmJXuWLUK0neYYlIQ3NLsxj3saoFYrMcTJo7R8/woHZLltLKxBZliag4L
         b26rchVms6OpVQaouknA==
Received: by 10.150.138.3 with SMTP id l3mr906ybd.384.1311962948423;
        Fri, 29 Jul 2011 11:09:08 -0700 (PDT)
Received: by 10.150.138.3 with SMTP id l3mr140465ybd.384.1311961009784; Fri,
 29 Jul 2011 10:36:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.58.10 with HTTP; Fri, 29 Jul 2011 10:35:51 -0700 (PDT)
In-Reply-To: <CAOfQC9-Z31SSv8agzxZ_hvPOOLY8p0F6yc1=o-QPbDwbNxavTg@mail.gmail.com>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
 <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
 <20110728115330.GA29899@linux-mips.org> <CAOfQC9-Z31SSv8agzxZ_hvPOOLY8p0F6yc1=o-QPbDwbNxavTg@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 29 Jul 2011 11:35:51 -0600
Message-ID: <CAErSpo6SLCLxh6vOwLaj5AYXNLrUEtQgfMU_hFCKJVH1dC5neQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict
 resources as appropriate
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, jbarnes@virtuousgeek.org,
        torvalds@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-archive-position: 30766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21961

On Fri, Jul 29, 2011 at 12:32 AM, Deng-Cheng Zhu
<dengcheng.zhu@gmail.com> wrote:
> I noticed that at 79896cf42f Linus changed the function from insert_resource()
> to request_resource() (and later evolved into request_resource_conflict()) and
> he explained the reason. So, in the NIC's case, the problem is that in
> pci_claim_resource() the function pci_find_parent_resource() returns the root
> (0x0-0xffffff) rather than the MSC PCI I/O (0x1000-0xffffff).

This seems like the real problem: PCI has the wrong idea of the
resources available on bus 00.  The pci_bus->resource[0] for bus 00
points to ioport_resource (the default put there by pci_create_bus()),
when it should point to to msc_io_resource instead.

Some architectures fill in the pci_bus->resource[] array directly for
host bridges (for examples, try 'grep -r "resource\[0\] = " arch/').
On x86 and ia64, we use pci_bus_remove_resources() and
pci_bus_add_resource(), and I'd prefer that style for new code because
it hides some ugly implementation details.

I'm a little puzzled that we don't see this problem on more
architectures.  The grep above only found a few arches that update the
root bus resources.  I would expect most of the ones it didn't find to
be broken the same way Malta is.

Bjorn
