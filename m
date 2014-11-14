Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 10:31:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59434 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013676AbaKNJbzmxvRD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 10:31:55 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAE9Vqgw009588;
        Fri, 14 Nov 2014 10:31:52 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAE9Vpo6009587;
        Fri, 14 Nov 2014 10:31:51 +0100
Date:   Fri, 14 Nov 2014 10:31:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/3] USB: host: Remove ehci-octeon and ohci-octeon drivers
Message-ID: <20141114093150.GC24165@linux-mips.org>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44153
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

On Thu, Nov 13, 2014 at 10:36:28PM +0100, Andreas Herrmann wrote:

> From: Alan Stern <stern@rowland.harvard.edu>
> 
> From: Alan Stern <stern@rowland.harvard.edu>

Is there an echo?

Is there an echo?

> Remove special-purpose octeon drivers and instead use ehci-platform
> and ohci-platform as suggested with
> http://marc.info/?l=linux-mips&m=140139694721623&w=2
> 
> [andreas.herrmann:
> 	fixed compile error]
> 
> Cc: David Daney <david.daney@cavium.com>
> Cc: Alex Smith <alex.smith@imgtec.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c |  274 ++++++++++++++++++++++++++++-
>  arch/mips/configs/cavium_octeon_defconfig |    3 +
>  drivers/usb/host/Kconfig                  |   18 +-
>  drivers/usb/host/Makefile                 |    1 -
>  drivers/usb/host/ehci-hcd.c               |    5 -
>  drivers/usb/host/ehci-octeon.c            |  188 --------------------
>  drivers/usb/host/octeon2-common.c         |  200 ---------------------
>  drivers/usb/host/ohci-hcd.c               |    5 -
>  drivers/usb/host/ohci-octeon.c            |  202 ---------------------
>  9 files changed, 285 insertions(+), 611 deletions(-)
>  delete mode 100644 drivers/usb/host/ehci-octeon.c
>  delete mode 100644 drivers/usb/host/octeon2-common.c
>  delete mode 100644 drivers/usb/host/ohci-octeon.c

For the MIPS bits:

For the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

  Ralf
