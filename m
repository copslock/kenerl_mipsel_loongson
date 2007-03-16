Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 07:32:37 +0000 (GMT)
Received: from mo32.po.2iij.NET ([210.128.50.17]:64026 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021608AbXCPHcc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2007 07:32:32 +0000
Received: by mo.po.2iij.net (mo32) id l2G7VEnQ021321; Fri, 16 Mar 2007 16:31:14 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l2G7VC3s013268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 16 Mar 2007 16:31:12 +0900 (JST)
Message-Id: <200703160731.l2G7VC3s013268@mbox33.po.2iij.net>
Date:	Fri, 16 Mar 2007 16:31:12 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] merge GT64111 PCI routines and GT64120 PCI_0
 routines
In-Reply-To: <20070314134511.GA24290@linux-mips.org>
References: <20070314215126.72d21e96.yoichi_yuasa@tripeaks.co.jp>
	<20070314134511.GA24290@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Wed, 14 Mar 2007 13:45:12 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Mar 14, 2007 at 09:51:26PM +0900, Yoichi Yuasa wrote:
> 
> > This patch has merged GT64111 PCI routines and GT64120 PCI_0 routines.
> > GT64111 PCI is almost the same as GT64120's PCI_0.
> > This patch don't change GT64120 PCI routines.
> > 
> > This patch tested on Cobalt Qube2.
> > 
> > Please queue for 2.6.22.
> 
> Will do.
> 
> This sort of cleanup is something I meant to do for a long time.  We have
> other fairly similar chips such as the GT-64240 used in the Ocelot G and
> the GT-64340 used in the Ocelot 3 which both are supported by
> arch/mips/pci/ops-marvell.c.  There are many other PCI busses which are
> virtually identical.

OK, I will compare them.

Thanks,

Yoichi
