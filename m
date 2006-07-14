Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 01:43:17 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:2616 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133737AbWGNAnJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Jul 2006 01:43:09 +0100
Received: by mo.po.2iij.net (mo31) id k6E0h5r3064489; Fri, 14 Jul 2006 09:43:05 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k6E0h3ID011958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Jul 2006 09:43:03 +0900 (JST)
Date:	Fri, 14 Jul 2006 09:43:03 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] vr41xx: added #indef __KERNEL__/#endif to vr41xx header
 files
Message-Id: <20060714094303.3b9cfab8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060713141516.GB24611@linux-mips.org>
References: <20060713173356.72ab52f1.yoichi_yuasa@tripeaks.co.jp>
	<20060713141516.GB24611@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 13 Jul 2006 15:15:16 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Thu, Jul 13, 2006 at 05:33:56PM +0900, Yoichi Yuasa wrote:
> 
> > This patch has added #ifdef __KERNEL__/#endif to vr41xx header files.
> 
> None of the include/asm-mips/vr41xx/ files touched by this patch is
> listed in include/asm-mips/Kbuild for installation so I don't see why
> protecting with #indef __KERNEL__ would make sense?

I see how it is.
Thanks for your comment.

Yoichi
