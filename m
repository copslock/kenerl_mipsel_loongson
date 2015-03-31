Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 13:21:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56303 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010266AbbCaLVjMDaBz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 13:21:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VBLd2W031975;
        Tue, 31 Mar 2015 13:21:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VBLdwY031974;
        Tue, 31 Mar 2015 13:21:39 +0200
Date:   Tue, 31 Mar 2015 13:21:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: PCI: Add a hook for IORESOURCE_BUS in
 pci_controller/bridge_controller
Message-ID: <20150331112138.GC28951@linux-mips.org>
References: <54BCCC18.8020706@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BCCC18.8020706@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46645
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

On Mon, Jan 19, 2015 at 04:19:20AM -0500, Joshua Kinard wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> 
> On SGI Origin 2k/Onyx2 and SGI Octane systems, there can exist multiple PCI
> buses attached to the Xtalk bus.  The current code will stop counting PCI buses
> after it finds the first one.  If one installs the optional PCI cardcage
> ("shoebox") into these systems, because of the order of the Xtalk widgets, the
> current PCI code will find the cardcage first, and fail to detect the BaseIO
> PCI devices, which are on a higher Xtalk widget ID.
> 
> This patch adds the hooks needed for resolving this issue in the IP27 PCI code
> (in a later patch).
> 
> Verified on both an SGI Onyx2 and an SGI Octane.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/include/asm/pci.h        |    2 ++
>  arch/mips/include/asm/pci/bridge.h |    1 +
>  arch/mips/pci/pci.c                |    5 ++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> Ralf,
> 
>   I have the needed IP27 changes, but I tied them up with some cleanups to the
> Xtalk code to make it more centralized so I could remove duplicate code from
> the Octane's patches.  I've still gotta fiddle with that code some more and
> remove the debug bits, but this change should be safe to go in by itself, as
> it's a prerequisite.  I'll probably send the IP27 bits in along with the IOC3
> stuff, because IP27 seems to be very flakey (at least my Onyx2 was) with the
> in-tree IOC3 bits.  Most common was requiring several reboots to properly
> detect the MAC address.  Under the metadriver, it detects things fine.

There's a long-standing defect in the IOC3 code resulting in bad timing
for the 1-Wire bus driver.  The reason is that some bitfield is incorrectly
sized resulting in overflow.

As for the patch itself - everybody had their fair chance at yelling, nobody
did so I queued it up for 4.1.

  Ralf
