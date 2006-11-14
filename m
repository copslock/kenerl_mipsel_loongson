Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 19:50:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45293 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038725AbWKNTuD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 19:50:03 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAEJoRNQ020227;
	Tue, 14 Nov 2006 19:50:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAEJoQuv020226;
	Tue, 14 Nov 2006 19:50:26 GMT
Date:	Tue, 14 Nov 2006 19:50:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips irq cleanups
Message-ID: <20061114195026.GA16512@linux-mips.org>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp> <20061112.010457.29576510.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112.010457.29576510.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 12, 2006 at 01:04:57AM +0900, Atsushi Nemoto wrote:

> I missed some cleanups in irq_cpu.c.  Here is a patch against the
> patch.  I can send revised whole patch if you want.

I folded it into the previous one.

  Ralf
