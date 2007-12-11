Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 14:50:14 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:38938 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20029252AbXLKOuG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Dec 2007 14:50:06 +0000
Received: by mo.po.2iij.net (mo32) id lBBEo3eZ018373; Tue, 11 Dec 2007 23:50:03 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id lBBEo1eY012889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Dec 2007 23:50:01 +0900
Date:	Tue, 11 Dec 2007 23:50:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Cobalt fixes
Message-Id: <20071211235001.8621bdb9.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 17773
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

It can be fixed my fix PCI resource patch.

http://www.linux-mips.org/archives/linux-mips/2007-01/msg00049.html

Yoichi
