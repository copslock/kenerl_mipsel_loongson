Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2004 14:42:14 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:54736 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225547AbUE2NmA>; Sat, 29 May 2004 14:42:00 +0100
Received: from localhost (p6123-ipad203funabasi.chiba.ocn.ne.jp [222.146.85.123])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4B1BD660E; Sat, 29 May 2004 22:41:57 +0900 (JST)
Date: Sat, 29 May 2004 22:45:10 +0900 (JST)
Message-Id: <20040529.224510.59461416.anemo@mba.ocn.ne.jp>
To: jsun@mvista.com
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 preempt kernel patch
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040528105151.G20139@mvista.com>
References: <20040528.131236.112629910.nemoto@toshiba-tops.co.jp>
	<20040528105151.G20139@mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 28 May 2004 10:51:51 -0700, Jun Sun <jsun@mvista.com> said:

>> Q1.  What is purpose of this block?  (To decrease latency?  But
>> other archs (and 2.6 MIPS kernel) do not have block like this...)

jsun> This is to check possible preemption at the end of (possibly
jsun> nested) interrupt handling.

jsun> All other arches and 2.6 MIPS are doing the same thing in .S
jsun> file (something like ret_from_irq path)

Oh, I found it in 2.6 MIPS kernel.  Thank you very much.

>> Q2.  If an interrupt happened between __sti() and __cli(), and the
>> interrupt handler raise softirq, the softirq handler will not be
>> called soon (because do_softirq() immediately return if preempt
>> disabled).  So we must check softirq_pending again after this
>> block?

jsun> do_softirq() does not (and should not) return when preemtpion is
jsun> disabled.  We should be fine here.

Sorry, it was my mistake.  I was misreading the in_interrupt()
code... (&& and ||).  Thank you.

---
Atsushi Nemoto
