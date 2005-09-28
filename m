Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 16:11:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:13794 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133591AbVI1PLZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2005 16:11:25 +0100
Received: from localhost (p3123-ipad11funabasi.chiba.ocn.ne.jp [219.162.38.123])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2CFAC951D; Thu, 29 Sep 2005 00:11:21 +0900 (JST)
Date:	Thu, 29 Sep 2005 00:09:59 +0900 (JST)
Message-Id: <20050929.000959.59464701.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: missing data cache flush for signal trampoline on fork
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050928.203429.02302175.nemoto@toshiba-tops.co.jp>
References: <20050928.203429.02302175.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 9065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 28 Sep 2005 20:34:29 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> 5. Then flush_cache_page() is called for the stack page, but it
anemo> uses user virtual address and Hit_Invalidate_Writeback_D.  This
anemo> does not flush the cache written by copy_user_page().

This was somewhat wrong.  The flush_cache_page() would flush old data
on the page allocated for the stack.  Anyway this does not flush the
cache written by copy_user_page() because new PTE is not established
yet.

---
Atsushi Nemoto
