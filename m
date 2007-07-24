Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 15:40:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34750 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023029AbXGXOkz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jul 2007 15:40:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6OEeq8F019022;
	Tue, 24 Jul 2007 15:40:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6OEepo1019021;
	Tue, 24 Jul 2007 15:40:51 +0100
Date:	Tue, 24 Jul 2007 15:40:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dajie Tan <jiankemeng@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>, phil.el@wanadoo.fr,
	levon@movementarian.org, oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] Add support for profiling Loongson 2E
Message-ID: <20070724144051.GA17256@linux-mips.org>
References: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 24, 2007 at 01:20:27PM +0400, Dajie Tan wrote:

> This patch adds support for profiling Loongson 2E. It's been tested on
> FuLong mini PC(loongson2e inside).

First of all, your patch has been garbled when mailing.


[.. Lots of arch/mips code deleted ...]

No complaints upto this point.  But:

> diff -urN b/drivers/oprofile/cpu_buffer.c a/drivers/oprofile/cpu_buffer.c
> --- b/drivers/oprofile/cpu_buffer.c	2007-07-24 13:00:54.000000000 +0800
> +++ a/drivers/oprofile/cpu_buffer.c	2007-07-19 08:22:15.000000000 +0800
> @@ -148,6 +148,10 @@
>            unsigned long pc, unsigned long event)
> {
> 	struct op_sample * entry = &cpu_buf->buffer[cpu_buf->head_pos];
> +
> +	if(!entry)
> +		return;
> +
> 	entry->eip = pc;
> 	entry->event = event;
> 	increment_head(cpu_buf);

Why do you need this change?  It almost looks as if you're papering over
a bug where add_sample should not be called at all.

  Ralf
