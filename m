Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 22:54:42 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:19498 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024123AbXLKWyd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Dec 2007 22:54:33 +0000
Received: by mo.po.2iij.net (mo31) id lBBMrESc006631; Wed, 12 Dec 2007 07:53:14 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id lBBMrAsx022513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Dec 2007 07:53:10 +0900
Date:	Wed, 12 Dec 2007 07:53:09 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Cobalt fixes
Message-Id: <20071212075309.5172da92.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071211153522.GB15843@linux-mips.org>
References: <20071211121220.GA10870@linux-mips.org>
	<20071211235001.8621bdb9.yoichi_yuasa@tripeaks.co.jp>
	<20071211153522.GB15843@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 11 Dec 2007 15:35:22 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Dec 11, 2007 at 11:50:01PM +0900, Yoichi Yuasa wrote:
> 
> > > for non-subscribers.  Linus has reverted the offending patch
> > > fd6e732186ab522c812ab19c2c5e5befb8ec8115 in question so now the PCI and
> > > I/O port code needs to be fixed up to be able to handle such a setup.
> > 
> > It can be fixed my fix PCI resource patch.
> > 
> > http://www.linux-mips.org/archives/linux-mips/2007-01/msg00049.html
> 
> Modulo a codying style issue that one is the same as the pci.c segment of
> the patch I've just posted.

This is a fix proposed before fd6e732186ab522c812ab19c2c5e5befb8ec8115. 
This patch is still effective. 

Fixed line offset and coding style.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/pci.c mips/arch/mips/pci/pci.c
--- mips-orig/arch/mips/pci/pci.c	2007-12-12 06:48:44.282421000 +0900
+++ mips/arch/mips/pci/pci.c	2007-12-12 06:54:51.041342000 +0900
@@ -242,6 +242,8 @@ static void pcibios_fixup_device_resourc
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!dev->resource[i].start)
 			continue;
+		if (dev->resource[i].flags & IORESOURCE_PCI_FIXED)
+			continue;
 		if (dev->resource[i].flags & IORESOURCE_IO)
 			offset = hose->io_offset;
 		else if (dev->resource[i].flags & IORESOURCE_MEM)
