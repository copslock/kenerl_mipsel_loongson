Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 08:11:53 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:23365 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022362AbXFNHLv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2007 08:11:51 +0100
Received: by mo.po.2iij.net (mo32) id l5E7BjMQ035746; Thu, 14 Jun 2007 16:11:45 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l5E7BirR019881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jun 2007 16:11:44 +0900
Date:	Thu, 14 Jun 2007 16:11:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] Remove Momenco Ocelot C support
Message-Id: <20070614161144.5725a8d5.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070613185232.GA27392@linux-mips.org>
References: <11815673353523-git-send-email-fbuihuu@gmail.com>
	<118156733610-git-send-email-fbuihuu@gmail.com>
	<20070613185232.GA27392@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Wed, 13 Jun 2007 19:52:32 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Jun 11, 2007 at 03:08:55PM +0200, Franck Bui-Huu wrote:
> 
> > Momenco Ocelot C support is deprecated and scheduled for removal
> > since September 2006.
> 
> And totally untested since ages.  2.6.22 will be its last summer ;-)
> 
> Patch queued up to 2.6.23, actually already a few days ago.

Please queue this patch too.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

---

Already dropped Momenco Ocelot C/G boards support.
also remove their MTD support.

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mtd/devices/docprobe.c mips/drivers/mtd/devices/docprobe.c
--- mips-orig/drivers/mtd/devices/docprobe.c	2007-06-14 13:22:04.698797000 +0900
+++ mips/drivers/mtd/devices/docprobe.c	2007-06-14 13:19:38.473658500 +0900
@@ -84,8 +84,6 @@ static unsigned long __initdata doc_loca
 #elif defined(CONFIG_MOMENCO_OCELOT)
 	0x2f000000,
 	0xff000000,
-#elif defined(CONFIG_MOMENCO_OCELOT_G) || defined (CONFIG_MOMENCO_OCELOT_C)
-	0xff000000,
 #else
 #warning Unknown architecture for DiskOnChip. No default probe locations defined
 #endif
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mtd/nand/diskonchip.c mips/drivers/mtd/nand/diskonchip.c
--- mips-orig/drivers/mtd/nand/diskonchip.c	2007-06-14 13:22:05.482846000 +0900
+++ mips/drivers/mtd/nand/diskonchip.c	2007-06-14 13:19:12.008004500 +0900
@@ -59,8 +59,6 @@ static unsigned long __initdata doc_loca
 #elif defined(CONFIG_MOMENCO_OCELOT)
 	0x2f000000,
 	0xff000000,
-#elif defined(CONFIG_MOMENCO_OCELOT_G) || defined (CONFIG_MOMENCO_OCELOT_C)
-	0xff000000,
 #else
 #warning Unknown architecture for DiskOnChip. No default probe locations defined
 #endif
