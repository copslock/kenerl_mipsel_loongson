Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 07:01:27 +0000 (GMT)
Received: from mo01.po.2iij.net ([210.130.202.205]:50657 "EHLO
	mo01.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S3465560AbWBNHBM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 07:01:12 +0000
Received: NPO MO01 id k1E77Une013870; Tue, 14 Feb 2006 16:07:30 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox00) id k1E77Tah013064
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 14 Feb 2006 16:07:29 +0900 (JST)
Message-Id: <200602140707.k1E77Tah013064@mbox00.po.2iij.net>
Date:	Tue, 14 Feb 2006 16:07:29 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
In-Reply-To: <20060214.120846.15248106.nemoto@toshiba-tops.co.jp>
References: <20060214105928.0cd46e6f.yoichi_yuasa@tripeaks.co.jp>
	<20060214.111547.21591480.nemoto@toshiba-tops.co.jp>
	<20060214112653.25ed3e05.yoichi_yuasa@tripeaks.co.jp>
	<20060214.120846.15248106.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 14 Feb 2006 12:08:46 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> >>>>> On Tue, 14 Feb 2006 11:26:53 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
> yuasa> Here is the boot log.
> 
> Thanks.  Could you try with this patch?
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060204.015356.74753400.anemo%40mba.ocn.ne.jp

I added the patch and tested it.
It has same problem.

Yoichi
