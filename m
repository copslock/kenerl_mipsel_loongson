Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 18:09:57 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8876 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038714AbXB0SJ4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Feb 2007 18:09:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1RI9mAQ010802;
	Tue, 27 Feb 2007 18:09:50 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1RI9kDS010801;
	Tue, 27 Feb 2007 18:09:46 GMT
Date:	Tue, 27 Feb 2007 18:09:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH] jmr3927: do not call tc35815_killall()
Message-ID: <20070227180946.GB7337@linux-mips.org>
References: <20070228.014153.71085781.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070228.014153.71085781.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 28, 2007 at 01:41:53AM +0900, Atsushi Nemoto wrote:

> No need to stop tc35815 before resetting the board.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Excellent, I did suspect this violation of abstraction wasn't actually
needed.  I'm committing a patch which also kills tc35815_killall().

  Ralf
