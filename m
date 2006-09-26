Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 15:59:20 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:20699 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037747AbWIZO7Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 15:59:16 +0100
Received: from localhost (p5240-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6881FAD0F; Tue, 26 Sep 2006 23:59:13 +0900 (JST)
Date:	Wed, 27 Sep 2006 00:01:21 +0900 (JST)
Message-Id: <20060927.000121.63741710.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH 1/3] [MIPS] lockdep: fix TRACE_IRQFLAGS_SUPPORT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060926.234340.07643315.anemo@mba.ocn.ne.jp>
References: <20060926.234340.07643315.anemo@mba.ocn.ne.jp>
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
X-archive-position: 12678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Sep 2006 23:43:40 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> In handle_sys and its variants, we must reload some registers which
> might be clobbered by trace_hardirqs_on().
> Also we must make sure trace_hardirqs_on() called in kernel level (not
> exception level).

And there is one more suspicious code in arch/mips/kernel/entry.S:

FEXPORT(restore_partial)		# restore partial frame
#ifdef CONFIG_TRACE_IRQFLAGS
	SAVE_STATIC
	SAVE_AT
	SAVE_TEMP
	LONG_L	v0, PT_STATUS(sp)
	and	v0, 1
	beqz	v0, 1f
	jal	trace_hardirqs_on
	b	2f
1:	jal	trace_hardirqs_off
2:
	RESTORE_TEMP
	RESTORE_AT
	RESTORE_STATIC
#endif
	RESTORE_SOME
	RESTORE_SP_AND_RET
	.set	at

Is this correct if CONFIG_MIPS_MT_SMTC enabled?

---
Atsushi Nemoto
