Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 18:10:02 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:47309 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22306615AbYJXRJx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 18:09:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9OH9pM0027417;
	Fri, 24 Oct 2008 18:09:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9OH9oED027415;
	Fri, 24 Oct 2008 18:09:50 +0100
Date:	Fri, 24 Oct 2008 18:09:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix kgdb build error
Message-ID: <20081024170950.GC25297@linux-mips.org>
References: <20081025001725.7ac18a1b.yoichi_yuasa@tripeaks.co.jp> <4901F851.8010103@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4901F851.8010103@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 24, 2008 at 09:31:13AM -0700, David Daney wrote:

> Yoichi Yuasa wrote:
>> ptrace.h needs #include <linux/types.h>
>>
> [...]
>
> Can you try this completely untested patch instead?
>
> If it works, I will give it a more thorough test over the next few
> weeks.

This looks correct, I think.

Though I was wondering about two special cases:

  o 32-bit debugger debugging a 64-bit process
  o 64-bit debugger debugging a 32-bit process

The unions make we wonder if that case was considered ...

Anyway, your patch certainly solves Yoichi's original bug so I'll apply it.

  Ralf
