Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 20:21:30 +0200 (CEST)
Received: from mail-qc0-f182.google.com ([209.85.216.182]:47029 "EHLO
        mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868730Ab3JGSV1UHl8M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 20:21:27 +0200
Received: by mail-qc0-f182.google.com with SMTP id n4so5029048qcx.41
        for <multiple recipients>; Mon, 07 Oct 2013 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NgxTy3KmEWxeJUfoL4S6qec2Rf5KqvYfFT74uVM18Zk=;
        b=d18BVZkErMoNR3lzpCfLmuHcPLGTmiAbcegtIuipjK5/dGOOCJhLwIMAsSHIS1uNMT
         NTb7vJ6ROoABNKmFOME5pkbp4mDpTYop+4GEReUgkr05qAcrp8sq34vJNB5ZqIsjt477
         vOBrgw0fi/lrlLSaXnxBA4+mMAxyZbu+FwOs6VyxEUrgp62J9LzUvABpo8Ktyrmpss4h
         VgV6pQIi6HiECleRZOsPvcr1+80OMjtWnTcKusrP7GNFbKTnOeMsQPrMkVBmMQReublj
         fJTvQgXZhTEnB9ZSxz6j14HV9qsjCfO1d3jtDlpU5cAJJtb8Xlf3UutEqFxAlXA+jr99
         vmyg==
X-Received: by 10.49.71.106 with SMTP id t10mr38521274qeu.26.1381170081400;
        Mon, 07 Oct 2013 11:21:21 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id x8sm64802126qam.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 11:21:20 -0700 (PDT)
Date:   Mon, 7 Oct 2013 14:21:17 -0400
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
Message-ID: <20131007182117.GC27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38239
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

Hello, Alexander.

On Wed, Oct 02, 2013 at 12:48:16PM +0200, Alexander Gordeev wrote:
> Alexander Gordeev (77):
>   PCI/MSI: Fix return value when populate_msi_sysfs() failed
>   PCI/MSI/PPC: Fix wrong RTAS error code reporting
>   PCI/MSI/s390: Fix single MSI only check
>   PCI/MSI/s390: Remove superfluous check of MSI type
>   PCI/MSI: Convert pci_msix_table_size() to a public interface
>   PCI/MSI: Factor out pci_get_msi_cap() interface
>   PCI/MSI: Re-design MSI/MSI-X interrupts enablement pattern
>   PCI/MSI: Get rid of pci_enable_msi_block_auto() interface
>   ahci: Update MSI/MSI-X interrupts enablement code
>   ahci: Check MRSM bit when multiple MSIs enabled
...

Whee.... that's a lot more than I expected.  I was just scanning
multiple msi users.  Maybe we can stage the work in more manageable
steps so that you don't have to go through massive conversion only to
do it all over again afterwards and likewise people don't get
bombarded on each iteration?  Maybe we can first update pci / msi code
proper, msi and then msix?

Thanks.

-- 
tejun
