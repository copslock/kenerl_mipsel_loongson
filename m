Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jan 2007 15:21:16 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:12850 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573718AbXAMPVK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Jan 2007 15:21:10 +0000
Received: by mo.po.2iij.net (mo30) id l0DFL6X3067800; Sun, 14 Jan 2007 00:21:06 +0900 (JST)
Received: from localhost.localdomain (69.25.30.125.dy.iij4u.or.jp [125.30.25.69])
	by mbox.po.2iij.net (mbox30) id l0DFKxUY094872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Jan 2007 00:21:00 +0900 (JST)
Date:	Sun, 14 Jan 2007 00:20:59 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-Id: <20070114002059.56fc29db.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070112.225459.106262484.anemo@mba.ocn.ne.jp>
References: <20070111234747.7eed9028.yoichi_yuasa@tripeaks.co.jp>
	<20070112.004531.132304408.anemo@mba.ocn.ne.jp>
	<20070112114618.78d10a3d.yoichi_yuasa@tripeaks.co.jp>
	<20070112.225459.106262484.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 12 Jan 2007 22:54:59 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Fri, 12 Jan 2007 11:46:18 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > If io_offset = 0, GT-64120 must be programmed to remap physicall
> > > address GT_DEF_PCI0_IO_BASE to PCI IO address 0.  Maybe other GT-64120
> > > users have such configuraion?
> > 
> > GT-64111(used for Cobalt) has no remap register.
> > It cannot be programmed to address remap.
> 
> Then, inb(0) converted to physical address 0x10000000
> (GT_DEF_PCI0_IO_BASE), and on PCI bus it is PCI IO address 0? or
> 0x10000000?

When PCI base address register set 0x1000(I/O space), inb(0x1000) reads wrong value
(tulip net driver reads wrong eeprom data).

When PCI base address register set 0x10001000(I/O space), inb(0x1000) reads valid value.
PCI I/O address and CPU bus address seem to have to be same.

> 
> If PCI IO address was 0, io_offset should be 0.  Otherwise, io_offset
> should be -0x10000000, as current code does.

Based on the above result, io_offset should be -0x10000000.

> So if it does not work now, something's going wrong... but I have no
> idea now.

Yoichi
