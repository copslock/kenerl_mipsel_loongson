Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2016 17:50:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49070 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27044060AbcFXPuhVnKAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Jun 2016 17:50:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u5OFoSm7010185;
        Fri, 24 Jun 2016 17:50:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u5OFoL3q010184;
        Fri, 24 Jun 2016 17:50:21 +0200
Date:   Fri, 24 Jun 2016 17:50:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        David Daney <david.daney@cavium.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Isaacson <adi@hexapodia.org>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: PCI_PROBE_ONLY clean-up
Message-ID: <20160624155021.GD5930@linux-mips.org>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Jun 23, 2016 at 05:16:47PM -0500, Bjorn Helgaas wrote:

> Lorenzo is changing the PCI_PROBE_ONLY case so the BARs and windows remain
> immutable, but we insert the resources into the iomem_resource tree.
> 
> The ideal thing would be to remove the use of PCI_PROBE_ONLY completely,
> and allow Linux to program BARs as necessary.  If the firmware *has*
> programmed the BARs, we don't change them unless we find something broken,
> so in most cases PCI_PROBE_ONLY is unnecessary.
> 
> There are several MIPS platforms (bcm1480, ip27, sb1250, virtio_guest, xlp,
> xlr) that set PCI_PROBE_ONLY for reasons I don't know.  These were added
> by:
> 
>   bcm1480
>     Andrew Isaacson <adi@broadcom.com>
>     dc41f94f7709 ("Support for the BCM1480 on-chip PCI-X bridge.")
> 
>   ip27
>     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>     96173a6c4ebc ("[MIPS] IP27: misc fixes")

Afair  I did originally implement the IP27 use of PCI_PROBE_ONLY.  The
problem is that it was not possible for the kernel to assign resources
properly on an IP27.  Also that would invalidate firmware configuration
information, so we had to live with whatever the firmware (mis)configured
for us.  Afair - it's a darn long time ...  I think the reasoning for
the BCM1480 was similar but Andy will hopefully recall the details.

  Ralf
