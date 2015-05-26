Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 17:46:16 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:49719 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27007089AbbEZPqOCV9TE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 17:46:14 +0200
Received: (qmail 2958 invoked by uid 2102); 26 May 2015 11:46:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 May 2015 11:46:14 -0400
Date:   Tue, 26 May 2015 11:46:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ben Hutchings <ben@decadent.org.uk>
cc:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Paul Martin <paul.martin@codethink.co.uk>
Subject: Re: [PATCH v2] MIPS: Octeon: Set OHCI and EHCI MMIO byte order to
 match CPU
In-Reply-To: <1432582049.12412.134.camel@decadent.org.uk>
Message-ID: <Pine.LNX.4.44L0.1505261136070.1519-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+557d4684@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47670
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

On Mon, 25 May 2015, Ben Hutchings wrote:

> The Octeon OHCI is now supported by the ohci-platform driver, and
> USB_OCTEON_OHCI is marked as deprecated.  However, it is currently
> still necessary to enable it in order to select
> USB_OHCI_BIG_ENDIAN_MMIO.  Make CPU_CAVIUM_OCTEON select that as well,
> so that USB_OCTEON_OHCI is really obsolete.

Good catch.

> The old ohci-octeon and ehci-octeon drivers also only enabled big-endian
> MMIO in case the CPU was big-endian.

This is true in the current kernel as well.  [eo]hci-platform.c enables
big-endian MMIO only if the appropriate flag is set in the platform
data or OF properties.

>  Make the selections of
> USB_EHCI_BIG_ENDIAN_MMIO and USB_OHCI_BIG_ENDIAN_MMIO conditional, to
> match this.

I'm not sure you want to do this.  [eo]hci-platform.c will fail with an 
error if the platform/OF data has the big-endian flag set but 
CONFIG_USB_[EO]HCI_BIG_ENDIAN_MMIO isn't defined.

> Fixes: 2193dda5eec6 ("USB: host: Remove ehci-octeon and ohci-octeon drivers")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> v2: Make selections conditional
> 
> This is also untested; I'm just comparing the old and new code.

Is there anyone who can test this with both big-endian and 
little-endian hardware?

Alan Stern
