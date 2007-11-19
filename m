Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2007 18:48:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61155 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20033904AbXKSSsj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Nov 2007 18:48:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAJImcbF014446;
	Mon, 19 Nov 2007 18:48:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAJImbnH014445;
	Mon, 19 Nov 2007 18:48:37 GMT
Date:	Mon, 19 Nov 2007 18:48:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: futex_wake_op deadlock?
Message-ID: <20071119184837.GA12287@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C54DCBD2@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C54DCBD2@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 16, 2007 at 03:52:47PM -0800, Kaz Kylheku wrote:

> From time to time, on 2.6.17.7, I see a deadlock situation go off. The
> soft lockup tick occurs in the middle of do_futex, which is heavily
> inlined.  The system is actually hosed; it's not one of those
> recoverable CPU busy situations that can sometimes trigger the lockup
> detector.

Can you reproduce thing hang also if you're not running in a binary compat
mode, that is either running o32 binaries on a 32-bit kernel or 64-bit
binaries on a 64-bit kernel?

  Ralf
