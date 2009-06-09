Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2009 03:13:10 +0100 (WEST)
Received: from fwgate.192.149.94.202.in-addr.arpa ([202.94.149.254]:35704 "EHLO
	topsms.toshiba-tops.co.jp" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S20023739AbZFICM6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Jun 2009 03:12:58 +0100
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 110EE4DC4B;
	Tue,  9 Jun 2009 11:03:08 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id F2B044DC3E;
	Tue,  9 Jun 2009 11:03:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id n592CmoI024327;
	Tue, 9 Jun 2009 11:12:49 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 09 Jun 2009 11:12:48 +0900 (JST)
Message-Id: <20090609.111248.161838296.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: MIPS: Outline udelay and fix a few issues.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20022929AbZFHPuy/20090608155054Z+9196@ftp.linux-mips.org>
References: <S20022929AbZFHPuy/20090608155054Z+9196@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 08 Jun 2009 16:50:51 +0100, linux-mips@linux-mips.org wrote:
> Outlining fixes the issue were on certain CPUs such as the R10000 family
> the delay loop would need an extra cycle if it overlaps a cacheline
> boundary.
> 
> The rewrite also fixes build errors with GCC 4.4 which was changed in
> way incompatible with the kernel's inline assembly.
> 
> Relying on pure C for computation of the delay value removes the need for
> explicit.  The price we pay is a slight slowdown of the computation - to
> be fixed on another day.

Please fix this commit.

------------------------------------------------------
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Subject: [PATCH] fix __ndelay build error and add 'ull' suffix for 32-bit kernel

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib/delay.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index f69c6b5..6b3b1de 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -43,7 +43,7 @@ void __udelay(unsigned long us)
 {
 	unsigned int lpj = current_cpu_data.udelay_val;
 
-	__delay((us * 0x000010c7 * HZ * lpj) >> 32);
+	__delay((us * 0x000010c7ull * HZ * lpj) >> 32);
 }
 EXPORT_SYMBOL(__udelay);
 
@@ -51,6 +51,6 @@ void __ndelay(unsigned long ns)
 {
 	unsigned int lpj = current_cpu_data.udelay_val;
 
-	__delay((us * 0x00000005 * HZ * lpj) >> 32);
+	__delay((ns * 0x00000005ull * HZ * lpj) >> 32);
 }
 EXPORT_SYMBOL(__ndelay);


Also, a block comment in delay.c should be updated...

---
Atsushi Nemoto
