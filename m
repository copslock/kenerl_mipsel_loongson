Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2006 04:35:27 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:44608 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027677AbWIADfZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Sep 2006 04:35:25 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 1 Sep 2006 12:35:23 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 243C7204AD;
	Fri,  1 Sep 2006 12:35:19 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 188BF1FF0A;
	Fri,  1 Sep 2006 12:35:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k813ZGW0053279;
	Fri, 1 Sep 2006 12:35:18 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 01 Sep 2006 12:35:16 +0900 (JST)
Message-Id: <20060901.123516.21957726.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, nigel@mips.com
Subject: Re: [MIPS] Fix COW D-cache aliasing on fork
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20037621AbWHaUco/20060831203244Z+5697@ftp.linux-mips.org>
References: <S20037621AbWHaUco/20060831203244Z+5697@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 31 Aug 2006 21:32:39 +0100, linux-mips@linux-mips.org wrote:
> Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp> Thu Aug 24 00:31:30 2006 +0900
> Comitter: Ralf Baechle <ralf@linux-mips.org> Thu Aug 31 19:50:02 2006 +0100
> Commit: b895b66990f22a8a030c41390c538660a02bb97f
> Gitweb: http://www.linux-mips.org/g/linux/b895b669
> Branch: master

Thanks!!!

And please commit this fix too.


The tlbidx variable should be signed int so that "tlbidx < 0"
comparison works correctly.  Nigel Stephens <nigel@mips.com> pointed
this out.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 2cfdc0b..bbc9458 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -136,7 +136,7 @@ static inline void *kmap_coherent(struct
 	unsigned long vaddr, flags, entrylo;
 	unsigned long old_ctx;
 	pte_t pte;
-	unsigned int tlbidx;
+	int tlbidx;
 
 	inc_preempt_count();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
