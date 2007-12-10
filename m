Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 13:15:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14283 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024481AbXLJNPU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 13:15:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBADF4Tf012145;
	Mon, 10 Dec 2007 13:15:04 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBADF2eT012137;
	Mon, 10 Dec 2007 13:15:02 GMT
Date:	Mon, 10 Dec 2007 13:15:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] set up Cobalt's mips_hpt_frequency
Message-ID: <20071210131502.GA11886@linux-mips.org>
References: <20071209212204.5e50a697.yoichi_yuasa@tripeaks.co.jp> <20071209191039.GB32724@linux-mips.org> <200712100036.lBA0aRWD016476@po-mbox303.hop.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712100036.lBA0aRWD016476@po-mbox303.hop.2iij.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 10, 2007 at 09:36:27AM +0900, Yoichi Yuasa wrote:

> > On Sun, Dec 09, 2007 at 09:22:04PM +0900, Yoichi Yuasa wrote:
> > 
> > > Set up Cobalt's mips_hpt_frequency.
> > 
> > Queue for 2.6.25.  Thanks,
> 
> Cobalt cannot boot as this patch doesn't exist.
> Please apply 2.6.24-rc too.

Ah, sorry.  Applied.

  Ralf
