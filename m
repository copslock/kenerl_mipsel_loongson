Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 16:23:56 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:46348 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27013720AbaKNPXzYQQ6m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 16:23:55 +0100
Received: (qmail 22570 invoked by uid 2102); 14 Nov 2014 10:23:53 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Nov 2014 10:23:53 -0500
Date:   Fri, 14 Nov 2014 10:23:53 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 3/3] USB: host: Introduce flag to enable use of 64-bit
 dma_mask for ehci-platform
In-Reply-To: <20141114085157.GA13424@alberich>
Message-ID: <Pine.LNX.4.44L0.1411141020490.1043-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+54715d4c@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44173
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

On Fri, 14 Nov 2014, Andreas Herrmann wrote:

> On Thu, Nov 13, 2014 at 08:44:17PM -0800, Florian Fainelli wrote:
> > 2014-11-13 13:36 GMT-08:00 Andreas Herrmann
> > <andreas.herrmann@caviumnetworks.com>:
> > > ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
> > > and usage of ehci-platform ehci dma_mask is now limited to 32 bits
> > > (coerced in ehci_platform_probe).
> > >
> > > Provide a flag in ehci platform data to allow use of 64 bits for
> > > dma_mask.
> > 
> > Why not just allow enforcing an arbitrary DMA mask?
> 
> I thought about that but as it's currently just 32 or 64 bits
> a flag is sufficient. (At the moment I am not aware that
> other ehci-platform devices would require something else.)
> 
> I'll change the flag to a mask if desired.
> Alan, what's your opinion about this?

I'm not aware of any devices that need a different DMA mask either.  

Florian, do you have any reason for thinking such a thing might come 
along?  Like Andreas, I don't mind making it more general if there's a 
good reason to do so.

Alan Stern
