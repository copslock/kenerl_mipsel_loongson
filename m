Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 12:01:07 +0000 (GMT)
Received: from mow300.po.2iij.net ([210.128.50.200]:23489 "EHLO
	mow.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S21103643AbZA2MBF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Jan 2009 12:01:05 +0000
Received: by mow.po.2iij.net (mow300) id n0TC0xJU002642; Thu, 29 Jan 2009 21:00:59 +0900
Received: from stratos.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox305) id n0TC0uaB007442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 29 Jan 2009 21:00:57 +0900
Date:	Thu, 29 Jan 2009 21:00:56 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add return value check to
 user_termio_to_kernel_termios()
Message-Id: <20090129210056.2cffe53e.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20090128134007.GA29709@linux-mips.org>
References: <20090125224557.8582051b.yoichi_yuasa@tripeaks.co.jp>
	<20090128124047.GA25706@linux-mips.org>
	<20090128134007.GA29709@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 28 Jan 2009 13:40:07 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Jan 28, 2009 at 12:40:47PM +0000, Ralf Baechle wrote:
> 
> > Duh...  That sort of trivial thing is not fatal but just shouldn't
> > happen.  And other architectures have the same bug even.  Your patch
> > leaves the last get_user and the copy_from_user return values unchecked.
> > I'll sort that out.
> 
> How about this patch which also gets rid of the rest of the macro soup
> by replacing them with inline functions.
> 
> How about this?

It's good for me.

Yoichi
