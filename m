Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 23:20:58 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:40481 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021569AbXJKWUs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2007 23:20:48 +0100
Received: by mo.po.2iij.net (mo32) id l9BMJS77073630; Fri, 12 Oct 2007 07:19:28 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox301) id l9BMJOrO031829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Oct 2007 07:19:24 +0900
Date:	Fri, 12 Oct 2007 07:19:23 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add select I8253 to MIPS Atlas
Message-Id: <20071012071923.4cf42454.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071011160249.GA15003@linux-mips.org>
References: <20071011225647.1ac5ed27.yoichi_yuasa@tripeaks.co.jp>
	<20071011160249.GA15003@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 11 Oct 2007 17:02:49 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Thu, Oct 11, 2007 at 10:56:47PM +0900, Yoichi Yuasa wrote:
> 
> > Add "select I8253" to MIPS Atlas
> 
> Nope, actually the Atlas doesn't have a PIT - nor does SEAD.  I just
> fixed that.
OK

Thanks

Yoichi
