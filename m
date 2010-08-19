Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2010 15:29:41 +0200 (CEST)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:53150 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab0HSN3g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Aug 2010 15:29:36 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id 374821B402E;
        Thu, 19 Aug 2010 22:29:32 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Thu, 19 Aug 2010 22:29:32 +0900 (JST)
Date:   Thu, 19 Aug 2010 22:29:28 +0900 (JST)
Message-Id: <20100819.222928.35468456.anemo@mba.ocn.ne.jp>
To:     fujita.tomonori@lab.ntt.co.jp
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: TX49xx: rename ARCH_KMALLOC_MINALIGN to
 ARCH_DMA_MINALIGN
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20100814160128H.fujita.tomonori@lab.ntt.co.jp>
References: <20100814160128H.fujita.tomonori@lab.ntt.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 14 Aug 2010 16:02:37 +0900, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> Architectures need to set ARCH_DMA_MINALIGN to the minimum DMA
> alignment (the commit
> a6eb9fe105d5de0053b261148cee56c94b4720ca). Defining
> ARCH_KMALLOC_MINALIGN doesn't work anymore.

Thank you for picking this up.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
