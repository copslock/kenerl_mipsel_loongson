Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 17:46:23 +0200 (CEST)
Received: from mail-qe0-f52.google.com ([209.85.128.52]:36537 "EHLO
        mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868739Ab3JIPqQWbfF5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Oct 2013 17:46:16 +0200
Received: by mail-qe0-f52.google.com with SMTP id w7so754887qeb.39
        for <multiple recipients>; Wed, 09 Oct 2013 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4VyhOrgIPoHGT/7G7udfP2Gifv4pcNA/GhX+A/dOLfc=;
        b=seMlYycMgTxoH6WK4YBv4g6qDuRZupaUKY4a6s+3QXIYh2RVFTd0/39aIZDm+ECg7w
         oNVDrOtqGwxm+pk7MP2e8gAcRvHlc4NhkogjJWdzov65s9LzAB/5BQJI5UqUZVpn6VEL
         6WLekYqzfUllf68D2ATsurqpVTJVof8hTNJFC8IDPMA7DzPcT3bk+TtXz9PKTXqL9pj8
         C7tteiHQpD4zrT7Qml9iatSP9H/eMsXGrhlXbCpj9/8G2Hp+wmU+D3acxvN90b9CTm23
         eo7e0sKIo8g2uvZCFylGIoPzqBLtZtkbsBNIClef/aMbXD+XZfqfSAcc0LlWDMiaAtuG
         rFhw==
X-Received: by 10.224.5.137 with SMTP id 9mr12038277qav.65.1381333570314;
        Wed, 09 Oct 2013 08:46:10 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id a9sm54951034qed.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 08:46:09 -0700 (PDT)
Date:   Wed, 9 Oct 2013 11:46:06 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Ben Hutchings <bhutchings@solarflare.com>
Cc:     Alexander Gordeev <agordeev@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20131009154606.GC22495@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <1381178881.1536.28.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381178881.1536.28.camel@bwh-desktop.uk.level5networks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38293
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

On Mon, Oct 07, 2013 at 09:48:01PM +0100, Ben Hutchings wrote:
> > There is one major flaw in min-max approach - the generic MSI layer
> > will have to take decisions on exact number of MSIs to request, not
> > device drivers.
> [...
> 
> No, the min-max functions should be implemented using the same loop that
> drivers are expected to use now.

Wheee... earlier in the thread I thought you guys were referring to
yourselves in the third person and was getting a bit worried. :)

-- 
tejun
