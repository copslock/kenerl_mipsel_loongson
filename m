Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 11:49:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42455 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022400AbXEKKtK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 11:49:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4BAn5jh003208;
	Fri, 11 May 2007 11:49:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4BAn4Vp003207;
	Fri, 11 May 2007 11:49:04 +0100
Date:	Fri, 11 May 2007 11:49:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Message-ID: <20070511104904.GE2732@linux-mips.org>
References: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 11, 2007 at 01:02:34AM +0900, Atsushi Nemoto wrote:

> On 64-bit MIPS, only N64 ABI is checked by default.  This patch adds
> some rules for other ABIs.  This results in these warnings at the
> moment:

These warnings are definately valuable so I applied your patch.  Some of
the warnings are a little useless though, for example the ones about the
uselib syscall.

  Ralf
