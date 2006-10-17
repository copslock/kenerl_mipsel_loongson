Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2006 12:10:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5855 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039347AbWJQLKd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Oct 2006 12:10:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9HBAorq017400;
	Tue, 17 Oct 2006 12:10:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9HBAn2w017399;
	Tue, 17 Oct 2006 12:10:49 +0100
Date:	Tue, 17 Oct 2006 12:10:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] load modules to CKSEG0 if CONFIG_BUILD_ELF64=n
Message-ID: <20061017111048.GA16664@linux-mips.org>
References: <20061016.224146.05601109.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016.224146.05601109.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 16, 2006 at 10:41:46PM +0900, Atsushi Nemoto wrote:

> This is a patch to load 64-bit modules to CKSEG0 so that can be
> compiled with -msym32 option.  This makes each module ~10% smaller.
> 
> * introduce MODULE_START and MODULE_END
> * custom module_alloc()
> * PGD for modules
> * change XTLB refill handler synthesizer
> * enable -msym32 for modules again
>   (revert ca78b1a5c6a6e70e052d3ea253828e49b5d07c8a)

Okay, put on the queue tree.

  Ralf
