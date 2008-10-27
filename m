Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 14:52:38 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:6357 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22508305AbYJ0Ow3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 14:52:29 +0000
Received: from localhost (p4040-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E2C3CA9DC; Mon, 27 Oct 2008 23:52:23 +0900 (JST)
Date:	Mon, 27 Oct 2008 23:52:24 +0900 (JST)
Message-Id: <20081027.235224.82088530.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] tx4938ide: Check minimum cycle time and SHWT range
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4905CB09.5020805@ru.mvista.com>
References: <20081027.223913.128619425.anemo@mba.ocn.ne.jp>
	<4905CB09.5020805@ru.mvista.com>
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
X-archive-position: 20997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 27 Oct 2008 17:07:05 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	/* -DIOx recovery time (SHWT * 4) and cycle time requirement */
> > +	while (shwt * cycle * 4 + t->act8b < t->cycle)
> 
>     This can lead to adding an extra setup cycle due to use of "non-quantized" 
> active time, here's more precise expression for the cycle time:
> 
>     (shwt * 4 + wt + (wt ? 2 : 3)) * cycle
> 
> or even this, more obsure:
> 
>     (shwt * 4 + wt + !wt + 2) * cycle

Hm, indeed.  I prefer former one.  Revised.  Thanks!


From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] tx4938ide: Check minimum cycle time and SHWT range (v2)

SHWT value is used as address valid to -CSx assertion and -CSx to -DIOx
assertion setup time, and contrarywise, -DIOx to -CSx release and -CSx
release to address invalid hold time, so it actualy applies 4 times and
so constitutes -DIOx recovery time.  Check requirement of the recovery
time and cycle time.  Also check SHWT maximum value.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4938ide.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index a0d10a9..796289c 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -39,10 +39,17 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
 	/* Address-valid to DIOR/DIOW setup */
 	shwt = DIV_ROUND_UP(t->setup, cycle);
 
+	/* -DIOx recovery time (SHWT * 4) and cycle time requirement */
+	while ((shwt * 4 + wt + (wt ? 2 : 3)) * cycle < t->cycle)
+		shwt++;
+	if (shwt > 7) {
+		pr_warning("tx4938ide: SHWT violation (%d)\n", shwt);
+		shwt = 7;
+	}
 	pr_debug("tx4938ide: ebus %d, bus cycle %dns, WT %d, SHWT %d\n",
 		 ebus_ch, cycle, wt, shwt);
 
-	__raw_writeq((cr & ~(0x3f007ull)) | (wt << 12) | shwt,
+	__raw_writeq((cr & ~0x3f007ull) | (wt << 12) | shwt,
 		     &tx4938_ebuscptr->cr[ebus_ch]);
 }
 
-- 
1.5.6.3
