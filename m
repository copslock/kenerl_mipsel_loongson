Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 12:08:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46991 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022542AbXG3LIK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 12:08:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6UB89gc011787;
	Mon, 30 Jul 2007 12:08:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6UB882n011786;
	Mon, 30 Jul 2007 12:08:08 +0100
Date:	Mon, 30 Jul 2007 12:08:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dajie Tan <jiankemeng@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix rm9000 performance counter handler
Message-ID: <20070730110808.GA11436@linux-mips.org>
References: <5861a7880707300007s6269fd4ft16836a3f5dbf7028@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5861a7880707300007s6269fd4ft16836a3f5dbf7028@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 30, 2007 at 11:07:42AM +0400, Dajie Tan wrote:

> The new type of irq handler remove a parameter (struct pt_regs *),but
> someone forgot to supply it.
> 
> Signed-off-by:
> ---
> 
> diff --git a/arch/mips/oprofile/op_model_rm9000.c
> b/arch/mips/oprofile/op_model_rm9000.c

Your patch got garbled by your mailer.  See
http://www.linux-mips.org/wiki/Mailing-patches for details.

Applied manually.  Thanks,

  Ralf
