Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 09:38:39 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:33306
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224954AbVBDJiU>; Fri, 4 Feb 2005 09:38:20 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Feb 2005 09:38:18 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 1252A239E5B; Fri,  4 Feb 2005 18:38:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j149cDRm035923;
	Fri, 4 Feb 2005 18:38:13 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 04 Feb 2005 18:38:13 +0900 (JST)
Message-Id: <20050204.183813.132760959.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: dcache aliasing problem on fork
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 7144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

There is a dcache aliasing problem on preempt kernel (or SMP kernel,
perhaps) when a multi-threaded program calls fork().

1. Now there is a process containing two thread (T1 and T2).  The
   thread T1 call fork().  dup_mmap() function called on T1 context.

static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
{
	...
	flush_cache_mm(current->mm);
	/* A */
	...
	(write-protect all Copy-On-Write pages)
	...
	/* B */
	flush_tlb_mm(current->mm);
	...
}

2. When preemption happens between A and B (or on SMP kernel), the
   thread T2 can run and modify data on COW pages without page fault
   (modified data will stay in cache).

3. Some time after fork() completed, the thread T2 may cause page
   fault by write-protect on COW pages .

4. Then data of the COW page will be copied to newly allocated
   physical page (copy_cow_page()).  It reads data via kernel mapping.
   The kernel mapping can have different 'color' with user space
   mapping of the thread T2 (dcache aliasing).  Therefore
   copy_cow_page() will copy stale data.  Then the modified data in
   cache will be lost.


How should we fix this problem?  Any idea?

---
Atsushi Nemoto
