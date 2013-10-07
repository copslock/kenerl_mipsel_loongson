Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 20:10:56 +0200 (CEST)
Received: from mail-ye0-f170.google.com ([209.85.213.170]:49749 "EHLO
        mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817906Ab3JGSKxrrI25 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 20:10:53 +0200
Received: by mail-ye0-f170.google.com with SMTP id r4so1675742yen.15
        for <multiple recipients>; Mon, 07 Oct 2013 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TYk0awj7MOHTKRF6ajcknicTR7ZR0VOjUdGfnZ71HnA=;
        b=X2WpF7f7Q6vnKQTsuh1lQTV+2dm9JvhExTisDrhexxsR2pCvsWf+gxyqHPgMlZ/pHL
         g1YGLRcO0rXyqSWSMdR+Lfyk3/xdghcBydbRGazhsI/BYE059pj1CChWmah+O/cjXe2I
         sEuyT3wNCIw5/s7QFHMe4VfzsXCzgPpGrPi5dsB5QDu/hztFCgt+efOlXfs2PsyLmWMq
         FfWxBrXSssqMu5A3q7YXi6+51gYjR2orEA/tT2jPI0sWQOavSDWcbSArMRiQrpMk1Rq0
         9lZz1kUjxSwzPdTQHsrHRNY2ne5goqo7IZkD9Wwf/kJLoqaAKKj6W9ON0q3Q0mpTsEPt
         n0nA==
X-Received: by 10.236.148.138 with SMTP id v10mr26447799yhj.27.1381169447484;
        Mon, 07 Oct 2013 11:10:47 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id e10sm45383470yhj.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 11:10:46 -0700 (PDT)
Date:   Mon, 7 Oct 2013 14:10:43 -0400
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
Subject: Re: [PATCH RFC 05/77] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
Message-ID: <20131007181043.GA27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38237
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

On Wed, Oct 02, 2013 at 12:48:21PM +0200, Alexander Gordeev wrote:
> Make pci_msix_table_size() to return a error code if the device
> does not support MSI-X. This update is needed to facilitate a
> forthcoming re-design MSI/MSI-X interrupts enabling pattern.
> 
> Device drivers will use this interface to obtain maximum number
> of MSI-X interrupts the device supports and use that value in
> the following call to pci_enable_msix() interface.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Hmmm... I probably missed something but why is this necessary?  To
discern between -EINVAL and -ENOSPC?  If so, does that really matter?

Thanks.

-- 
tejun
