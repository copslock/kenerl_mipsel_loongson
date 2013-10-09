Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 17:58:09 +0200 (CEST)
Received: from mail-ye0-f169.google.com ([209.85.213.169]:53392 "EHLO
        mail-ye0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868641Ab3JIP6EGZhKf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Oct 2013 17:58:04 +0200
Received: by mail-ye0-f169.google.com with SMTP id r10so220877yen.28
        for <multiple recipients>; Wed, 09 Oct 2013 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JAtdCSU4zrG0+SBJpoLUhui92fWq9jdNjtTCHMrPgwE=;
        b=aIE4SEeZQPpxiukoLmkSPhvz7bqEJirB0AD5+biWDhfp0qPzKSknsUyN8WXS6RduSG
         /dAvWS7v5qEUOrP/YceLgCmCcvzkXTTa9/hY5X+IitDTvSkCuCXi3eRGbY7B3/5qTiJQ
         l+/iSbRgK/KCllRhFwoKcLYvy8BUdvNx1u7el+LwIIgt08m90tU22dv0HntqCxRi5jG9
         wzhQawhg+ksnTvC8evWVc3TVZ8B/lELV3GJWIvx6SHLN/h+u2XcR7csJGaeKnmD/ssrN
         FjiwMWoARbKgPF8t1wzW5oC0eikjCHW8dKo7bERQOGEitGGElroRVntMiQSJLfJ8Geab
         zN7Q==
X-Received: by 10.236.147.210 with SMTP id t58mr7796435yhj.1.1381334277994;
        Wed, 09 Oct 2013 08:57:57 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id v45sm61687548yha.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 08:57:56 -0700 (PDT)
Date:   Wed, 9 Oct 2013 11:57:52 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20131009155752.GE22495@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <20131007182117.GC27396@htj.dyndns.org>
 <20131008090716.GA10561@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131008090716.GA10561@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38296
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

On Tue, Oct 08, 2013 at 11:07:16AM +0200, Alexander Gordeev wrote:
> Multipe MSIs is just a handful of drivers, really. MSI-X impact still

Yes, so it's pretty nice to try out things there before going full-on.

> will be huge. But if we opt a different name for the new pci_enable_msix()
> then we could first update pci/msi, then drivers (in few stages possibly)
> and finally remove the old implementation.

Yes, that probably should be the steps to follow eventually.  My point
was that you don't have to submit patches for all 7x conversions for
an RFC round.  Scanning them and seeing what would be necessary
definitely is a good idea but just giving summary of the full
conversion with several examples should be good enough before settling
on the way forward, which should be easier for all involved.

Thanks a lot for your effort!

-- 
tejun
