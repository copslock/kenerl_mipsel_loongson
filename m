Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2013 02:59:25 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:7235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868696Ab3JDA7XNFoLG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Oct 2013 02:59:23 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 03 Oct 2013 17:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1029,1371106800"; 
   d="scan'208";a="411273988"
Received: from jonmason-lab.ch.intel.com (HELO jonmason-lab) ([143.182.51.14])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2013 17:59:13 -0700
Date:   Thu, 3 Oct 2013 17:59:13 -0700
From:   Jon Mason <jon.mason@intel.com>
To:     Ben Hutchings <bhutchings@solarflare.com>
Cc:     Alexander Gordeev <agordeev@redhat.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>,
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
Subject: Re: [PATCH RFC 01/77] PCI/MSI: Fix return value when
 populate_msi_sysfs() failed
Message-ID: <20131004005912.GB4787@jonmason-lab>
References: <cover.1380703262.git.agordeev@redhat.com>
 <3ff5236944aae69f2cd934b5b6da7c1c269df7c1.1380703262.git.agordeev@redhat.com>
 <20131003003905.GK6768@jonmason-lab>
 <1380836781.3419.17.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380836781.3419.17.camel@bwh-desktop.uk.level5networks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jon.mason@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.mason@intel.com
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

On Thu, Oct 03, 2013 at 10:46:21PM +0100, Ben Hutchings wrote:
> On Wed, 2013-10-02 at 17:39 -0700, Jon Mason wrote:
> > On Wed, Oct 02, 2013 at 12:48:17PM +0200, Alexander Gordeev wrote:
> > > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> > 
> > Since you are changing the behavior of the msix_capability_init
> > function on populate_msi_sysfs error, a comment describing why in this
> > commit would be nice.
> [...]
> 
> This function was already treating that error as fatal, and freeing the
> MSIs.  The change in behaviour is that it now returns the error code in
> this case, rather than 0.  This is obviously correct and properly
> described by the one-line summary.

If someone dumb, like me, is looking at this commit and trying to
figure out what is happening, having ANY commit message is good.  "Fix
the return value" doesn't tell me anything.  Documenting what issue(s)
would've been seen had the error case been encountered and what will
now been seen would be very nice.

> 
> Ben.
> 
> -- 
> Ben Hutchings, Staff Engineer, Solarflare
> Not speaking for my employer; that's the marketing department's job.
> They asked us to note that Solarflare product names are trademarked.
> 
