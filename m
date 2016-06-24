Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2016 00:36:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59200 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012495AbcFXWgChus0Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Jun 2016 00:36:02 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u5OMZq9o018089;
        Sat, 25 Jun 2016 00:35:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u5OMZnqB018088;
        Sat, 25 Jun 2016 00:35:49 +0200
Date:   Sat, 25 Jun 2016 00:35:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andy Isaacson <adi@hexapodia.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        David Daney <david.daney@cavium.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: PCI_PROBE_ONLY clean-up
Message-ID: <20160624223548.GB10098@linux-mips.org>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160624155021.GD5930@linux-mips.org>
 <20160624184602.GG32461@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160624184602.GG32461@hexapodia.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54163
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

On Fri, Jun 24, 2016 at 11:46:02AM -0700, Andy Isaacson wrote:

> I don't remember the details, unfortunately, but my general recollection
> is similar -- CFE on bcm1480 was doing a fairly good job of configuring
> PCI, and I think we needed to preserve the configuration for Reasons
> rather than letting the kernel change things away from the CFE setup.
> 
> I unfortunately no longer have any 1480 hardware to test on, nor do I
> know who's left at BCM who might be able to validate this change.

I still have a small pile of Sibyte hardware of various description,
including BCM91480 and can test.

  Ralf
