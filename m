Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2011 08:41:45 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:33698 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491078Ab1HYGli (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2011 08:41:38 +0200
Received: by gyh20 with SMTP id 20so1787435gyh.36
        for <multiple recipients>; Wed, 24 Aug 2011 23:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j+9w+VLK5ikkYanJB2igLk1vHeImayEApLyCqcnLHC4=;
        b=HKO8TTp4n2q7KvDZExgjWgp4eb4p1rThI0niEPg7HCUFVu2G3y/2Z1eFL13/VZMUPH
         G7bqYJyDCHIL2qSBNgfYXlJB7+JSdQeSftRnwTNlwsp9cYeIW+a/lkwoP2RiV6BcxPYC
         Z7pAQpF97i2IaD60H9Dj8pRTc1JoQ24mE86VQ=
MIME-Version: 1.0
Received: by 10.236.78.200 with SMTP id g48mr37795280yhe.12.1314254492254;
 Wed, 24 Aug 2011 23:41:32 -0700 (PDT)
Received: by 10.236.207.73 with HTTP; Wed, 24 Aug 2011 23:41:32 -0700 (PDT)
In-Reply-To: <CAErSpo4091J2pGvzZKPbKK68LWWkDyVApA7suZYn7miq=tXrQg@mail.gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
        <1314167063-15785-2-git-send-email-dengcheng.zhu@gmail.com>
        <CAErSpo4091J2pGvzZKPbKK68LWWkDyVApA7suZYn7miq=tXrQg@mail.gmail.com>
Date:   Thu, 25 Aug 2011 14:41:32 +0800
Message-ID: <CAOfQC98Nkr7Ek3uQfiD3OdW=YC76XGjfQ4WSfoLpsm2kvqKnog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] MIPS: PCI: Use pci_bus_remove_resources()/pci_bus_add_resource()
 to set up root resources
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18489

2011/8/24 Bjorn Helgaas <bhelgaas@google.com>:
> Wouldn't it be enough to have [PATCH 2/3], which adds the
> pci_create_bus() argument with nobody using it yet, then [PATCH 3/3],
> which makes mips supply the new argument, and add a hunk to [PATCH
> 3/3] that completely removes the bus->resource fixups in
> pcibios_fixup_bus() at the same time?
>
> Bjorn
>

Do you mean to merge this patch to [PATCH 3/3]? OK, that's good!


Deng-Cheng
