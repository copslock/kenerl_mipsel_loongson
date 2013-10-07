Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 20:01:25 +0200 (CEST)
Received: from mail-qa0-f42.google.com ([209.85.216.42]:47250 "EHLO
        mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868728Ab3JGSBWDcxE2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 20:01:22 +0200
Received: by mail-qa0-f42.google.com with SMTP id cm18so3255688qab.15
        for <multiple recipients>; Mon, 07 Oct 2013 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jqrqoo3A2MdZhVVq5wcPEqEfKRb/WiuaBRyVLRD+Ugs=;
        b=jhxzeMVoOC3f4xgPT24ULkVk3JzcpEn/S52wm3CIDZg/9E9sVkp3H/Tqg+Eqb2thbg
         h1O1NoAxix00Z/yi88K7tCy2Pam44+Q6bVLntOlzDA0f2oU+n48yvueCYvDynP4v9npO
         tY6CJDkQFACwqVlXGHiBvAV6a3qzowoAW9lns6Wd7eBj3T2TCIo/he6jqY7krBB/2GGK
         wsw+wV/51ok4+AASmUfiJDPWYTiFVxD4A1ktwLAqWLwPBVBvy4QUQ6IzigwmQFfEocKq
         JrlEct62ve7Q7Sp55Rh/N8YGIkf//d7tePAVHoJoXlHMtxWhNbCEbwM6MlSXQTRpHYNQ
         f7UA==
X-Received: by 10.224.57.138 with SMTP id c10mr38550739qah.57.1381168875678;
        Mon, 07 Oct 2013 11:01:15 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id ge5sm41981183qeb.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 11:01:14 -0700 (PDT)
Date:   Mon, 7 Oct 2013 14:01:11 -0400
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
Message-ID: <20131007180111.GC2481@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38236
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

Hey, guys.

On Sun, Oct 06, 2013 at 09:10:30AM +0200, Alexander Gordeev wrote:
> On Sun, Oct 06, 2013 at 05:19:46PM +1100, Benjamin Herrenschmidt wrote:
> > On Sun, 2013-10-06 at 08:02 +0200, Alexander Gordeev wrote:
> > > In fact, in the current design to address the quota race decently the
> > > drivers would have to protect the *loop* to prevent the quota change
> > > between a pci_enable_msix() returned a positive number and the the next
> > > call to pci_enable_msix() with that number. Is it doable?
> > 
> > I am not advocating for the current design, simply saying that your
> > proposal doesn't address this issue while Ben's does.

Hmmm... yean, the race condition could be an issue as multiple msi
allocation might fail even if the driver can and explicitly handle
multiple allocation if the quota gets reduced inbetween.

> There is one major flaw in min-max approach - the generic MSI layer
> will have to take decisions on exact number of MSIs to request, not
> device drivers.

The min-max approach would actually be pretty nice for the users which
actually care about this.

> This will never work for all devices, because there might be specific
> requirements which are not covered by the min-max. That is what Ben
> described "...say, any even number within a certain range". Ben suggests
> to leave the existing loop scheme to cover such devices, which I think is
> not right.

if it could work.

> What about introducing pci_lock_msi() and pci_unlock_msi() and let device
> drivers care about their ranges and specifics in race-safe manner?
> I do not call to introduce it right now (since it appears pSeries has not
> been hitting the race for years) just as a possible alternative to Ben's
> proposal.

I don't think the same race condition would happen with the loop.  The
problem case is where multiple msi(x) allocation fails completely
because the global limit went down before inquiry and allocation.  In
the loop based interface, it'd retry with the lower number.

As long as the number of drivers which need this sort of adaptive
allocation isn't too high and the common cases can be made simple, I
don't think the "complex" part of interface is all that important.
Maybe we can have reserve / cancel type interface or just keep the
loop with more explicit function names (ie. try_enable or something
like that).

Thanks.

-- 
tejun
