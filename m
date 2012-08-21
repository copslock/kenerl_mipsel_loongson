Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 21:35:17 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:61119 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903534Ab2HUTfK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 21:35:10 +0200
Received: by eekc13 with SMTP id c13so52683eek.36
        for <multiple recipients>; Tue, 21 Aug 2012 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tvq2Ii+OpX1CqJEXbf0690kJI8V63RuzZKz/6sz+688=;
        b=KAyXWFxeVnLUAC+4xi1dnbb3Yg+VvnKF2IvTUxLyZ15hn+7OrX4Fz5W0jT5eILaDGf
         9bbc06ROmTL4NmCM3pnEv0pDeMZaXOIP0SeZqdGVUl3zqDS53emKXGoks9eFw1aeHV99
         ZxnxNmF3nNCPTQQpr04JV0L3lexK+HYAKldY0FVgjUZCZwpeDW3IngT3Y6FI2ogUms9p
         0cF+bp1S7D4dGMHF1kVE8xavJ99nQrftyKofd3LbXVe1yqt68ZswkrovuQTraQQdjEc0
         i6g1OsKMPamOsU0cmeY2wZ1P/oCrw5ShkJHqFxmCARQ0X8XvOaUjDjb0g6O1jW+qAGG8
         e/cQ==
MIME-Version: 1.0
Received: by 10.14.4.198 with SMTP id 46mr14862536eej.11.1345577705240; Tue,
 21 Aug 2012 12:35:05 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Tue, 21 Aug 2012 12:35:05 -0700 (PDT)
In-Reply-To: <20120821180818.GC20360@arwen.pp.htv.fi>
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
        <20120820074041.GH17455@arwen.pp.htv.fi>
        <CAJiQ=7CB2w=aNwtU4f3di6c31tD-EWO9YLejESY5HsUaHY6s1A@mail.gmail.com>
        <20120821120418.GE10347@arwen.pp.htv.fi>
        <CAJiQ=7BQz18s03du_Q33z45W+QrkVaPqgZSuUTU-x9v=48CGbA@mail.gmail.com>
        <20120821180818.GC20360@arwen.pp.htv.fi>
Date:   Tue, 21 Aug 2012 12:35:05 -0700
Message-ID: <CAJiQ=7BJF39Xs3_U+8SnbBRPT3QyneCZmX3Z4WSvPfB3u88LSA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     balbi@ti.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34327
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

On Tue, Aug 21, 2012 at 11:08 AM, Felipe Balbi <balbi@ti.com> wrote:
> Then stick to a workqueue... but could you let me know why exactly you
> have to fake SET_CONFIGURATION/SET_INTERFACE requests ? Is this a
> silicon bug or a silicon feature ? That's quite weird to me.

It is a silicon feature: the core will intercept SET_CONFIGURATION /
SET_INTERFACE requests, store wValue/wIndex in the appropriate
USBD_STATUS_REG field (cfg/intf/altintf), send an acknowledgement to
the host, and raise a control interrupt.

I haven't found it to be terribly helpful, but I don't know of a way
to turn it off.

I will reinstate the workqueue and submit V3.

Thanks.
