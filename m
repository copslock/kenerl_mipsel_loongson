Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 15:13:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53112 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011594AbaJ1ONpisGh9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 15:13:45 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9SEDiX2024015;
        Tue, 28 Oct 2014 15:13:44 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9SEDiTU024014;
        Tue, 28 Oct 2014 15:13:44 +0100
Date:   Tue, 28 Oct 2014 15:13:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx
 polling it
Message-ID: <20141028141344.GG16320@linux-mips.org>
References: <1414499423-16662-1-git-send-email-zajec5@gmail.com>
 <20141028124804.GC16320@linux-mips.org>
 <CACna6rxSCZJ=oUNXVYEbkSZuiyUyy96amkMKbg7pdEXkVmtkZw@mail.gmail.com>
 <20141028131315.GD16320@linux-mips.org>
 <CACna6rz78HtA6AVxQP0PWiuRSbGZvtNudHz46jLOx860kis2UA@mail.gmail.com>
 <20141028132602.GE16320@linux-mips.org>
 <CACna6rzJfJGwHP62ru=c3M0CcfrJZa7aUhMn0JQym7RgxwgPAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rzJfJGwHP62ru=c3M0CcfrJZa7aUhMn0JQym7RgxwgPAA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Oct 28, 2014 at 02:46:30PM +0100, Rafał Miłecki wrote:

> Thank you! To avoid similar confusion in the future, I've created
> patchwork account that will allow me to mark old (superseded) patches.

Yes, I wish everybody would do that.  Would save me from the daily heart
attack when I open patchwork and see 2.71 metric gazillion patches pending -
only to later find out that half of them were superseeded by later
revision!

It's also useful in case a submitter has multiple email addresses.  It
allows to search for one address and find all submissions.

> In case you find time to push two more pending BCM47XX patches, it
> would be great to see them in your tree.
> 
> 1) [V2] MIPS: BCM47XX: Move SPROM fallback code into sprom.c
> http://patchwork.linux-mips.org/patch/8232/
> It's a rebased version of patch sent ~2 months ago (7617) that was
> Acked-by Hauke
> 
> 2) MIPS: BCM47XX: Initialize bcma bus later (with mm available)
> http://patchwork.linux-mips.org/patch/8234/
> It's resend-ing of RFC patch (7606) that also was Acked-by Hauke.

Both applied and pushed.

  Ralf
