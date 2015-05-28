Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 19:31:36 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:39581 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27007621AbbE1RbbD0IUu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 19:31:31 +0200
Received: (qmail 11413 invoked by uid 2102); 28 May 2015 13:31:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 May 2015 13:31:31 -0400
Date:   Thu, 28 May 2015 13:31:31 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ben Hutchings <ben@decadent.org.uk>
cc:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Paul Martin <paul.martin@codethink.co.uk>
Subject: Re: [PATCH v2] MIPS: Octeon: Set OHCI and EHCI MMIO byte order to
 match CPU
In-Reply-To: <1432757813.6319.31.camel@decadent.org.uk>
Message-ID: <Pine.LNX.4.44L0.1505281330380.1448-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+557d4684@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47713
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

On Wed, 27 May 2015, Ben Hutchings wrote:

> > Is there anyone who can test this with both big-endian and 
> > little-endian hardware?
> 
> Failing that, the previous version of this patch ("MIPS: Octeon: Select
> USB_OHCI_BIG_ENDIAN_MMIO") should be a safe fix.

Yes, it should be.  If you want to submit it again as v3, I'll Ack it.

> The conditional selection in this patch is a possible optimisation on
> top of that, and not a necessary fix as I thought.

Right.

Alan Stern
