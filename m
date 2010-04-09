Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Apr 2010 16:27:46 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:38772 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491968Ab0DIO1l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Apr 2010 16:27:41 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id 4E1A956421D;
        Fri,  9 Apr 2010 23:27:35 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Fri,  9 Apr 2010 23:27:35 +0900 (JST)
Date:   Fri, 09 Apr 2010 23:27:31 +0900 (JST)
Message-Id: <20100409.232731.07635176.anemo@mba.ocn.ne.jp>
To:     geert@linux-m68k.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips/txx9: Add missing MODULE_ALIAS definitions for
 txx9 platform devices
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <s2y10f740e81004081152u53d1520fp812bd2defe886220@mail.gmail.com>
References: <s2y10f740e81004081152u53d1520fp812bd2defe886220@mail.gmail.com>
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
X-archive-position: 26374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 8 Apr 2010 20:52:00 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> I need the patch below to enable autoloading of the TXx9 sound driver
> on my RBTX4927.
> It works very nice as a low-power MPD player.

Thank you, good news.

> Subject: [PATCH] mips/txx9: Add missing MODULE_ALIAS definitions for
> txx9 platform devices
> 
> This enables autoloading of the TXx9 sound driver on my RBTX4927.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
