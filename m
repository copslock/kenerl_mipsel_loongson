Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 20:19:50 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51303 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6838727Ab3JBSTMXVUvV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 20:19:12 +0200
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CAA16212B5;
        Wed,  2 Oct 2013 14:19:09 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 02 Oct 2013 14:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=Q/9gTAyZrhJ0FUGtF+FIS6tDtuE=; b=gWvlMpR64qjJblW3KxBPmDhirB+e
        nCRh78VYEDL/ttrAEOJbBnOGTwUONV6Yy1OW+mrnG1k1zwufjX/nreQuxwCyjSrO
        4k3j4b7UXbc/Z4f7yDKnZ8Ki8P24Y1kHo2GumKRUun/JHvVYuwV3qtI26lGiDVDC
        XAzKbVob9bnbFsU=
X-Sasl-enc: /wuFenq8EQs03Qovh0b9tIxlhjDvLDVV46Em0TdOcLY/ 1380737911
Received: from localhost (unknown [70.102.97.201])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFD1B6802B2;
        Wed,  2 Oct 2013 14:17:58 -0400 (EDT)
Date:   Wed, 2 Oct 2013 11:17:49 -0700
From:   Greg KH <greg@kroah.com>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        stable@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux390@de.ibm.com, linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 04/77] PCI/MSI/s390: Remove superfluous check of MSI
 type
Message-ID: <20131002181749.GA6942@kroah.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Wed, Oct 02, 2013 at 12:48:20PM +0200, Alexander Gordeev wrote:
> arch_setup_msi_irqs() hook can only be called from the generic
> MSI code which ensures correct MSI type parameter.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  arch/s390/pci/pci.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

I have no idea why you sent the stable@ alias so many patches, all in
the incorrect form for them to be ever accepted in the stable kernel
releases.  Please read Documentation/stable_kernel_rules.txt for how to
do this properly.

greg k-h
