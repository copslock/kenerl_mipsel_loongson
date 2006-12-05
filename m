Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 19:57:05 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37052 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037733AbWLET5E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Dec 2006 19:57:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB5Jv3Uo002129;
	Tue, 5 Dec 2006 19:57:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB5Jv2n5002128;
	Tue, 5 Dec 2006 19:57:02 GMT
Date:	Tue, 5 Dec 2006 19:57:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061205195702.GA2097@linux-mips.org>
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp> <20061205194907.GA1088@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205194907.GA1088@linux-mips.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 05, 2006 at 07:49:07PM +0000, Ralf Baechle wrote:

> > Import many updates from i386's i8259.c, especially genirq
> > transitions.
> 
> With this patch applied Malta fails ...

Which meant I removed this patch from my tree for now.  Which means nothing
is blocking Franck's patch anymore so I applied it with a trivial build fix
to irq_cpu.c.

  Ralf
