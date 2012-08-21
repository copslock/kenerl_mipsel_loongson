Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 22:34:40 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:38175 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903629Ab2HUUeh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 22:34:37 +0200
Received: (qmail 11833 invoked by uid 2102); 21 Aug 2012 16:34:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Aug 2012 16:34:33 -0400
Date:   Tue, 21 Aug 2012 16:34:33 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     balbi@ti.com, <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
In-Reply-To: <CAJiQ=7BJF39Xs3_U+8SnbBRPT3QyneCZmX3Z4WSvPfB3u88LSA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1208211625200.1163-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34329
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

> On Tue, Aug 21, 2012 at 11:08 AM, Felipe Balbi <balbi@ti.com> wrote:
> > Then stick to a workqueue... but could you let me know why exactly you
> > have to fake SET_CONFIGURATION/SET_INTERFACE requests ? Is this a
> > silicon bug or a silicon feature ? That's quite weird to me.
> 
> It is a silicon feature: the core will intercept SET_CONFIGURATION /
> SET_INTERFACE requests, store wValue/wIndex in the appropriate
> USBD_STATUS_REG field (cfg/intf/altintf), send an acknowledgement to
> the host, and raise a control interrupt.

Your explanation is not clear.  The operations you listed are exactly
what any UDC should do when it receives any control request: It should
store the bRequestType, bRequest, wValue, wIndex, and wLength values in
appropriate registers, send an ACK back to the host, and generate an
IRQ.  What's special about Set-Config and Set-Interface?

The only thing to watch out for is the status stage of the control
transfer.  The hardware must not complete the status stage for you;
that would be a violation of the USB-2 spec.  (The only exception is
for Set-Address requests.)

> I haven't found it to be terribly helpful, but I don't know of a way
> to turn it off.

Why would you want to turn this off?  Isn't is exactly what you want to 
have happen?  And why do you need a workqueue to handle the request?

Alan Stern
