Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 16:21:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32651 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038748AbXBIQVV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 16:21:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l19GLKop028579;
	Fri, 9 Feb 2007 16:21:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l19GLIWw028578;
	Fri, 9 Feb 2007 16:21:18 GMT
Date:	Fri, 9 Feb 2007 16:21:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 1/3] signal: avoid useless test in do_signal()
Message-ID: <20070209162118.GA26617@linux-mips.org>
References: <1171033658561-git-send-email-fbuihuu@gmail.com> <11710336594091-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11710336594091-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 09, 2007 at 04:07:36PM +0100, Franck Bui-Huu wrote:

> -			if (test_thread_flag(TIF_RESTORE_SIGMASK))
> -				clear_thread_flag(TIF_RESTORE_SIGMASK);

This is a microoptimization.  The assumption here is TIF_RESTORE_SIGMASK
will rarely need to be cleared and atomic operations are somewhat
expensive if as in this case we have to assume the cacheline isn't
held exclusive yet.

  Ralf
