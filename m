Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 14:39:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:35792 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225983AbVD2NjG>; Fri, 29 Apr 2005 14:39:06 +0100
Received: from localhost (p8173-ipad25funabasi.chiba.ocn.ne.jp [220.104.86.173])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4F1D48441; Fri, 29 Apr 2005 22:39:03 +0900 (JST)
Date:	Fri, 29 Apr 2005 22:40:24 +0900 (JST)
Message-Id: <20050429.224024.25908909.anemo@mba.ocn.ne.jp>
To:	kevink@mips.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: preempt safe fpu-emulator
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <004e01c54c0c$4c9f3d30$10eca8c0@grendel>
References: <002d01c54bfa$5b913f80$0deca8c0@Ulysses>
	<20050428152123.GH1276@linux-mips.org>
	<004e01c54c0c$4c9f3d30$10eca8c0@grendel>
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
X-archive-position: 7837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 28 Apr 2005 18:06:53 +0200, "Kevin D. Kissell" <kevink@mips.com> said:

kevink> The global variable thing was clearly not SMP safe - but then
kevink> again, the 32-bit MIPS kernel we were working with wasn't SMP
kevink> safe either, in those days.  ;o)

Also, IIRC, old FPU ownership management ("lazy fpu switch") was
somewhat broken (or fragile at least) in those days.  The current code
is more robust (and simple, I suppose).

kevink> But *if* - and it may not really (or no longer) be the case -
kevink> there is an implicit assumption that some FCSR state is
kevink> preserved on a context switch, it would be more correct to map
kevink> the ieee754_csr symbol to a per-CPU variable than a per-thread
kevink> variable.

Thanks for your advise.  I believe there is not a such assumption now.
Any newly created process always start with CP1 disabled, and on the
first CP1 unusable exception FCSR will be initialized to 0.

---
Atsushi Nemoto
