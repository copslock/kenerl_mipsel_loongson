Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 14:41:57 +0000 (GMT)
Received: from mo30.po.2iij.NET ([210.128.50.53]:19009 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027092AbXLKOlr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Dec 2007 14:41:47 +0000
Received: by mo.po.2iij.net (mo30) id lBBEeSYL091296; Tue, 11 Dec 2007 23:40:28 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox301) id lBBEeQXH005253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Dec 2007 23:40:27 +0900
Date:	Tue, 11 Dec 2007 23:40:26 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Cobalt fixes
Message-Id: <20071211234026.f3de7e7f.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071211121220.GA10870@linux-mips.org>
References: <20071211121220.GA10870@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 11 Dec 2007 12:12:20 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> Some may have been following the beginning of this thread on linux-kernel,
> see for example
> 
>   http://www.opensubscriber.com/message/linux-kernel@vger.kernel.org/8161812.html
> 
> for non-subscribers.  Linus has reverted the offending patch
> fd6e732186ab522c812ab19c2c5e5befb8ec8115 in question so now the PCI and
> I/O port code needs to be fixed up to be able to handle such a setup.
> 
> A test report of this patch which is meant to be applied on top of
> today's lmo git kernel on a Cobalt would be appreciated.

It breaks all I/O port device(LCD, tulip, VIA ata) drivers.

Yoichi
