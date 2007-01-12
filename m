Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2007 14:37:51 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5598 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S28575218AbXALOhq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Jan 2007 14:37:46 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.8/8.13.4) with ESMTP id l0CEn5b1030930;
	Fri, 12 Jan 2007 14:49:05 GMT
Date:	Fri, 12 Jan 2007 14:49:05 +0000
From:	Alan <alan@lxorguk.ukuu.org.uk>
To:	Alan <alan@lxorguk.ukuu.org.uk>
Cc:	Peter Horton <phorton@bitbox.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-ID: <20070112144905.2919e705@localhost.localdomain>
In-Reply-To: <20070112144042.74c4edca@localhost.localdomain>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
	<20070111143116.GA4451@linux-mips.org>
	<45A79847.1060302@bitbox.co.uk>
	<20070112144042.74c4edca@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, 12 Jan 2007 14:40:42 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

Sorry hit the wrong button

> > The GT-64111 passes the CPU addresses straight onto the PCI bus and does 
> > not remove the offset of the Galileo's PCI window in CPU space. This 
> > means the only PCI I/O addresses that can be supported are 0x1000.0000 
> > to 0x11ff.ffff, hence the negative 'io_offset'.

Does this mean it can't hit PCI I/O space legacy addresses (0x1F0 etc) ?

If so can you set CONFIG_NO_ATA_LEGACY in your platform configuration
