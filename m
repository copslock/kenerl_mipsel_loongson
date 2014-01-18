Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jan 2014 10:38:23 +0100 (CET)
Received: from alius.ayous.org ([89.238.89.44]:60454 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817664AbaARJiVWqp5Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 Jan 2014 10:38:21 +0100
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@ayous.org>)
        id 1W4SM0-0007te-Ts; Sat, 18 Jan 2014 09:38:13 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@ayous.org>)
        id 1W4SLv-0003rS-Gv; Sat, 18 Jan 2014 10:38:07 +0100
Date:   Sat, 18 Jan 2014 10:38:07 +0100
From:   Andreas Barth <aba@ayous.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 00/12] MIPS: Add Loongson-3 based machines support
Message-ID: <20140118093807.GN16461@mails.so.argh.org>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@ayous.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39032
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


* Huacai Chen (chenhc@lemote.com) [140108 03:45]:
> This patchset is prepared for the next 3.14 release for Linux/MIPS.
> Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2 compatible
> and has the same IMP field (0x6300) as Loongson-2. These patches make
> Linux kernel support Loongson-3 CPU and Loongson-3 based computers
> (including Laptop, Mini-ITX, All-In-One PC, etc.)

Your patch series already made some good progress, and so I hope that
we manage to get this patch merged during the next cycle (i.e. during
3.15).

To achive this it would be good if you could incorporate the remaining
review comments into a new version and send it out soon. (We should
try to get it ready as soon as possible even if it won't be in 3.14,
so that we are sure to really reach 3.15 and not be delayed again.)


Thanks,
Andi
