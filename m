Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2012 21:44:30 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:50934 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903677Ab2HYToY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Aug 2012 21:44:24 +0200
Received: by eaai12 with SMTP id i12so772608eaa.36
        for <multiple recipients>; Sat, 25 Aug 2012 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xKM+3e8IEaI2QjzjzgpufPgWZGPhKN5fIzcuvd6d+wk=;
        b=Ah/JcGqN5huK7ULYdveGiJlTWmx1rGjEncZJ2R2HcFkmRYlHultXdw89XTxjMRxSpP
         xRMSmmBX92Z1BVH92GYxP49xIDeCRWYo4jrG71JwoG0XlZWAIW4u7D6VmeLZ4w+CPK/o
         o02tu7nZokVnNGTME8yZZXQckoEjNME+PQ3wOdjTVzWcGlVNs5jKdfYL67nlqW7sG6GD
         iYdrVJjoWAdjX39f+rdALL1+EhFaGRU/U3N8trVTQZArneG7hLMP7lvgbLd2g/P95NVN
         nZTB4aoy1eHQdk3CdbQpfDJrZYv7o1XCFYvhmOLgGVXkSHP3RB4z7VIKAl532Lt37cGm
         u9cA==
MIME-Version: 1.0
Received: by 10.14.176.6 with SMTP id a6mr11833862eem.13.1345923859395; Sat,
 25 Aug 2012 12:44:19 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Sat, 25 Aug 2012 12:44:19 -0700 (PDT)
In-Reply-To: <20120822074815.GB3563@breakpoint.cc>
References: <5ff8f23aae05690ba89476c4924b9387@localhost>
        <20120822074815.GB3563@breakpoint.cc>
Date:   Sat, 25 Aug 2012 12:44:19 -0700
Message-ID: <CAJiQ=7Da5CdoQ2e=CutFt32xRXqUGHitCC+GJMzvbUUPC5yQzQ@mail.gmail.com>
Subject: Re: [PATCH V3] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     balbi@ti.com, ralf@linux-mips.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34358
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

On Wed, Aug 22, 2012 at 12:48 AM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> Just one thing that bit while I was sleeping:
> The HW acks SetConfig on its own. Once you notice this, you set
> ->ep0_req_set_cfg and set state in bcm63xx_ep0_do_idle() to
> EP0_IN_FAKE_STATUS_PHASE. This is I guess the workaround for mass_storage's
> hold with DELAYED_STATUS and continues with a zero packet.

EP0_IN_FAKE_STATUS_PHASE is there for the general case of: setup()
callback returned >= 0 after a spoofed setup packet, and we're waiting
for the gadget driver to send the 0-byte status reply so we can
silently discard it and move on.

When bcm63xx_udc is in EP0_IN_FAKE_STATUS_PHASE, it won't issue any
more setup() callbacks until the 0-byte reply arrives from the gadget
driver.  If the host sends a setup request, the callback will be held
off until after the (unused) status reply.  This keeps the gadget
driver from getting confused by out-of-sequence events.

> Now two questions:
> - If a gadget descides not NAK / stall the SetConfig requests. What happens
>   here?

If the return value from the setup() callback was negative,
bcm63xx_udc should just return to EP0_IDLE as the gadget driver will
never send a 0-byte reply.

I have added a new check for this condition, verified that it works as
intended, and posted V4.

I am hoping that these invalid SET_CONFIGURATION / SET_INTERFACE
requests are uncommon.  In what sorts of situations will a host
request a configuration that isn't advertised in the device's
descriptors?  I had trouble just convincing usb_set_interface() /
usb_driver_set_configuration() to send such a request because they
honor bInterfaceNumber / bConfigurationValue from the descriptors.

> - What happens if the host is faster than the UDC. SetConfig returns in
>   usb-storage with "DELAYED_STATUS". HW Acks this. Could the Host send another
>   request before the gadget queues the ep0 request?

Could you please clarify if this is the sequence of events you are describing:

1) Host sends a valid SET_CONFIGURATION request to a mass storage gadget

2) Hardware instantly auto-acks the request, completing the status
phase and allowing the host to proceed with another ep0 request

3) bcm63xx_udc sends a spoofed SET_CONFIGURATION setup packet to the
gadget driver

4) setup() callback returns USB_GADGET_DELAYED_STATUS (0x7fff) but
doesn't queue up a reply

5) Host sends another setup packet before
usb_composite_setup_continue() is called to send the 0-byte status
reply


If so, the next steps should look like:

6) bcm63xx_udc takes a data IRQ, and sets ep0_req_completed

7) bcm63xx_udc stays in EP0_IN_FAKE_STATUS_PHASE until the 0-byte
reply is received from usb_composite_setup_continue()

8) usb_composite_setup_continue() eventually sends the 0-byte reply

9) bcm63xx_udc returns to EP0_IDLE and notices that ep0_req_completed is now set

10) bcm63xx_ep0_do_setup() looks at the new request, and performs the
setup() callback for the new setup request

11) Data/status phases are handled as usual
