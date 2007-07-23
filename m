Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 06:02:07 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:13355 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022575AbXGWFCF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jul 2007 06:02:05 +0100
Received: by mo.po.2iij.net (mo31) id l6N521dR001223; Mon, 23 Jul 2007 14:02:01 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l6N51wgf022101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 23 Jul 2007 14:01:59 +0900
Date:	Mon, 23 Jul 2007 14:01:58 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix section mismatch prom_free_prom_memory()
Message-Id: <20070723140158.0913e1d1.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070722.234420.25908731.anemo@mba.ocn.ne.jp>
References: <20070722130046.085e0f8d.yoichi_yuasa@tripeaks.co.jp>
	<20070722.234420.25908731.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


On Sun, 22 Jul 2007 23:44:20 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Sun, 22 Jul 2007 13:00:46 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > Fix section mismatch prom_free_prom_memory().
> > 
> > WARNING: vmlinux.o(.text+0xbf20): Section mismatch: reference to
> > .init.text:prom_free_prom_memory (between 'free_initmem' and 'copy_from_user_page')
> 
> prom_free_prom_memory() is called _before_ freeing init sections, so
> it is false positive.  __init_refok can be used for such cases.

It's right.

Thank you for correcting it,

Yoichi
