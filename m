Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 23:58:25 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:52028 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2HUV6V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 23:58:21 +0200
Received: by eaai12 with SMTP id i12so83087eaa.36
        for <multiple recipients>; Tue, 21 Aug 2012 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nWtDI0ELYImsBnsJYpd6ORtf5NeB80H8pis1fFt/pBk=;
        b=Z5hExOzP+ZOqN/UBEX8MwkJ0ZKBxITpunp3zUJ8d2x/vOtElzwwOLji36mYZAOJkCc
         AGj0XCw6CWubRKcupf7LyC/RpkzQ2RFAKrG9tdgxd7X87z9jd6V3SZjYqP7IUweQqS9O
         Gp6/kz6joySe2iQQDMc7IAEsQnNvWxfYAE6FSlVKFYE0KZ3BS3C0VmY03aWnh+LwHtlp
         m//987L5D6JcSskLnAXIb9Zh8oVvjMwSI+s0DlT+eHPnftGjyNMYa1j4EPrzXTqJCkKd
         O5P9Yi6kxmvnlT9yzu4p+eV8mFeBIeM2phpmpQiWX3fgwL3aG/Zyu6SqYNTveweup0Ln
         aCAA==
MIME-Version: 1.0
Received: by 10.14.203.73 with SMTP id e49mr15600815eeo.27.1345586295967; Tue,
 21 Aug 2012 14:58:15 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Tue, 21 Aug 2012 14:58:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1208211719480.1163-100000@iolanthe.rowland.org>
References: <CAJiQ=7DefOV1daP5bfxmgPHseYvx8Yj1K7h=Kv3hc9iaKv0wXw@mail.gmail.com>
        <Pine.LNX.4.44L0.1208211719480.1163-100000@iolanthe.rowland.org>
Date:   Tue, 21 Aug 2012 14:58:15 -0700
Message-ID: <CAJiQ=7CdcgYjkFV2JQ4hN3+fXRKJMxq8BfR1FQto2rGZYoKg8Q@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34334
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

On Tue, Aug 21, 2012 at 2:34 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> But some requests are handled entirely in hardware, including the status phase:
>>
>> SET_ADDRESS
>> SET_CONFIGURATION
>> SET_INTERFACE
>> SET_FEATURE
>> CLEAR_FEATURE
>> GET_FEATURE
>
> I assume the features in question are endpoint-halts and
> remote-wakeup-enable.  It's hard to think of any other features that
> could be handled in hardware.

Yes, endpoint-halt is what I've seen in my testing.  Not sure on remote wakeup.

> (BTW, what happens if one of these requests arrives before a previous
> control IRQ has been acknowledged by the CPU?  Does the old data in the
> registers get overwritten and lost, or does the UDC hold off on
> carrying out the new request?)

There are separate IRQ bits for SET_CONFIGURATION, SET_INTERFACE, and
"generic setup packet."  The driver processes them in order.

Consecutive SET_INTERFACE requests could potentially get "lost," but
the controller will remember the value set in the most recent request.

> I can't imagine how any gadget driver could hope to handle a mess like
> this.  For instance, suppose a Set-Config operation fails.  There's no
> way for the driver to tell the host, because the hardware has already
> said that the operation succeeded.

Right - but looking on the bright side:

1) At least in my experience, most hosts will send a valid
SET_CONFIGURATION request so the error path won't be needed.  If it is
needed, it won't do anything really bad like hanging the interface.

2) All of this complexity is hidden inside one UDC driver, and did not
require hacking up the rest of the gadget layer.

3) After many months of struggling to get things right, the driver can
finally pass "testusb".

> Anyway, you don't need to workqueue to manage this -- just a queue of
> pending control requests.  You should be able to do everything in
> interrupt context, especially since you will ignore any responses the
> driver submits on ep0 for these transfers.

Well, in the example from my last email, I don't get any new
interrupts after SET_INTERFACE.  So after the gadget driver queues the
response to the spoofed SET_CONFIGURATION packet, I need to schedule a
workqueue (or tasklet, or timer, or something) to run the next setup
callback in a context where the gadget driver isn't holding any
spinlocks.
