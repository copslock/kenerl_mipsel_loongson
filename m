Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 15:42:05 +0100 (CET)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:45333 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492289Ab0BBOmB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 15:42:01 +0100
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id C9D3E1B4241;
        Tue,  2 Feb 2010 23:41:56 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Tue,  2 Feb 2010 23:41:56 +0900 (JST)
Date:   Tue, 02 Feb 2010 23:41:50 +0900 (JST)
Message-Id: <20100202.234150.39158143.anemo@mba.ocn.ne.jp>
To:     yuasa@linux-mips.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: txx9: remove forced serial console setting
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20100202184004.efdff568.yuasa@linux-mips.org>
References: <20100202184004.efdff568.yuasa@linux-mips.org>
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
X-archive-position: 25852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 2 Feb 2010 18:40:04 +0900, Yoichi Yuasa <yuasa@linux-mips.org> wrote:
> It is not always used, even if it is available.
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/include/asm/txx9/generic.h |    1 -
>  arch/mips/txx9/generic/setup.c       |    5 -----
>  arch/mips/txx9/jmr3927/setup.c       |    7 -------
>  arch/mips/txx9/rbtx4927/setup.c      |    7 -------
>  arch/mips/txx9/rbtx4938/setup.c      |    6 ------
>  5 files changed, 0 insertions(+), 26 deletions(-)

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
