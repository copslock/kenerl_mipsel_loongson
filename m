Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2014 00:28:10 +0100 (CET)
Received: from alius.ayous.org ([89.238.89.44]:42489 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825397AbaBFX2JENbHu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Feb 2014 00:28:09 +0100
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@ayous.org>)
        id 1WBYMT-00046F-AA; Thu, 06 Feb 2014 23:28:01 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@ayous.org>)
        id 1WBYMN-0000mv-PH; Fri, 07 Feb 2014 00:27:55 +0100
Date:   Fri, 7 Feb 2014 00:27:55 +0100
From:   Andreas Barth <aba@ayous.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 00/12] MIPS: Add Loongson-3 based machines support
Message-ID: <20140206232755.GL12772@mails.so.argh.org>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com> <20140118093807.GN16461@mails.so.argh.org> <0466fa9d60b91233d2157d5ce0b51333.squirrel@mail.lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0466fa9d60b91233d2157d5ce0b51333.squirrel@mail.lemote.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@ayous.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@ayous.org
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

Hi,

* "陈华才" (chenhc@lemote.com) [140118 13:14]:
> > * Huacai Chen (chenhc@lemote.com) [140108 03:45]:
> >> This patchset is prepared for the next 3.14 release for Linux/MIPS.
> >> Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2 compatible
> >> and has the same IMP field (0x6300) as Loongson-2. These patches make
> >> Linux kernel support Loongson-3 CPU and Loongson-3 based computers
> >> (including Laptop, Mini-ITX, All-In-One PC, etc.)
> >
> > Your patch series already made some good progress, and so I hope that
> > we manage to get this patch merged during the next cycle (i.e. during
> > 3.15).
> >
> > To achive this it would be good if you could incorporate the remaining
> > review comments into a new version and send it out soon. (We should
> > try to get it ready as soon as possible even if it won't be in 3.14,
> > so that we are sure to really reach 3.15 and not be delayed again.)

> Thank you very much, I will make the V17 patchset ready for 3.15 after
> China's New Year's Day.

I hope you had a happy new year.


Do you have any updates when we can expect the new patch sets? If we
want/need another round of reviews, we need to have the patch soon, so
that it could be pushed to -next in time for the next merge cycle.


Thanks,
Andi
