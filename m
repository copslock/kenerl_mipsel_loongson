Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 01:23:53 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.44.51]:34713 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493795Ab1HYXXs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2011 01:23:48 +0200
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
        by smtp-out.google.com with ESMTP id p7PNNk1V015867
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 16:23:46 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1314314627; bh=t7BnSVrtkKYZ85eaeJnysp9lJxs=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type:Content-Transfer-Encoding;
        b=jbFRNsJbVpCE6MSFprXbC+awkSMUkhBIedKGCCGYMFC3j/MLn3Evy3BzObM9Rg5td
         0kVCmtLB6HIo7SSBexr8Q==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:
        content-transfer-encoding:x-system-of-record;
        b=g/MNkgNxB/nNi7VosRg8ycttONqb7/ZK8k1pT3Ix1s02TosTdxVuPWC1lqpPpc10b
        OZWNR02txr44Sh2cgLBOg==
Received: from gxk10 (gxk10.prod.google.com [10.202.11.10])
        by hpaq6.eem.corp.google.com with ESMTP id p7PNNM3i004652
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 16:23:45 -0700
Received: by gxk10 with SMTP id 10so2978406gxk.39
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aI7GADTY+4k5NNls2jlRXMrKTuROeH2ZOW4UReSm4uE=;
        b=TDDrWTSseF1gBHhlACkaZ+3XLaHPuC/FaV/kegsOrN/bVVx8CB3wzdQW3OCM810SjI
         yP4X/SOLCP4htNq4QzWA==
Received: by 10.151.153.6 with SMTP id f6mr1595695ybo.42.1314314624604;
        Thu, 25 Aug 2011 16:23:44 -0700 (PDT)
Received: by 10.151.153.6 with SMTP id f6mr1595684ybo.42.1314314624375; Thu,
 25 Aug 2011 16:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.48.2 with HTTP; Thu, 25 Aug 2011 16:23:24 -0700 (PDT)
In-Reply-To: <CAOfQC9-kS_nVg-+2OZRGHP1X-E7B12uG63QGfB64hPAGecgFLw@mail.gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
 <1314167063-15785-2-git-send-email-dengcheng.zhu@gmail.com>
 <CAErSpo4091J2pGvzZKPbKK68LWWkDyVApA7suZYn7miq=tXrQg@mail.gmail.com>
 <CAOfQC98Nkr7Ek3uQfiD3OdW=YC76XGjfQ4WSfoLpsm2kvqKnog@mail.gmail.com>
 <CAErSpo4zojYjYVd=6U72ToqiZOD-qL-saP8huwa6ShrNnaR3vA@mail.gmail.com> <CAOfQC9-kS_nVg-+2OZRGHP1X-E7B12uG63QGfB64hPAGecgFLw@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 25 Aug 2011 17:23:24 -0600
Message-ID: <CAErSpo4U6orULckFofbJON+x70m1G4w76rK4Y1Besh_K-m612g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] MIPS: PCI: Use pci_bus_remove_resources()/pci_bus_add_resource()
 to set up root resources
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
X-archive-position: 30992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19478

On Thu, Aug 25, 2011 at 5:14 PM, Deng-Cheng Zhu <dengcheng.zhu@gmail.com> wrote:
> 2011/8/25 Bjorn Helgaas <bhelgaas@google.com>:
>> No, I just mean that I don't see why you need this patch at all.  If
>> you pass the list of bus resources to pci_create_bus(), there's no
>> need to fix anything up later.  Or am I missing something?
>
> Well, doing the root resource fixups in here is a *paranoid* way. It's to
> deal with the 'unlikely' circumstance where controller_resources() returns
> the NULL pointer in pcibios_scanbus() due to memory allocation failure.
> Most of the time (always) it's nothing more than repeating the resource
> list setup. But maybe we can do something like this:
>
> if (unlikely(!dev && list_empty(&bus->resources))
>        pcibios_setup_root_resources(bus, hose);
>
>
> What do you think?

I don't think it's worth it.  Just check for failure of
controller_resources(), and if it fails, skip the pci_create_bus()
call.  You've already printed a message (you might add the PCI
domain/bus number).

Bjorn
