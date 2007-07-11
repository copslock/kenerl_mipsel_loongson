Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 10:59:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42431 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022955AbXGKJ7U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 10:59:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6B9iOeT014070;
	Wed, 11 Jul 2007 10:44:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6B7aJvW005150;
	Wed, 11 Jul 2007 08:36:19 +0100
Date:	Wed, 11 Jul 2007 08:36:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	pwatkins@sicortex.com, linux-mips@linux-mips.org, From:
Subject: Re: [PATCH] [MIPS] Fix resume for 64K page size
Message-ID: <20070711073619.GA4056@linux-mips.org>
References: <11840880513393-git-send-email-pwatkins@sicortex.com> <20070710173454.GA30521@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070710173454.GA30521@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 10, 2007 at 06:34:54PM +0100, Thiemo Seufer wrote:

> > -#if (_THREAD_SIZE - 32) < 0x10000
> > +#if (_THREAD_SIZE) < 0x10000
> >  	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
> >  #else
> >  	PTR_LI		t0, _THREAD_SIZE - 32
> 
> This doesn't look right. I think it should be
> 
> #if (_THREAD_SIZE - 32) < 0x8000
> 
> in order to avoid an overflow of the immediate.

Indeed - that's the limitation of the (d)addiu instruction.  But (d)addu
instead handle large constants just fine, so I'd below patch instead.  So
why not let the assembler do the dirty work.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 65f0f91..d9bfae5 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -85,12 +85,7 @@
 	move	$28, a2
 	cpu_restore_nonscratch a1
 
-#if (_THREAD_SIZE) < 0x10000
-	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
-#else
-	PTR_LI		t0, _THREAD_SIZE - 32
-	PTR_ADDU	t0, $28
-#endif
+	PTR_ADDU	t0, $28, _THREAD_SIZE - 32
 	set_saved_sp	t0, t1, t2
 #ifdef CONFIG_MIPS_MT_SMTC
 	/* Read-modify-writes of Status must be atomic on a VPE */
