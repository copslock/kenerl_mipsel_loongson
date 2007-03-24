Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 17:11:58 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:48126 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022769AbXCXRLb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2007 17:11:31 +0000
Received: from localhost (p2115-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.115])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A8D33AF80; Sun, 25 Mar 2007 02:10:10 +0900 (JST)
Date:	Sun, 25 Mar 2007 02:10:10 +0900 (JST)
Message-Id: <20070325.021010.126581514.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Implement flush_anon_page().
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070324162721.GA12117@linux-mips.org>
References: <S20022532AbXCWXgp/20070323233645Z+1432@ftp.linux-mips.org>
	<20070325.001433.108739347.anemo@mba.ocn.ne.jp>
	<20070324162721.GA12117@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 24 Mar 2007 16:27:21 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> Sometimes sparse is a PITA ...   Applied.

Thanks.  And one more.  Fix kunmap_coherent() usage.  Or is it a time
to kill the unused argument of kunmap_coherent()?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 4e8f1b6..70ccc5d 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -96,7 +96,7 @@ void __flush_anon_page(struct page *page
 
 		kaddr = kmap_coherent(page, vmaddr);
 		flush_data_cache_page((unsigned long)kaddr);
-		kunmap_coherent(kaddr);
+		kunmap_coherent(page);
 	}
 }
 
