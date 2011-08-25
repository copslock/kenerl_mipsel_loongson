Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2011 17:35:11 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.44.51]:6554 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493624Ab1HYPfG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2011 17:35:06 +0200
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
        by smtp-out.google.com with ESMTP id p7PFZ4tB013229
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 08:35:04 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1314286505; bh=zxt2OvbAOt5V6xPGA6PHbTiKC88=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SkY057VPfFrIipg6RXMb/l1siQ4TNwWMQYf6eOLoUtHJlbPQWigoP1zZKDdfccIJ+
         nj18bHIOWhlFdNQTj0uEw==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:x-system-of-record;
        b=vP86hFcIutjfhTxkJLXi21/bL8WoCLHjmn11KCq+NS29GuN1mrnnlY61GKP0xL6y9
        pmaQhLidx80KaJ8pOXXHg==
Received: from gwb11 (gwb11.prod.google.com [10.200.2.11])
        by wpaz33.hot.corp.google.com with ESMTP id p7PFXMAp028808
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 08:35:04 -0700
Received: by gwb11 with SMTP id 11so1900105gwb.20
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f958P2JMPIcdOJBqN6mtOuTHATzj6DPYppkat5Dk5uY=;
        b=OUtIfNPus6rHH4FOYiNg0IRxAb48HlQuxHjGj7P05TBJ9u5d4/k7UbNt54e1yoDwnD
         idvusPVR4Aji52gFJuxA==
Received: by 10.150.209.21 with SMTP id h21mr1084334ybg.156.1314286503360;
        Thu, 25 Aug 2011 08:35:03 -0700 (PDT)
Received: by 10.150.209.21 with SMTP id h21mr1084316ybg.156.1314286503126;
 Thu, 25 Aug 2011 08:35:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.48.2 with HTTP; Thu, 25 Aug 2011 08:34:43 -0700 (PDT)
In-Reply-To: <CAOfQC98Nkr7Ek3uQfiD3OdW=YC76XGjfQ4WSfoLpsm2kvqKnog@mail.gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
 <1314167063-15785-2-git-send-email-dengcheng.zhu@gmail.com>
 <CAErSpo4091J2pGvzZKPbKK68LWWkDyVApA7suZYn7miq=tXrQg@mail.gmail.com> <CAOfQC98Nkr7Ek3uQfiD3OdW=YC76XGjfQ4WSfoLpsm2kvqKnog@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 25 Aug 2011 09:34:43 -0600
Message-ID: <CAErSpo4zojYjYVd=6U72ToqiZOD-qL-saP8huwa6ShrNnaR3vA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] MIPS: PCI: Use pci_bus_remove_resources()/pci_bus_add_resource()
 to set up root resources
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-archive-position: 30988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19012

On Thu, Aug 25, 2011 at 12:41 AM, Deng-Cheng Zhu
<dengcheng.zhu@gmail.com> wrote:
> 2011/8/24 Bjorn Helgaas <bhelgaas@google.com>:
>> Wouldn't it be enough to have [PATCH 2/3], which adds the
>> pci_create_bus() argument with nobody using it yet, then [PATCH 3/3],
>> which makes mips supply the new argument, and add a hunk to [PATCH
>> 3/3] that completely removes the bus->resource fixups in
>> pcibios_fixup_bus() at the same time?
>>
>> Bjorn
>>
>
> Do you mean to merge this patch to [PATCH 3/3]? OK, that's good!

No, I just mean that I don't see why you need this patch at all.  If
you pass the list of bus resources to pci_create_bus(), there's no
need to fix anything up later.  Or am I missing something?

Bjorn
