Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 13:54:46 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:9733 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133545AbWFTMyh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 13:54:37 +0100
Received: by mo.po.2iij.net (mo30) id k5KCsWwu034113; Tue, 20 Jun 2006 21:54:32 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k5KCsOYp089485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 21:54:24 +0900 (JST)
Date:	Tue, 20 Jun 2006 21:54:23 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Merge window ...
Message-Id: <20060620215423.2d66bf2e.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <4496BE57.5040802@ru.mvista.com>
References: <20060619103653.GA4257@linux-mips.org>
	<20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp>
	<4496BE57.5040802@ru.mvista.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

On Mon, 19 Jun 2006 19:10:15 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> > Toshiba RBTX4938
> > RBHMA4500
> 
>     This is the same board. I think it's too early to remove this. MV has a 
> number of patches for it BTW, only there was/is no time to push them upstream.
> 
> > Sibyte BCM91250A-SWARM
> 
>     It's really too early to remove this one. MV is working on the new kernel.
> 
> > Also the folowing boards don't have config file.
> 
> > Toshiba TBTX49[23]7
> 
>     I've pushed some patches for those resently...

Can you provide config file for TBTX49[23]7 ?

How about JMR-TX3927?

Yoichi
