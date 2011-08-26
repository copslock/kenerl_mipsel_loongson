Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 09:36:34 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:53588 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491099Ab1HZHga (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Aug 2011 09:36:30 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1Qwqxo-0002t2-PA; Fri, 26 Aug 2011 07:36:28 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Qwqxi-0003rO-Sd; Fri, 26 Aug 2011 09:36:22 +0200
Date:   Fri, 26 Aug 2011 09:36:22 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: [PATCH] mips/loongson: unify compiler flags and load location
        for Loongson 2E and 2F
Message-ID: <20110826073622.GA32219@mails.so.argh.org>
Mail-Followup-To: Andreas Barth <aba@not.so.argh.org>,
        wu zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
References: <20110821010513.GZ2657@mails.so.argh.org> <20110825080054.GA10459@mails.so.argh.org> <CAD+V5Y+0JujdTz9ET1LAurCMP6D1nvC1tkoYg+gHXXJ=VL9mMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+V5Y+0JujdTz9ET1LAurCMP6D1nvC1tkoYg+gHXXJ=VL9mMQ@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19663

Hi Wu,

* wu zhangjin (wuzhangjin@gmail.com) [110826 05:21]:
> but only this patch is not enough, we may also need to take care of
> the following parts:

Thank you for your hints. For some files, I already have more patches
currently being load-tested on my machines here. For other, I might
need some more help. I see this rather as an step-by-step effort and
not as one-time action.


Andi
