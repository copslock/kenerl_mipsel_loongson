Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 08:38:47 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:1577 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038812AbWKBIip (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2006 08:38:45 +0000
Received: by mo.po.2iij.net (mo32) id kA28cggn034290; Thu, 2 Nov 2006 17:38:42 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id kA28cfOx049462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Nov 2006 17:38:41 +0900 (JST)
Date:	Thu, 2 Nov 2006 17:38:41 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	anemo@mba.ocn.ne.jp
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] mips irq cleanups
Message-Id: <20061102173841.7af31765.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061101184755.GC4736@linux-mips.org>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
	<20061101184755.GC4736@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Wed, 1 Nov 2006 18:47:55 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Thu, Nov 02, 2006 at 02:08:36AM +0900, Atsushi Nemoto wrote:
> 
> > This is a big irq cleanup patch.
> 
> >  37 files changed, 289 insertions(+), 1647 deletions(-)
> 
> Very nice.  I gave it a shot on a Malta and it works just fine.

It works fine on vr41xx and cobalt too.
Cobalt is using i8259.

Thanks for your work,

Yoichi
