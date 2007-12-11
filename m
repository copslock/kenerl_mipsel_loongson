Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 15:35:57 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47591 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029383AbXLKPfz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 15:35:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBBFZNhs001859;
	Tue, 11 Dec 2007 15:35:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBBFZMml001828;
	Tue, 11 Dec 2007 15:35:22 GMT
Date:	Tue, 11 Dec 2007 15:35:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cobalt fixes
Message-ID: <20071211153522.GB15843@linux-mips.org>
References: <20071211121220.GA10870@linux-mips.org> <20071211235001.8621bdb9.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071211235001.8621bdb9.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 11, 2007 at 11:50:01PM +0900, Yoichi Yuasa wrote:

> > for non-subscribers.  Linus has reverted the offending patch
> > fd6e732186ab522c812ab19c2c5e5befb8ec8115 in question so now the PCI and
> > I/O port code needs to be fixed up to be able to handle such a setup.
> 
> It can be fixed my fix PCI resource patch.
> 
> http://www.linux-mips.org/archives/linux-mips/2007-01/msg00049.html

Modulo a codying style issue that one is the same as the pci.c segment of
the patch I've just posted.

  Ralf
