Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 00:37:58 +0000 (GMT)
Received: from mo30.po.2iij.NET ([210.128.50.53]:59212 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573947AbXLJAht (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Dec 2007 00:37:49 +0000
Received: by mo.po.2iij.net (mo30) id lBA0aTto015256; Mon, 10 Dec 2007 09:36:29 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id lBA0aRWD016476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Dec 2007 09:36:27 +0900
Message-Id: <200712100036.lBA0aRWD016476@po-mbox303.hop.2iij.net>
Date:	Mon, 10 Dec 2007 09:36:27 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] set up Cobalt's mips_hpt_frequency
In-Reply-To: <20071209191039.GB32724@linux-mips.org>
References: <20071209212204.5e50a697.yoichi_yuasa@tripeaks.co.jp>
	<20071209191039.GB32724@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Sun, 9 Dec 2007 19:10:39 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sun, Dec 09, 2007 at 09:22:04PM +0900, Yoichi Yuasa wrote:
> 
> > Set up Cobalt's mips_hpt_frequency.
> 
> Queue for 2.6.25.  Thanks,

Cobalt cannot boot as this patch doesn't exist.
Please apply 2.6.24-rc too.

Thanks,

Yoichi
