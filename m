Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2012 23:35:25 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:53452 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903722Ab2H0VfS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Aug 2012 23:35:18 +0200
Received: by eaai12 with SMTP id i12so1236458eaa.36
        for <multiple recipients>; Mon, 27 Aug 2012 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BJqF+a6jPwuhHTeLuz2sATmHcRWhoQhVeF0RU//o1SA=;
        b=Gsj72DNhS2Q1C+WWAISRjYuVzGmhjoaSkok7e+nwqbpx6JH5Umsp7xdHDxamJa5nXj
         kDW8CdbXPzrAdZO+izUFmrOfsE95goxrFhD3SxilfItijMqpHmKgGAfu+yvd2hopoXN8
         MllmBoPu1yJJpK27QNQUAsYboyXEphw1EVFdsELe/SCIcXYH9cPqvYObnNCwNYkU3s6i
         oKyaSDaJY641dzC8G3WT+gNFVh7yIu5rCns5YeQk8dfFZQfJgNHR5vobEp7bcYSmmVh/
         x3QZeql5oMomRcJ7MxXNBTMFwSHHnKMn83hRLJDSq29raDgf6GVtPjOuBpBahAytYJxe
         t3sg==
MIME-Version: 1.0
Received: by 10.14.207.9 with SMTP id m9mr19244818eeo.5.1346103313496; Mon, 27
 Aug 2012 14:35:13 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Mon, 27 Aug 2012 14:35:13 -0700 (PDT)
In-Reply-To: <20120827204613.GC6045@breakpoint.cc>
References: <2e70dcfde41aee0d733449013ac80ace@localhost>
        <20120827204613.GC6045@breakpoint.cc>
Date:   Mon, 27 Aug 2012 14:35:13 -0700
Message-ID: <CAJiQ=7Dz0Qyt10LDV=vsWGUs31GinS+2i+H8CJj_NPyWwnz-DQ@mail.gmail.com>
Subject: Re: [PATCH V4] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     balbi@ti.com, ralf@linux-mips.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34365
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

On Mon, Aug 27, 2012 at 1:46 PM, Sebastian Andrzej Siewior > One
little question: Felipe suggested to replace the workqueue by a
threaded
> interrupt. You schedule the workqueue in interrupt context and once in ep0
> enqueue. The enqueue should be fine by executing one round and waiting for the
> interrupt. Any reason why you suggested against it?

A couple of rounds could pass with no interrupt, e.g. if a
SET_CONFIGURATION request and a SET_INTERFACE request are both
pending.

Also, I ran into deadlocks when trying to invoke the gadget driver's
callback from within the UDC enqueue function.

I did attempt it; V2 of the patch had the workqueue removed, but I
backed out the change for V3 after seeing so many problems.
