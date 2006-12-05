Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 16:52:58 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37092 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039028AbWLEQw4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Dec 2006 16:52:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB5GqsXV017441;
	Tue, 5 Dec 2006 16:52:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB5Gqrvf017440;
	Tue, 5 Dec 2006 16:52:53 GMT
Date:	Tue, 5 Dec 2006 16:52:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061205165253.GA17390@linux-mips.org>
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp> <4575A364.1010703@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4575A364.1010703@innova-card.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 05, 2006 at 05:50:44PM +0100, Franck Bui-Huu wrote:

> Atsushi Nemoto wrote:
> > Import many updates from i386's i8259.c, especially genirq
> > transitions.
> > 
> 
> Does your patch make the following patch out of date (I sent
> it to the list 4 days ago) ?
> 
> [PATCH] Compile __do_IRQ() when really needed [take #3]

I believe it will need an update.

  Ralf
