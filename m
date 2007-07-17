Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 11:14:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31434 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021425AbXGQKOb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 11:14:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6HAERmc005488;
	Tue, 17 Jul 2007 11:14:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6HAEQcq005487;
	Tue, 17 Jul 2007 11:14:26 +0100
Date:	Tue, 17 Jul 2007 11:14:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>, Kumba <kumba@gentoo.org>
Subject: Re: O2 RM7000 Issues
Message-ID: <20070717101426.GA4759@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469C8600.7090208@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469C8600.7090208@niisi.msk.ru>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 17, 2007 at 01:04:00PM +0400, Sergey Rogozhkin wrote:

> Are you really sure RM7000 has this bug? Workaround mentioned above 
> breaks gcc signal frame unwinding mechanism: it search for sigcontext 
> struct at fixed offset from signal trampoline.

Sigh.  Yes, I am certain - this is information right from the CPU designers.
When I did modify the signal frame for PMC's E9000 core I knew some
software such as debuggers was likely to break, so I was careful to only
use the mechanism if absolutly necessary that is on E9000 cores.  The
problem semmed to strike rather frequently on E9000 but there had been no
reports of application crashes matching the problem's fingerprint on RM7000
so the issue felt as if it was rather theoretical on RM7000.  So I choose to
not enable the workaround for RM7000 until recently.

  Ralf
