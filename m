Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 15:11:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7902 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023673AbXGMOLb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jul 2007 15:11:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6DEBUJK006382;
	Fri, 13 Jul 2007 15:11:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6DEBT3f006379;
	Fri, 13 Jul 2007 15:11:29 +0100
Date:	Fri, 13 Jul 2007 15:11:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] math-emu minor cleanup
Message-ID: <20070713141129.GA6366@linux-mips.org>
References: <20070713.230229.93204964.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070713.230229.93204964.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 13, 2007 at 11:02:29PM +0900, Atsushi Nemoto wrote:

> Declaring emulpc and contpc as "unsigned long" can get rid of some
> casts.  This also get rid of some sparse warnings.

Applied.  Thanks,

  Ralf
