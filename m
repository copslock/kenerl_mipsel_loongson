Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 20:50:17 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:40523 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037729AbXCDUuO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Mar 2007 20:50:14 +0000
Received: by mo.po.2iij.net (mo31) id l24KmsMT041647; Mon, 5 Mar 2007 05:48:54 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox30) id l24Kmq2O039567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Mar 2007 05:48:53 +0900 (JST)
Date:	Mon, 5 Mar 2007 05:48:51 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix Cobalt early printk
Message-Id: <20070305054851.492386c8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070302133644.GB19957@linux-mips.org>
References: <20070302124233.6b9f2c67.yoichi_yuasa@tripeaks.co.jp>
	<20070302133644.GB19957@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Fri, 2 Mar 2007 13:36:44 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Mar 02, 2007 at 12:42:33PM +0900, Yoichi Yuasa wrote:
> 
> > This patch has fixed Cobalt early printk.
> 
> Applied.  Thanks,

It's only applied to 2.6.20-stable.
Please apply to master too.

Yoichi
