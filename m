Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 10:03:28 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:4636
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225409AbTIRJDZ>; Thu, 18 Sep 2003 10:03:25 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 18 Sep 2003 09:03:23 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h8I93Cgc076416;
	Thu, 18 Sep 2003 18:03:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 18 Sep 2003 18:05:36 +0900 (JST)
Message-Id: <20030918.180536.08320519.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, macro@linux-mips.org
Subject: mips64 cpu-probe.c compile failure
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030916151302Z8225419-1272+5508@linux-mips.org>
References: <20030916151302Z8225419-1272+5508@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 16 Sep 2003 16:12:57 +0100, macro@linux-mips.org said:
macro> Modified files:
macro> 	arch/mips64/kernel: Tag: linux_2_4 cpu-probe.c 

macro> Log message:
macro> 	Fix indeterminism in the multiply/shift erratum detection leading
macro> 	to false negatives.  Plus a few minor comment updates for clarity.

gcc 3.3.1 can not compile current (2.4) arch/mips64/kernel/cpu-probe.c.

cpu-probe.c:118: warning: asm operand 0 probably doesn't match constraints
cpu-probe.c:118: warning: asm operand 1 probably doesn't match constraints
...
cpu-probe.c: In function `check_mult_sh':
cpu-probe.c:118: error: impossible constraint in `asm'

The code is:

static inline void align_mod(int align, int mod)
{
	asm volatile(
		".set	push\n\t"
		".set	noreorder\n\t"
		".balign %0\n\t"
		".rept	%1\n\t"
		"nop\n\t"
		".endr\n\t"
		".set	pop"
		:
		: "i" (align), "i" (mod));
}

The align_mod() and mult_sh_align_mod() should be written as macro?

---
Atsushi Nemoto
