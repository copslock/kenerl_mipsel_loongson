Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 10:55:15 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:18960 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133594AbWBTKy1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 10:54:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KB1Gwb005775;
	Mon, 20 Feb 2006 11:01:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1JGUTYr021561;
	Sun, 19 Feb 2006 16:30:29 GMT
Date:	Sun, 19 Feb 2006 16:30:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] signal cleanup
Message-ID: <20060219163029.GA21416@linux-mips.org>
References: <20060219.234644.108739570.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219.234644.108739570.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 19, 2006 at 11:46:44PM +0900, Atsushi Nemoto wrote:

> Move function prototypes to asm/signal.h to detect trivial errors and
> add some __user tags to get rid of sparse warnings.  Output code
> should not be changed.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Queued for 2.6.17.

  Ralf
