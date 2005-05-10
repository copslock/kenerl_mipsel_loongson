Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2005 16:04:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:53988 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8226704AbVEJPEW>; Tue, 10 May 2005 16:04:22 +0100
Received: from localhost (p6003-ipad11funabasi.chiba.ocn.ne.jp [219.162.41.3])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B479587AF; Wed, 11 May 2005 00:04:18 +0900 (JST)
Date:	Wed, 11 May 2005 00:06:20 +0900 (JST)
Message-Id: <20050511.000620.25910671.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: fpu, preempt, ptrace
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050510.121038.111209401.nemoto@toshiba-tops.co.jp>
References: <20050510.121038.111209401.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 7901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 10 May 2005 12:10:38 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> For now, get_fpu_regs() is used in ptrace code only and the
anemo> condition 'tsk == current' should always be false.  So we can
anemo> just remove _save_fp() call instead of disabling preemption.

The get_fpu_regs() fix was insufficient.  The caller of the function
should disable preemption.  And while the caller (sys_ptrace) never
pass 'current' to the function, it should be preempt-safe anyway.
Please ignore that part of my patch.

---
Atsushi Nemoto
