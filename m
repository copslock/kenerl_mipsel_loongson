Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 14:08:45 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:60381 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023949AbXKGOIg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2007 14:08:36 +0000
Received: from localhost (p5186-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.186])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A28D89225; Wed,  7 Nov 2007 23:08:32 +0900 (JST)
Date:	Wed, 07 Nov 2007 23:10:36 +0900 (JST)
Message-Id: <20071107.231036.75185559.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Fix and cleanup the MIPS part of the (ab)use of
 CLOCK_TICK_RATE.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20025770AbXKAPqq/20071101154646Z+4363@ftp.linux-mips.org>
References: <S20025770AbXKAPqq/20071101154646Z+4363@ftp.linux-mips.org>
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
X-archive-position: 17431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 01 Nov 2007 15:46:41 +0000, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Thu Nov 1 15:45:37 2007 +0000
> Commit: 0a354a30fe552b78a4db0873c19d8936551cc158
> Gitweb: http://www.linux-mips.org/g/linux/0a354a30
> Branch: master
> 
> This is the clock rate of the i8253 PIT.  A MIPS system may not have
> a PIT by the symbol is used all over the kernel including some APIs.
> So keeping it defined to the number for the PIT is the only sane thing
> for now.

The CLOCK_TICK_RATE is used for ACTHZ, TICK_NSEC, etc.

At least for i8253-free platforms, It looks a value multiple of HZ
would be better for such constants, assuming we have dyntick or
accurate HZ clockevents.

How about something like this?

diff --git a/include/asm-mips/timex.h b/include/asm-mips/timex.h
index 5816ad1..e9622b6 100644
--- a/include/asm-mips/timex.h
+++ b/include/asm-mips/timex.h
@@ -18,7 +18,11 @@
  * So keeping it defined to the number for the PIT is the only sane thing
  * for now.
  */
+#ifdef CONFIG_I8253
 #define CLOCK_TICK_RATE 1193182
+#else
+#define CLOCK_TICK_RATE 1024000	/* multiple of HZ */
+#endif
 
 /*
  * Standard way to access the cycle counter.
