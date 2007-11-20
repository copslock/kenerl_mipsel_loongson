Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 18:16:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:23455 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021314AbXKTSQU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 18:16:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAKIGJwi018065;
	Tue, 20 Nov 2007 18:16:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAKIGJoW018064;
	Tue, 20 Nov 2007 18:16:19 GMT
Date:	Tue, 20 Nov 2007 18:16:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: futex_wake_op deadlock?
Message-ID: <20071120181619.GA17979@linux-mips.org>
References: <20071120112051.GB30675@linux-mips.org> <DDFD17CC94A9BD49A82147DDF7D545C54DCF9F@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C54DCF9F@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 20, 2007 at 10:06:44AM -0800, Kaz Kylheku wrote:

> The problem is I didn't pay enough attention because I didn't suspect it
> enough.
> 
> I was misled by the backtrace address in the soft lockup dump, which
> points to one instruction /before/ the ll instruction. So I thought that
> the lockup is somewhere outside of that loop, right?
> 
> Does the backward branch on MIPS set up the instruction pointer in such
> a way that if an interrupt goes off, it can be pointing to the previous
> instruction? I thought about that possibility.

The EPC will always point to the instruction which caused the exception
with the one special case where an instruction in a branch delay slot
was causing the exception.  If that's the case the EPC will point at the
branch and the BD bit in the cause register (bit 31) will be set to
indicate this special case.

  Ralf
