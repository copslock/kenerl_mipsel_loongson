Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2012 21:30:28 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:54465 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903203Ab2HZTaT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Aug 2012 21:30:19 +0200
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.72)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1T5iXH-00062S-5X; Sun, 26 Aug 2012 21:30:15 +0200
Date:   Sun, 26 Aug 2012 21:30:14 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, balbi@ti.com,
        ralf@linux-mips.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH V3] usb: gadget: bcm63xx UDC driver
Message-ID: <20120826193014.GL3690@breakpoint.cc>
References: <5ff8f23aae05690ba89476c4924b9387@localhost>
 <20120822074815.GB3563@breakpoint.cc>
 <CAJiQ=7Da5CdoQ2e=CutFt32xRXqUGHitCC+GJMzvbUUPC5yQzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7Da5CdoQ2e=CutFt32xRXqUGHitCC+GJMzvbUUPC5yQzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
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

On Sat, Aug 25, 2012 at 12:44:19PM -0700, Kevin Cernekee wrote:
> When bcm63xx_udc is in EP0_IN_FAKE_STATUS_PHASE, it won't issue any
> more setup() callbacks until the 0-byte reply arrives from the gadget
> driver.  If the host sends a setup request, the callback will be held
> off until after the (unused) status reply.  This keeps the gadget
> driver from getting confused by out-of-sequence events.

Okay. Then it works as requested :)

> > - What happens if the host is faster than the UDC. SetConfig returns in
> >   usb-storage with "DELAYED_STATUS". HW Acks this. Could the Host send another
> >   request before the gadget queues the ep0 request?
> 
> Could you please clarify if this is the sequence of events you are describing:
> 
> 1) Host sends a valid SET_CONFIGURATION request to a mass storage gadget
> 
> 2) Hardware instantly auto-acks the request, completing the status
> phase and allowing the host to proceed with another ep0 request
> 
> 3) bcm63xx_udc sends a spoofed SET_CONFIGURATION setup packet to the
> gadget driver
> 
> 4) setup() callback returns USB_GADGET_DELAYED_STATUS (0x7fff) but
> doesn't queue up a reply
> 
> 5) Host sends another setup packet before
> usb_composite_setup_continue() is called to send the 0-byte status
> reply

exactly 
 
> If so, the next steps should look like:
> 
> 6) bcm63xx_udc takes a data IRQ, and sets ep0_req_completed
> 
> 7) bcm63xx_udc stays in EP0_IN_FAKE_STATUS_PHASE until the 0-byte
> reply is received from usb_composite_setup_continue()
> 
> 8) usb_composite_setup_continue() eventually sends the 0-byte reply
> 
> 9) bcm63xx_udc returns to EP0_IDLE and notices that ep0_req_completed is now set
> 
> 10) bcm63xx_ep0_do_setup() looks at the new request, and performs the
> setup() callback for the new setup request

Okay. This sounds good.

> 11) Data/status phases are handled as usual

Please tell you HW vendor that this auto ack feature is complete non sense
unless you already have :)

Sebastian
