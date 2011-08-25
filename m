Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 01:14:28 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:62600 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493795Ab1HYXOW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2011 01:14:22 +0200
Received: by gwb1 with SMTP id 1so2594178gwb.36
        for <multiple recipients>; Thu, 25 Aug 2011 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SigOJAWfkwKH8gwrnspPgUCcmql1sJOk3uYQOVdQWqU=;
        b=XPKmzYQiYhsbCoyCNu3kf47Ew1CQ2FUtQg+OEK/RUsmRiyoZTBM1PIoum2iGw2/GlR
         qkxveKDBenRk9nXkjsyYU7vC1wEhiMmyKeNGIOsCe3YM8ncOgPJXxGBxkP++GYLUPx/A
         Q3XtrlDtRuvvvsMm72co2H0jwmoM1RHijeC6k=
MIME-Version: 1.0
Received: by 10.236.77.131 with SMTP id d3mr2304295yhe.63.1314314056366; Thu,
 25 Aug 2011 16:14:16 -0700 (PDT)
Received: by 10.236.207.73 with HTTP; Thu, 25 Aug 2011 16:14:16 -0700 (PDT)
In-Reply-To: <CAErSpo4zojYjYVd=6U72ToqiZOD-qL-saP8huwa6ShrNnaR3vA@mail.gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
        <1314167063-15785-2-git-send-email-dengcheng.zhu@gmail.com>
        <CAErSpo4091J2pGvzZKPbKK68LWWkDyVApA7suZYn7miq=tXrQg@mail.gmail.com>
        <CAOfQC98Nkr7Ek3uQfiD3OdW=YC76XGjfQ4WSfoLpsm2kvqKnog@mail.gmail.com>
        <CAErSpo4zojYjYVd=6U72ToqiZOD-qL-saP8huwa6ShrNnaR3vA@mail.gmail.com>
Date:   Fri, 26 Aug 2011 07:14:16 +0800
Message-ID: <CAOfQC9-kS_nVg-+2OZRGHP1X-E7B12uG63QGfB64hPAGecgFLw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] MIPS: PCI: Use pci_bus_remove_resources()/pci_bus_add_resource()
 to set up root resources
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19472

2011/8/25 Bjorn Helgaas <bhelgaas@google.com>:
> No, I just mean that I don't see why you need this patch at all.  If
> you pass the list of bus resources to pci_create_bus(), there's no
> need to fix anything up later.  Or am I missing something?

Well, doing the root resource fixups in here is a *paranoid* way. It's to
deal with the 'unlikely' circumstance where controller_resources() returns
the NULL pointer in pcibios_scanbus() due to memory allocation failure.
Most of the time (always) it's nothing more than repeating the resource
list setup. But maybe we can do something like this:

if (unlikely(!dev && list_empty(&bus->resources))
        pcibios_setup_root_resources(bus, hose);


What do you think?


Deng-Cheng
