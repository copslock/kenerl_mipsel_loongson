Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 14:39:45 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:10488 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025859AbXK1Ojh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Nov 2007 14:39:37 +0000
Received: from localhost (p5128-ipad213funabasi.chiba.ocn.ne.jp [124.85.70.128])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0BBA09A65; Wed, 28 Nov 2007 23:39:29 +0900 (JST)
Date:	Wed, 28 Nov 2007 23:41:42 +0900 (JST)
Message-Id: <20071128.234142.106261815.anemo@mba.ocn.ne.jp>
To:	tsbogend@alpha.franken.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] IP28: added cache barrier to assembly routines
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071126223955.9BAAAC2B26@solo.franken.de>
References: <20071126223955.9BAAAC2B26@solo.franken.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 25 Nov 2007 11:47:56 +0100, Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> IP28 needs special treatment to avoid speculative accesses. gcc
> takes care for .c code, but for assembly code we need to do it
> manually.
> 
> This is taken from Peter Fuersts IP28 patches.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/lib/memcpy.S       |   10 ++++++++++
>  arch/mips/lib/memset.S       |    5 +++++
>  arch/mips/lib/strncpy_user.S |    1 +
>  include/asm-mips/asm.h       |    8 ++++++++
>  4 files changed, 24 insertions(+), 0 deletions(-)

I do not know details of this patch at all, but in general,
memcpy-inatomic.S and csum_pertial.S are candidates if you changed
memcpy.S.

---
Atsushi Nemoto
