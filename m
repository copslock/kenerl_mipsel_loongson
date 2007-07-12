Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 16:22:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:4593 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022520AbXGLPW3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 16:22:29 +0100
Received: from localhost (p7217-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9A13BB653; Fri, 13 Jul 2007 00:22:23 +0900 (JST)
Date:	Fri, 13 Jul 2007 00:23:18 +0900 (JST)
Message-Id: <20070713.002318.41198921.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Workaround for a sparse warning in include/asm-mips/io.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0707121541190.3029@blysk.ds.pg.gda.pl>
References: <S20022480AbXGLO2a/20070712142830Z+14663@ftp.linux-mips.org>
	<Pine.LNX.4.64N.0707121541190.3029@blysk.ds.pg.gda.pl>
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
X-archive-position: 15735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 12 Jul 2007 15:47:04 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > CKSEG1ADDR() returns unsigned int value on 32bit kernel.  Cast it to
> 
>  This is not true.  With a 32-bit kernel CKSEG1ADDR(), quite 
> intentionally, returns a *signed* int.

Yes, the comment was wrong.  Thanks.

>  Since you have decided to fix the symptom rather than the bug I would at 
> least suggest to cast the result to "long" first and only then drop the 
> signedness.  Otherwise it looks misleading to a casual reader.

OK, I added cast to "long", and a comment to why the cast was
introduced.


Subject: [MIPS] Workaround for a sparse warning in include/asm-mips/io.h (part 2)

Since CKSEG1ADDR() returns "signed int" (on 32bit), cast it to "long"
first to avoid misleading.  Also add a comment why the cast to
"unsigned long" was introduced.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 7ba9289..ad60863 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -212,8 +212,9 @@ static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
 		 */
 		if (__IS_LOW512(phys_addr) && __IS_LOW512(last_addr) &&
 		    flags == _CACHE_UNCACHED)
+			/* The cast to unsigned long makes sparse happy */
 			return (void __iomem *)
-				(unsigned long)CKSEG1ADDR(phys_addr);
+				(unsigned long)(long)CKSEG1ADDR(phys_addr);
 	}
 
 	return __ioremap(offset, size, flags);
