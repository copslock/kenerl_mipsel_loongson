Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 14:26:25 +0100 (CET)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:36522 "EHLO
	mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493161AbZKWN0T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 14:26:19 +0100
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
	by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id 8646B56421D;
	Mon, 23 Nov 2009 22:26:12 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
	by vcmba.ocn.ne.jp (Postfix) with ESMTP;
	Mon, 23 Nov 2009 22:26:12 +0900 (JST)
Date:	Mon, 23 Nov 2009 22:26:09 +0900 (JST)
Message-Id: <20091123.222609.74748367.anemo@mba.ocn.ne.jp>
To:	dmitri.vorobiev@movial.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
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
X-archive-position: 25062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Nov 2009 13:53:37 +0200, Dmitri Vorobiev <dmitri.vorobiev@movial.com> wrote:
> Several static uninitialized variables are used in the scope of
> __init functions but are themselves not marked as __initdata.
> This patch is to put those variables to where they belong and
> to reduce the memory footprint a little bit.
> 
> Also, a couple of lines with spaces instead of tabs were fixed.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
> ---
>  arch/mips/ar7/platform.c        |    2 +-
>  arch/mips/sgi-ip22/ip22-eisa.c  |    4 ++--
>  arch/mips/sgi-ip22/ip22-setup.c |    2 +-
>  arch/mips/sgi-ip32/ip32-setup.c |    2 +-
>  arch/mips/sni/setup.c           |    2 +-
>  arch/mips/txx9/generic/setup.c  |    2 +-
>  arch/mips/txx9/rbtx4939/setup.c |    4 ++--
>  7 files changed, 9 insertions(+), 9 deletions(-)

NAK, at least for txx9 parts.  The struct mtd_partition arrays will be
referenced by mtd map drivers via platform_data.

And for console option strings parts, I doubt these can be marked as
__initdata.  Theoretically, the console driver might be a module,

---
Atsushi Nemoto
