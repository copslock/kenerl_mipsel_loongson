Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2014 19:50:29 +0100 (CET)
Received: from alius.ayous.org ([89.238.89.44]:60198 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822682AbaBPSuZPva-r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Feb 2014 19:50:25 +0100
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@ayous.org>)
        id 1WF6nC-00054q-Ot; Sun, 16 Feb 2014 18:50:19 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@ayous.org>)
        id 1WF6n6-0004lB-UC; Sun, 16 Feb 2014 19:50:12 +0100
Date:   Sun, 16 Feb 2014 19:50:12 +0100
From:   Andreas Barth <aba@ayous.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: fpu: fix conflict of register usage
Message-ID: <20140216185012.GJ16461@mails.so.argh.org>
References: <1392477204-16238-1-git-send-email-chenhc@lemote.com> <1392477204-16238-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392477204-16238-2-git-send-email-chenhc@lemote.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@ayous.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39325
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

* Huacai Chen (chenhc@lemote.com) [140215 16:14]:
> In _restore_fp_context/_restore_fp_context32, t0 is used for both
> CP0_Status and CP1_FCSR. This is a mistake and cause FP exeception on
> boot, so fix it.

I can confirm that it fixes boot-up on loongson 3 too.

> Signed-off-by: Huacai Chen <chenhc@lemote.com>
Tested-by: Andreas Barth <aba@ayous.org>



Thanks,
Andi
