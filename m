Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 15:25:38 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:33287 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039151AbWJGOZg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Oct 2006 15:25:36 +0100
Received: by mo.po.2iij.net (mo30) id k97EPXRq051059; Sat, 7 Oct 2006 23:25:33 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox32) id k97EPSZn086788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 7 Oct 2006 23:25:28 +0900 (JST)
Date:	Sat, 7 Oct 2006 13:02:27 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, sshtylyov@ru.mvista.com,
	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] add "depends on BROKEN" to broken boards support
Message-Id: <20061007130227.0790b206.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061007.225507.41198174.anemo@mba.ocn.ne.jp>
References: <20061007005452.45b50d8c.yoichi_yuasa@tripeaks.co.jp>
	<4526A0F3.5090202@ru.mvista.com>
	<20061007064805.5b656556.yoichi_yuasa@tripeaks.co.jp>
	<20061007.225507.41198174.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Sat, 07 Oct 2006 22:55:07 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Sat, 7 Oct 2006 06:48:05 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > >     There's a patch from Atsushi Nemoto still pending commit, IIRC...
> > 
> > Is it fixed these errors.
> > 
> >   LD      .tmp_vmlinux1
> > arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `toshiba_rbtx4938_irq_nested':
> > : undefined reference to `wbflush'
> > arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `toshiba_rbtx4938_irq_nested':
> > : relocation truncated to fit: R_MIPS_26 against `wbflush'
> 
> Yes.  The patch is here.
> 
> http://www.linux-mips.org/archives/linux-mips/2006-08/msg00204.html

OK, It's fixed rbhma4500 errors.
I'll update my patch.

Yoichi
