Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2010 15:13:14 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:50455 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491018Ab0IGNNL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Sep 2010 15:13:11 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id 5F94756421D;
        Tue,  7 Sep 2010 22:13:06 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Tue,  7 Sep 2010 22:13:06 +0900 (JST)
Date:   Tue, 07 Sep 2010 22:13:07 +0900 (JST)
Message-Id: <20100907.221307.39158422.anemo@mba.ocn.ne.jp>
To:     cernekee@gmail.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MIPS: Move FIXADDR_TOP into spaces.h
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <d84f0a8caeb61c388b1145f89c879de3@localhost>
References: <d84f0a8caeb61c388b1145f89c879de3@localhost>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 27727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5229

On Mon, 6 Sep 2010 21:03:52 -0700, Kevin Cernekee <cernekee@gmail.com> wrote:
> -#define FIXADDR_TOP	((unsigned long)(long)(int)0xfffe0000)
...
> +#define FIXADDR_TOP		_AC(0xfffe0000, UL)

For 64-bit kernel, FIXADDR_TOP should be 0xfffffffffffe0000UL not
0x00000000fffe0000UL.

The magical casts are used to sign-extend the address.  Please do not
drop them.

---
Atsushi Nemoto
