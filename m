Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 23:08:37 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:43772 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903498Ab2HUVIa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 23:08:30 +0200
Received: by eekc13 with SMTP id c13so74847eek.36
        for <multiple recipients>; Tue, 21 Aug 2012 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CVPrF8P0an6PwixxKnRT1fzngMPHR1uGXrGelrZN5Ug=;
        b=Ur2qMaV3ii3133kTKm1kam154KbytoqP7YG/CRiPLufOYOxQJPF4wiAlcJlexJGFWa
         b8ESL52P0ZBCCoZ6NlBhSrrrqH8bLfm62ZPrL9sCem/LQqSPivrej/VVfOZHC4pO4xCI
         FdvVqvj2cIKcFCLsn/D7Vmu1iOwfKknl6ll88YptSKxj88TSqMgGk5yeSLcwRlknyv52
         6PtS7GZhOP0gd8zRWN2iTz6fzDe+uihIJ7tn/HTLyDAREnJgVoFuyZM7PB0wNFjVLqvD
         2FWihOm7X02SK3/UVQXMzTktrlKqJ5Zz68EmeUqQfKyzVUIChInA2qvX4+0sgXiCqj+O
         IKng==
MIME-Version: 1.0
Received: by 10.14.176.6 with SMTP id a6mr15223547eem.13.1345583305420; Tue,
 21 Aug 2012 14:08:25 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Tue, 21 Aug 2012 14:08:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1208211625200.1163-100000@iolanthe.rowland.org>
References: <CAJiQ=7BJF39Xs3_U+8SnbBRPT3QyneCZmX3Z4WSvPfB3u88LSA@mail.gmail.com>
        <Pine.LNX.4.44L0.1208211625200.1163-100000@iolanthe.rowland.org>
Date:   Tue, 21 Aug 2012 14:08:25 -0700
Message-ID: <CAJiQ=7DefOV1daP5bfxmgPHseYvx8Yj1K7h=Kv3hc9iaKv0wXw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Aug 21, 2012 at 1:34 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> It is a silicon feature: the core will intercept SET_CONFIGURATION /
>> SET_INTERFACE requests, store wValue/wIndex in the appropriate
>> USBD_STATUS_REG field (cfg/intf/altintf), send an acknowledgement to
>> the host, and raise a control interrupt.
>
> Your explanation is not clear.  The operations you listed are exactly
> what any UDC should do when it receives any control request: It should
> store the bRequestType, bRequest, wValue, wIndex, and wLength values in
> appropriate registers, send an ACK back to the host, and generate an
> IRQ.  What's special about Set-Config and Set-Interface?

For "most" control requests (such as GET_DESCRIPTOR), this core writes
the raw packet data out to a buffer in DRAM and raises an IUDMA IRQ.
The UDC driver passes this data on to the gadget driver and allows it
to decide what to send back in subsequent phases.

But some requests are handled entirely in hardware, including the status phase:

SET_ADDRESS
SET_CONFIGURATION
SET_INTERFACE
SET_FEATURE
CLEAR_FEATURE
GET_FEATURE

Where appropriate, the hardware block will update its registers to
indicate the new settings and raise a control IRQ.

>> I haven't found it to be terribly helpful, but I don't know of a way
>> to turn it off.
>
> Why would you want to turn this off?  Isn't is exactly what you want to
> have happen?  And why do you need a workqueue to handle the request?

SET_CONFIGURATION and SET_INTERFACE need to generate setup callbacks
for the gadget driver, and the proper ordering of events needs to be
enforced.  It is possible to receive IRQs for "SET_CONFIGURATION has
happened," "SET_INTERFACE has happened," and "there is another control
request pending," all at nearly the same time, before the gadget
driver has had an opportunity to respond to the first setup request.
But if that happened, we would not want to generate three setup
callbacks in a row.

Example:

1) SET_CONFIGURATION transfer completes (including status phase), all
handled by hardware.  Control interrupt is raised.

2) Setup packet is sent to USB gadget driver (say, gadgetfs)

3) SET_INTERFACE transfer completes, and another control interrupt is raised

4) Gadget driver eventually gets around to queuing the SET_CONFIGURATION reply.

5) Now we are in the UDC queue function and the gadget driver is
probably holding a spinlock.  We want to invoke the setup callback
with the spoofed SET_INTERFACE packet, but it's not safe to do it from
here.

To complicate the situation, another setup packet can arrive between
steps 3 and 4.  But the worker function makes sure everything plays
out in the right order.
