Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2004 16:26:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:20701 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225281AbUJXP0n>; Sun, 24 Oct 2004 16:26:43 +0100
Received: from localhost (p4005-ipad02funabasi.chiba.ocn.ne.jp [61.207.151.5])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ADE5583D5; Mon, 25 Oct 2004 00:26:39 +0900 (JST)
Date: Mon, 25 Oct 2004 00:28:50 +0900 (JST)
Message-Id: <20041025.002850.74755987.anemo@mba.ocn.ne.jp>
To: mlachwani@mvista.com
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH]Preemption patch for 2.6
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1098468403.4266.42.camel@prometheus.mvista.com>
References: <1098468403.4266.42.camel@prometheus.mvista.com>
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
X-archive-position: 6193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On 22 Oct 2004 11:06:43 -0700, Manish Lachwani <mlachwani@mvista.com> said:

mlachwani> The attached patch incorporates preemption enable/disable
mlachwani> in some parts of the kernel. I have tested this on the
mlachwani> Broadcom Sibyte. Please review ...

1. You add preempt_disable/preempt_enable to c-sb1.c and tlb-sb1.c.
   Those are SB1 specific issue?  If not, please fix other c-*.c and
   tlb-*.c same way.

2. fpu_emulator_cop1Handler and save/restore_fp_context contain
   calling of get_user/put_user which is not allowed during preempt
   disabled.  (But it might be a kernel bug.  Please refer recent
   discussion on this ML)  I will post revised patch again.

Anyway, thanks for your fixes.

---
Atsushi Nemoto
