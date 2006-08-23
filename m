Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 01:45:06 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:23852 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037804AbWHWApE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2006 01:45:04 +0100
Received: by mo.po.2iij.net (mo30) id k7N0iouZ095534; Wed, 23 Aug 2006 09:44:50 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k7N0iioU075519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Aug 2006 09:44:45 +0900 (JST)
Date:	Wed, 23 Aug 2006 09:44:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Alexander Voropay" <a.voropay@equant.ru>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/12] Cobalt use GT64120 PCI routines
Message-Id: <20060823094444.4c158363.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <0b2801c6c5ff$1ff8a8c0$e90d11ac@spb.in.rosprint.ru>
References: <20060822223406.56435d84.yoichi_yuasa@tripeaks.co.jp>
	<0b2801c6c5ff$1ff8a8c0$e90d11ac@spb.in.rosprint.ru>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 22 Aug 2006 19:22:01 +0400
"Alexander Voropay" <a.voropay@equant.ru> wrote:

> "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp> wrote:
> > 
> > This patch has moved GT64111 PCI routine to GT64120 PCI routine about Cobalt.
> > They are same codes.
> 
>  Hm... GT64111 and GT64120 are two different chips, i.e. GT64120 has two
> PCI buses e.t.c. May be, it wil be better to move this code to something
> more genetic, like GT64* ?
>

Yes, GT64120 has two PCI buses(PCI_0 and PCI_1).
GT64120's PCI_0 is almost the same as GT64111 PCI.

arch/mips/pci/pci-gt64120.c supports only PCI_0.
Now GT64111 and GT64120 can share pci-gt64120.c .

I don't know a board that uses PCI_1.
Do you have any information about it?

Yoichi
