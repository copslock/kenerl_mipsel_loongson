Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 01:49:50 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:11320 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022370AbXHGAts (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 01:49:48 +0100
Received: by mo.po.2iij.net (mo30) id l770mVi3036526; Tue, 7 Aug 2007 09:48:31 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l770mTOK013036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Aug 2007 09:48:29 +0900
Date:	Tue, 7 Aug 2007 09:48:29 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] vr41xx: add cpu_wait
Message-Id: <20070807094829.35d90f20.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070806174525.GA11275@linux-mips.org>
References: <20070807000917.6bbd2c19.yoichi_yuasa@tripeaks.co.jp>
	<20070806174525.GA11275@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 6 Aug 2007 18:45:25 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Aug 07, 2007 at 12:09:17AM +0900, Yoichi Yuasa wrote:
> 
> > Add cpu_wait for NEC VR41xx
> 
> Queued for 2.6.24.
> 
> Thanks,
> 
>   Ralf
> 
> PS: I take it you've verified that using the standby instruction with
>     interrupts is safe on VR41xx?  There are alot of architectural
>     restrictions in that area.
> 

Yes, it has no problem.

Thanks,

Yoichi
