Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 16:15:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43913 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021796AbXGFPPk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 16:15:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l66F8AEb025671;
	Fri, 6 Jul 2007 16:08:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l66F89CW025670;
	Fri, 6 Jul 2007 16:08:09 +0100
Date:	Fri, 6 Jul 2007 16:08:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1550 OSS sound driver
Message-ID: <20070706150809.GA25576@linux-mips.org>
References: <20070706144043.GA23569@linux-mips.org> <468E5A63.3050706@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468E5A63.3050706@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 06, 2007 at 07:06:11PM +0400, Sergei Shtylyov wrote:

> >Does anybody have convincing arguments why I should *NOT* delete this
> >driver?  It's sitting since ages in the lmo repositories, as an OSS
> >driver isn't in the shape to be merged upstream, so doesn't receive
> >testing by the autobuilders, I don't think I've seen any testers.
> 
>    Erm, I'm afraid you have created some confusion by this mail: actually 
>    you meant sound/oss/au1550_i2s.c (maintained only in l-m tree), and not 
> sound/oss/au1550_ac97.c (which is in mainline).

Yes I meant sound/oss/au1550_i2s.c only.

  Ralf
