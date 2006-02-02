Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 16:59:58 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52729 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3465642AbWBBQ7k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 16:59:40 +0000
Received: from localhost (p4005-ipad24funabasi.chiba.ocn.ne.jp [220.104.82.5])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A951AB4A8; Fri,  3 Feb 2006 02:04:48 +0900 (JST)
Date:	Fri, 03 Feb 2006 02:04:28 +0900 (JST)
Message-Id: <20060203.020428.59032357.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060202165656.GC17352@linux-mips.org>
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl>
	<20060202165656.GC17352@linux-mips.org>
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
X-archive-position: 10310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 2 Feb 2006 16:56:56 +0000, Ralf Baechle <ralf@linux-mips.org> said:

>> Hmm, wouldn't that "nop" alternative be simpler?

ralf> Simpler maybe - but this variant has zero runtime overhead.

Yes.  I do not want do add extra cycles.

However, It can be more readable since we can safely mask bit[5:1] (as
local_irq_enable() does).  Like this:

__asm__ (
	"	.macro	local_irq_disable\n"
	"	.set	push						\n"
	"	.set	noat						\n"
#ifdef CONFIG_CPU_MIPSR2
	"	di							\n"
#else
	"	mfc0	$1,$12						\n"
	"	ori	$1,0x1f						\n"
	"	xori	$1,0x1f						\n"
	"	.set	noreorder					\n"
	"	mtc0	$1,$12						\n"
#endif
	"	irq_disable_hazard					\n"
	"	.set	pop						\n"
	"	.endm							\n");


Is this preferred?  We can get rid of all TX49XX_MFC0_WAR on this way.

---
Atsushi Nemoto
