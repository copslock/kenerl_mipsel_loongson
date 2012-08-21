Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 23:34:19 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:38208 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903616Ab2HUVeO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 23:34:14 +0200
Received: (qmail 11963 invoked by uid 2102); 21 Aug 2012 17:34:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Aug 2012 17:34:10 -0400
Date:   Tue, 21 Aug 2012 17:34:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     balbi@ti.com, <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
In-Reply-To: <CAJiQ=7DefOV1daP5bfxmgPHseYvx8Yj1K7h=Kv3hc9iaKv0wXw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1208211719480.1163-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34333
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 21 Aug 2012, Kevin Cernekee wrote:

> On Tue, Aug 21, 2012 at 1:34 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> It is a silicon feature: the core will intercept SET_CONFIGURATION /
> >> SET_INTERFACE requests, store wValue/wIndex in the appropriate
> >> USBD_STATUS_REG field (cfg/intf/altintf), send an acknowledgement to
> >> the host, and raise a control interrupt.
> >
> > Your explanation is not clear.  The operations you listed are exactly
> > what any UDC should do when it receives any control request: It should
> > store the bRequestType, bRequest, wValue, wIndex, and wLength values in
> > appropriate registers, send an ACK back to the host, and generate an
> > IRQ.  What's special about Set-Config and Set-Interface?
> 
> For "most" control requests (such as GET_DESCRIPTOR), this core writes
> the raw packet data out to a buffer in DRAM and raises an IUDMA IRQ.
> The UDC driver passes this data on to the gadget driver and allows it
> to decide what to send back in subsequent phases.
> 
> But some requests are handled entirely in hardware, including the status phase:
> 
> SET_ADDRESS
> SET_CONFIGURATION
> SET_INTERFACE
> SET_FEATURE
> CLEAR_FEATURE
> GET_FEATURE

I assume the features in question are endpoint-halts and
remote-wakeup-enable.  It's hard to think of any other features that 
could be handled in hardware.

> Where appropriate, the hardware block will update its registers to
> indicate the new settings and raise a control IRQ.

I see.  Didn't the manufacturer realize that, in the case of Set-Config
and Set-Interface, this violates the USB-2 specification?  The spec
explicitly says that the status stage must not be completed until the
operation is fully carried out.

(BTW, what happens if one of these requests arrives before a previous
control IRQ has been acknowledged by the CPU?  Does the old data in the
registers get overwritten and lost, or does the UDC hold off on 
carrying out the new request?)

I can't imagine how any gadget driver could hope to handle a mess like 
this.  For instance, suppose a Set-Config operation fails.  There's no 
way for the driver to tell the host, because the hardware has already 
said that the operation succeeded.

Anyway, you don't need to workqueue to manage this -- just a queue of 
pending control requests.  You should be able to do everything in 
interrupt context, especially since you will ignore any responses the 
driver submits on ep0 for these transfers.

Alan Stern
