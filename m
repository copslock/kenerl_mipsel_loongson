Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 16:47:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43735 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133655AbWHAPrV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Aug 2006 16:47:21 +0100
Received: from localhost (p2112-ipad209funabasi.chiba.ocn.ne.jp [58.88.113.112])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 83DA0A073; Wed,  2 Aug 2006 00:47:15 +0900 (JST)
Date:	Wed, 02 Aug 2006 00:48:48 +0900 (JST)
Message-Id: <20060802.004848.97296551.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1154424439969-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
	<1154424439969-git-send-email-vagabon.xyz@gmail.com>
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
X-archive-position: 12151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue,  1 Aug 2006 11:27:17 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Since get_frame_info() is more robust, unwind_stack() can
> returns ra value for leaf functions.

I think it is still fragile.  The get_frame_info() might misdetect
nested function as leaf.  For example, I can craft this code:

int nestfunc(int arg)
{
	if (arg)
		return 0;
	func();
	return 1;
}

	.set noreorder
nestfunc:
	beqz	a0, 1f
	 nop
	jr	ra
	 move	v0, zero
1:
	addiu	sp, sp, -24
	sw	ra, 16(sp)
	jal	func
	 nop
	lw	ra, 16(sp)
	li	v0, 1
	jr	ra
	 addiu	sp, sp, 24

(Though it seems a bit artificial, who believe gcc never do it same?)

The get_frame_info() will think this is a leaf.  With your patch,
unwind_stack() might fall into endless loop at worst (if the "func"
was leaf and an exception happened in the "func").

I think you should ensure unwind_stack() never use regs->regs[31]
elsewhere than top of the stack.

---
Atsushi Nemoto
