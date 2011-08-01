Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 17:21:41 +0200 (CEST)
Received: from smtp-out.google.com ([74.125.121.67]:19625 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491146Ab1HAPVe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Aug 2011 17:21:34 +0200
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
        by smtp-out.google.com with ESMTP id p71FLW18009257
        for <linux-mips@linux-mips.org>; Mon, 1 Aug 2011 08:21:33 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1312212093; bh=AKiBxZMGLYI5I574yKyO9UnB5h4=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XhSbU6tfHHHJpx8m2hygsCV/POtn0a4biE11W4vS4FbtGgaME2wBLaWhxVNLYCs68
         dbgm6+LsfNfwzyQ04n+uQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:x-system-of-record;
        b=YDqegdRi81+tDsX0IKb11Kj/YDCxZIZy0+MtrJ9oZsiHN8vJ+U1/+ME9WVaYFc5XS
        5a+ZgfhqINlk6MaeQQh7A==
Received: from ywa12 (ywa12.prod.google.com [10.192.1.12])
        by kpbe19.cbf.corp.google.com with ESMTP id p71FLVut016011
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 1 Aug 2011 08:21:31 -0700
Received: by ywa12 with SMTP id 12so1013557ywa.23
        for <linux-mips@linux-mips.org>; Mon, 01 Aug 2011 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NchbzGmEuo1h8EIACrlAGfIRcUwrshqZqlsQN5HQQuA=;
        b=IqA2AV4gSXVCGBEOlTEjoJbAHlE/1+AVDKLc19NX0S9I3V6dr96/wIECKAcba/K19P
         sqUY8Ko/+o293msrhQ8g==
Received: by 10.150.60.19 with SMTP id i19mr871206yba.270.1312212091106; Mon,
 01 Aug 2011 08:21:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.58.10 with HTTP; Mon, 1 Aug 2011 08:21:11 -0700 (PDT)
In-Reply-To: <CAOfQC9-vT0F-atsuQ1DRg1cFMzRq3rjfa3hvsemLqnRCJedFkA@mail.gmail.com>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
 <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
 <20110728115330.GA29899@linux-mips.org> <CAOfQC9-Z31SSv8agzxZ_hvPOOLY8p0F6yc1=o-QPbDwbNxavTg@mail.gmail.com>
 <CAErSpo6SLCLxh6vOwLaj5AYXNLrUEtQgfMU_hFCKJVH1dC5neQ@mail.gmail.com> <CAOfQC9-vT0F-atsuQ1DRg1cFMzRq3rjfa3hvsemLqnRCJedFkA@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 1 Aug 2011 09:21:11 -0600
Message-ID: <CAErSpo5A0At+U4gZ6s6ER2vzBzRiV9iJVkZtGH+gnAWeT+N=Ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict
 resources as appropriate
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, jbarnes@virtuousgeek.org,
        torvalds@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-archive-position: 30787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 529

On Mon, Aug 1, 2011 at 4:13 AM, Deng-Cheng Zhu <dengcheng.zhu@gmail.com> wrote:
> It was found that PCI quirks claim resources (by calling pci_claim_resource())
> *BEFORE* pcibios_fixup_bus() is called. In pcibios_fixup_bus(),
> pci_bus->resource[0] for the root bus DOES point to msc_io_resource. If PCI
> quirks do the resource claim after the arch-defined pcibios_fixup_bus() being
> called, then the problem with Malta goes away.

Oh, I see.  pcibios_fixup_bus() copies the hose resources to the root
bus pci_bus structure.  I think that's bogus because we have the
interval between mips_pcibios_init() and pcibios_fixup_bus() where the
root bus resources are incorrect.

I think it would be better to set up the resources correctly right
away, as we do on x86.  In fact, I'm dubious about pci_create_bus()
filling in ioport_resource and iomem_resource as defaults -- that's
never what we really want there, and we have to rely on the arch
coming back later to fix it up.

I'd like to see some sort of restructuring there so we could pass in a
list of resources at the time we create the bus.

Bjorn
