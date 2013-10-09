Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 17:41:35 +0200 (CEST)
Received: from mail-qa0-f45.google.com ([209.85.216.45]:62868 "EHLO
        mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839455Ab3JIPl1um5uc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Oct 2013 17:41:27 +0200
Received: by mail-qa0-f45.google.com with SMTP id k4so5055893qaq.18
        for <multiple recipients>; Wed, 09 Oct 2013 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OIzuWne1btQIFKe1AaOQsGqgMP43Qniev5+6HLk4I5U=;
        b=hUvKAdMsQohvjzOwOL4p15MfcazmrTl+J0lRqYmpfYZPKfZmDt+xd8rx6NoSVImiRh
         03zdtQPc+/1BmgJlawZiLKAY0WpNJ3XjaLw/jRqgJY9dDipeESEkUvwvtdSzLIhAs3gJ
         QLM2ZsAqVQJxO9POKosAP66f8cwkXdkcgDQEJHln5GafBvkzRno2JCswmEb7B253KJEG
         cKTrAqrERKZACrlFl7J9oEsiIsnQhie8VgS4LCsSxsnLMkUTCD1cjmJfSXdzsRB90MgA
         qEy0I6NBj6p1ZcUPBndIUfpq/GAotw6uMVKFex/Av1EMTJ6ANOknz1MlH6NPW0RlpdtB
         X1Xw==
X-Received: by 10.49.25.102 with SMTP id b6mr3376286qeg.91.1381333281116;
        Wed, 09 Oct 2013 08:41:21 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id a2sm76779565qek.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 08:41:20 -0700 (PDT)
Date:   Wed, 9 Oct 2013 11:41:17 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131009154117.GA22495@htj.dyndns.org>
References: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
 <20131008122215.GA14389@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131008122215.GA14389@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello,

On Tue, Oct 08, 2013 at 02:22:16PM +0200, Alexander Gordeev wrote:
> If we talk about pSeries quota, then the current pSeries pci_enable_msix()
> implementation is racy internally and could fail if the quota went down
> *while* pci_enable_msix() is executing. In this case the loop will have to
> exit rather than retry with a lower number (what number?).

Ah, okay, so that one is already broken.

> In this regard the new scheme does not bring anything new and relies on
> the fact this race does not hit and therefore does not worry.
> 
> If we talk about quota as it has to be, then yes - the loop scheme seems
> more preferable.
> 
> Overall, looks like we just need to fix the pSeries implementation,
> if the guys want it, he-he :)

If we can't figure out a better interface for the retry case, I think
what can really help is having a simple interface for the simpler
cases.

> > The problem case is where multiple msi(x) allocation fails completely
> > because the global limit went down before inquiry and allocation.  In
> > the loop based interface, it'd retry with the lower number.
> 
> I am probably missing something here. If the global limit went down before
> inquiry then the inquiry will get what is available and try to allocate with
> than number.

Oh, I should have written between inquiry and allocation.  Sorry.

Thanks.

-- 
tejun
