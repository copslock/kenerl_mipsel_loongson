Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2016 20:46:09 +0200 (CEST)
Received: from straum.hexapodia.org ([192.235.78.53]:57426 "EHLO
        straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27024967AbcFXSqGzGp23 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jun 2016 20:46:06 +0200
Received: by straum.hexapodia.org (Postfix, from userid 22448)
        id 0B11342CC; Fri, 24 Jun 2016 11:46:02 -0700 (PDT)
Date:   Fri, 24 Jun 2016 11:46:02 -0700
From:   Andy Isaacson <adi@hexapodia.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        David Daney <david.daney@cavium.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: PCI_PROBE_ONLY clean-up
Message-ID: <20160624184602.GG32461@hexapodia.org>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160624155021.GD5930@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160624155021.GD5930@linux-mips.org>
X-Old-GPG-Fingerprint: 1914 0645 FD53 C18E EEEF C402 4A69 B1F3 68D2 A63F
X-GPG-Fingerprint: A5FC 6141 F76D B6B1 C81F  0FB7 AFA0 A45F ED3D 116D
X-GPG-Key-URL: http://web.hexapodia.org/~adi/gpg.txt
X-Domestic-Surveillance: money launder bomb tax evasion
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
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

On Fri, Jun 24, 2016 at 05:50:21PM +0200, Ralf Baechle wrote:
> >   bcm1480
> >     Andrew Isaacson <adi@broadcom.com>
> >     dc41f94f7709 ("Support for the BCM1480 on-chip PCI-X bridge.")
> > 
> >   ip27
> >     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> >     96173a6c4ebc ("[MIPS] IP27: misc fixes")
> 
> Afair  I did originally implement the IP27 use of PCI_PROBE_ONLY.  The
> problem is that it was not possible for the kernel to assign resources
> properly on an IP27.  Also that would invalidate firmware configuration
> information, so we had to live with whatever the firmware (mis)configured
> for us.  Afair - it's a darn long time ...  I think the reasoning for
> the BCM1480 was similar but Andy will hopefully recall the details.

I don't remember the details, unfortunately, but my general recollection
is similar -- CFE on bcm1480 was doing a fairly good job of configuring
PCI, and I think we needed to preserve the configuration for Reasons
rather than letting the kernel change things away from the CFE setup.

I unfortunately no longer have any 1480 hardware to test on, nor do I
know who's left at BCM who might be able to validate this change.

-andy
