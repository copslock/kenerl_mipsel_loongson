Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 23:13:39 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:34436 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27009415AbaKMWNiOSDex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 23:13:38 +0100
Received: (qmail 16456 invoked by uid 2102); 13 Nov 2014 17:13:36 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Nov 2014 17:13:36 -0500
Date:   Thu, 13 Nov 2014 17:13:36 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
cc:     David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/3] USB: host: Misc patches to remove hard-coded octeon
 platform information
In-Reply-To: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
Message-ID: <Pine.LNX.4.44L0.1411131712201.4266-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+54715d4c@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
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

On Thu, 13 Nov 2014, Andreas Herrmann wrote:

> Hi Alan,
> 
> With following patches I want to base octeon ehci/ohci device
> configuration on device tree information.
> 
> I picked up patches that were submitted in May. See
> http://marc.info/?l=linux-usb&m=140135823325811&w=2
> and http://marc.info/?l=linux-mips&m=140139694721623&w=2
> 
> Patch #1 is your "untested preliminary pass" to remove
>  [oe]hci-octeon drivers.
> Patch #2 is the removal of hard-coded platform information (but now
>  rebased on your patch)
> Patch #3 adapts dma_mask for ehci (as used in ehci-octeon)
> 
> Overall diffstat is
> 
>  arch/mips/cavium-octeon/octeon-platform.c |  380 +++++++++++++++++++++++------
>  arch/mips/configs/cavium_octeon_defconfig |    3 +
>  drivers/usb/host/Kconfig                  |   18 +-
>  drivers/usb/host/Makefile                 |    1 -
>  drivers/usb/host/ehci-hcd.c               |    5 -
>  drivers/usb/host/ehci-octeon.c            |  188 --------------
>  drivers/usb/host/ehci-platform.c          |    4 +-
>  drivers/usb/host/octeon2-common.c         |  200 ---------------
>  drivers/usb/host/ohci-hcd.c               |    5 -
>  drivers/usb/host/ohci-octeon.c            |  202 ---------------
>  drivers/usb/host/ohci-platform.c          |    1 +
>  include/linux/usb/ehci_pdriver.h          |    1 +
>  12 files changed, 330 insertions(+), 678 deletions(-)
> 
> Patches are based on v3.18-rc4-65-g2c54396
> 
> Comments welcome.

At a very quick first glance, it looks great.  Have you tested it 
thoroughly?

Alan Stern
