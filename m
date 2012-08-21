Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 05:48:23 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:48639 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902244Ab2HUDsR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 05:48:17 +0200
Received: by eaai12 with SMTP id i12so1888761eaa.36
        for <multiple recipients>; Mon, 20 Aug 2012 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K5sASiuD44ziwI27xi8S/q2FwzrVfGSWiNtfHDHgaBI=;
        b=U0fqbO5lTYcBH4Ac4ypktJLlAL0BdeZ7VnymTnsh6ZW5ogE1WMMRbZEx6JqcS047gw
         psTZdUgLAeE7YfuVGROCpy2wsyPBsRBbTgFZRxURQkdpst6YRaWMaEcmzFU5xR81LHSH
         fdJvjL03hQxclEW3rg2wjuyCBeOuG0yLcZIK+o9+JY8YY034HyAR5BmLZdP2vh1O5GEV
         wWV3wsL95YxiI+D5EAME42UKaB3npsyZcLvhknUzwdB2aCLeWL71WzK3tpIe4+wjeC0v
         Az1J5V2qN0WJAvvM12Ooa4HTLbNlnzXKHxy7wFAL5UP9d27ekzKobAvpMSCmh8fOC8IJ
         PDIA==
MIME-Version: 1.0
Received: by 10.14.203.73 with SMTP id e49mr11537641eeo.27.1345520891918; Mon,
 20 Aug 2012 20:48:11 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Mon, 20 Aug 2012 20:48:11 -0700 (PDT)
In-Reply-To: <20120820074041.GH17455@arwen.pp.htv.fi>
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
        <20120820074041.GH17455@arwen.pp.htv.fi>
Date:   Mon, 20 Aug 2012 20:48:11 -0700
Message-ID: <CAJiQ=7CB2w=aNwtU4f3di6c31tD-EWO9YLejESY5HsUaHY6s1A@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     balbi@ti.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34299
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

On Mon, Aug 20, 2012 at 12:40 AM, Felipe Balbi <balbi@ti.com> wrote:
> no workqueues, please either handle the IRQ here or use threaded_irqs.
>
> again, no workqueues.

Felipe,

I am seeing all sorts of deadlocks now, after removing the workqueue
(patch V2).  Some have easy fixes, but for others it is not as
obvious.  The code was much simpler when I could just trigger a
deferred worker function.

Workqueues are used in at91_udc, lpc32xx_udc, mv_udc_core, and
pch_udc.  Could you please clarify why it is not OK to use one in
bcm63xx_udc?

Thanks.
