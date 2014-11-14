Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 10:33:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59556 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013672AbaKNJdZ1mBIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 10:33:25 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAE9XNtb009625;
        Fri, 14 Nov 2014 10:33:23 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAE9XNQE009624;
        Fri, 14 Nov 2014 10:33:23 +0100
Date:   Fri, 14 Nov 2014 10:33:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] USB: host: Remove hard-coded octeon platform
 information for ehci/ohci
Message-ID: <20141114093322.GD24165@linux-mips.org>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-3-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415914590-31647-3-git-send-email-andreas.herrmann@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44154
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

On Thu, Nov 13, 2014 at 10:36:29PM +0100, Andreas Herrmann wrote:

> Instead rely on device tree information for ehci and ohci.
> 
> This was suggested with
> http://www.linux-mips.org/archives/linux-mips/2014-05/msg00307.html
> 
>   "The device tree will *always* have correct ehci/ohci clock
>   configuration, so use it.  This allows us to remove a big chunk of
>   platform configuration code from octeon-platform.c."
> 
> More or less I rebased that patch on Alan's work to remove ehci-octeon
> and ohci-octeon drivers.
> 
> Cc: David Daney <david.daney@cavium.com>
> Cc: Alex Smith <alex.smith@imgtec.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>

For the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
