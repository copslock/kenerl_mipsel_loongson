Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 04:44:00 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:39959
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225200AbTBNEoA>; Fri, 14 Feb 2003 04:44:00 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 14 Feb 2003 04:43:58 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 6C24BB478; Fri, 14 Feb 2003 13:43:51 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id NAA99545; Fri, 14 Feb 2003 13:43:51 +0900 (JST)
Date: Fri, 14 Feb 2003 13:48:25 +0900 (JST)
Message-Id: <20030214.134825.112283876.nemoto@toshiba-tops.co.jp>
To: jsun@mvista.com
Cc: ralf@linux-mips.org, quintela@mandrakesoft.com,
	linux-mips@linux-mips.org, nemoto@toshiba-tops.co.jp
Subject: Re: [RFC & PATCH] fixing tlb flush race problem on smp
From: Atsushi Nemoto <anemo@mba.sphere.ne.jp>
In-Reply-To: <20030204160250.F5149@mvista.com>
References: <20030127170346.S11633@mvista.com>
	<20030129090627.D7741@linux-mips.org>
	<20030204160250.F5149@mvista.com>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.sphere.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.sphere.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 4 Feb 2003 16:02:50 -0800, Jun Sun <jsun@mvista.com> said:
jsun> Here is a complete patch for both mips/mips64, 2.4 and 2.5.  Of
jsun> course only 2.4/mips combo is tested.

The attached patch seems to break r3k codes.  Here is a patch to fix
it (only for 2.4/mips).

diff -ur linux-mips-cvs/include/asm-mips/mmu_context.h linux.new/include/asm-mips/mmu_context.h
--- linux-mips-cvs/include/asm-mips/mmu_context.h	Fri Feb 14 09:41:31 2003
+++ linux.new/include/asm-mips/mmu_context.h	Fri Feb 14 13:40:24 2003
@@ -151,7 +151,7 @@
 
 	if (test_bit(cpu, &mm->cpu_vm_mask))  {
 		get_new_mmu_context(mm, cpu);
-		write_c0_entryhi(cpu_context(cpu, mm) & 0xff);
+		write_c0_entryhi(cpu_context(cpu, mm) & ASID_MASK);
 	} else {
 		/* will get a new context next time */
 		cpu_context(cpu, mm) = 0;
---
Atsushi Nemoto
