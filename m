Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 18:16:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:42122 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022967AbXJ2SQ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 18:16:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TIGo3r011622;
	Mon, 29 Oct 2007 18:16:50 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TIGcAr011620;
	Mon, 29 Oct 2007 18:16:38 GMT
Date:	Mon, 29 Oct 2007 18:16:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove unused mips_machtype
Message-ID: <20071029181638.GA11614@linux-mips.org>
References: <20071026224231.1aaddf3e.yoichi_yuasa@tripeaks.co.jp> <20071028191906.GA7661@linux-mips.org> <200710282311.l9SNBZ7S005135@po-mbox302.po.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200710282311.l9SNBZ7S005135@po-mbox302.po.2iij.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 29, 2007 at 08:11:35AM +0900, Yoichi Yuasa wrote:

> > > Removed unused mips_machtype.
> > > These are only set though are not used.
> > 
> > I'm getting a large number of rejects on this patch.
> 
> Really? I have no problem to applly it on current git.

Hmm...  Guess my patch-o-matic jammed.  Just retried and applies perfectly.
Sorry.

Patch queued for 2.6.25 & thanks,

  Ralf
