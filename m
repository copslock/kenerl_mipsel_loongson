Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 09:08:07 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:37682 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490950Ab1IOHIC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Sep 2011 09:08:02 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1R463C-0000mA-Ra; Thu, 15 Sep 2011 07:07:59 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1R4637-0000Zu-5l; Thu, 15 Sep 2011 09:07:53 +0200
Date:   Thu, 15 Sep 2011 09:07:53 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, wuzhangjin@gmail.com, r0bertz@gentoo.org,
        chenj@lemote.com
Subject: Re: [PATCH] MIPS: Add basic support for Loongson1B
Message-ID: <20110915070752.GU15003@mails.so.argh.org>
References: <1315997270-14332-1-git-send-email-keguang.zhang@gmail.com> <20110914113134.GS15003@mails.so.argh.org> <CAJhJPsUW+4fpJUSR07LBO=FDCyAw-KHKaZCt8G+sHCJtjts0oA@mail.gmail.com> <20110914160013.GH4110@mails.so.argh.org> <CAJhJPsUXvGJBB-YiLB53VSf8GRXHjkrPRf3F3YE5ekOz-OVqgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsUXvGJBB-YiLB53VSf8GRXHjkrPRf3F3YE5ekOz-OVqgQ@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 31090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7609

* Kelvin Cheung (keguang.zhang@gmail.com) [110915 05:28]:
> >> > Doesn't any of the existing clock drivers work?
> >> >
> >> > Is this clock part of the CPU? Otherwise it would make sense to move
> >> > it out to the generic drivers section.
> >
> > What's the answer to this questions?
> 
> I just did what other platform did, such as ar7, ath79, bcm63xx and
> jz4740. Could you have a look at their clock.c/clk.c?

Just it was done before doesn't mean it should be done again.

In an ideal world, a new platform would mean to just add
autodetection, the device tree, and the possibility of optimizing for
the CPU. Any drivers should be with the drivers, not with the
platform.  We're not there yet, but we should at least try to make
things as generic as possible.

(Or to quote someone else: Didn't the mips maintainer learn anything
from the arm mess?)


> I did not just duplicate code, modified exactly. The prom-routines of
> loongson platform does not fit loongson1.For instance, the
> "cpu_clock_freq" parameter is not needed. The cpu freq. could be get
> from the PLL register directly. Moreover, the routines does not
> include the parameter "ethaddr", which is useful for embedded system.

So why not make this optional? Or depend on the system type for what
you return?




Andi
