Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2008 19:40:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:24732 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20045965AbYF1SkW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Jun 2008 19:40:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5SIdHoK004677;
	Sat, 28 Jun 2008 20:39:42 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5SIdEFF004658;
	Sat, 28 Jun 2008 20:39:14 +0200
Date:	Sat, 28 Jun 2008 20:39:14 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] cevt-txx9: Reset timer counter on initialize
Message-ID: <20080628183913.GC20127@linux-mips.org>
References: <20080624.232638.93018712.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080624.232638.93018712.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 24, 2008 at 11:26:38PM +0900, Atsushi Nemoto wrote:

> The txx9_tmr_init() will not clear a timer counter register on certain
> case.  The counter register is cleared on 1->0 transition of TCE bit
> if CRE=1.  So just clearing TCE bit is not enough.

Applied.  Thanks, Atsushi-San!

  Ralf
