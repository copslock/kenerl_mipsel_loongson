Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 17:43:36 +0200 (CEST)
Received: from mail-qc0-f179.google.com ([209.85.216.179]:63404 "EHLO
        mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839455Ab3JIPnd2lESv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Oct 2013 17:43:33 +0200
Received: by mail-qc0-f179.google.com with SMTP id l4so713000qcv.38
        for <multiple recipients>; Wed, 09 Oct 2013 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ifdHpINxJRj1PJtzyLGWv1m6fdPwF6KPC7ogH4dJXxQ=;
        b=vrOoErSt7va8gWziu9rYAO602J0sZAxxM2tz0+Fd0qGR/TKy25fy4r8VsyPBEofpX0
         PuRuyOhVu0zIhWXfynpe5V2ekg+8Is9j6YnDKBPkuWxUbwlkEqzde6Xpez3ATl7MRDSK
         3XnpRfKvhMVLcIC8aSxC67xBNEJAotVN04qwIvAMCvVDLDCGsuwOgxJnXG5YqWqO000j
         rN06IVfR4QWAKVMnpUB9LUuR4maOQy20G6myvXzh9pBCkskaigucG5djYsaYAlyGBePe
         2QR8Jvo4xDyn+1Bp5kHwv2JDGhvUrHWJYoHUDoaxTffsZZOLPzFG3FyDvhzKFepplJVQ
         E1hw==
X-Received: by 10.229.191.7 with SMTP id dk7mr10438539qcb.4.1381333407536;
        Wed, 09 Oct 2013 08:43:27 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id i4sm87446671qan.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 08:43:26 -0700 (PDT)
Date:   Wed, 9 Oct 2013 11:43:23 -0400
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
Message-ID: <20131009154323.GB22495@htj.dyndns.org>
References: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
 <20131009125715.GC32733@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131009125715.GC32733@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38292
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

On Wed, Oct 09, 2013 at 02:57:16PM +0200, Alexander Gordeev wrote:
> On Mon, Oct 07, 2013 at 02:01:11PM -0400, Tejun Heo wrote:
> > Hmmm... yean, the race condition could be an issue as multiple msi
> > allocation might fail even if the driver can and explicitly handle
> > multiple allocation if the quota gets reduced inbetween.
> 
> BTW, should we care about the quota getting increased inbetween?
> That would entail.. kind of pci_get_msi_limit() :), but IMHO it is
> not worth it.

I think we shouldn't.  If the resource was low during a point in time
during allocation, it's fine to base the result on that - the resource
was actually low and which answer we return is just a question of
timing and both are correct.  The only reason the existing race
condition is problematic is because it may fail even if the resource
never falls below the failure point.

Thanks.

-- 
tejun
