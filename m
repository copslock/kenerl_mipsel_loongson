Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 01:36:04 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:29983 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28582639AbXAWBf6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2007 01:35:58 +0000
Received: by mo.po.2iij.net (mo32) id l0N1ZpqG091134; Tue, 23 Jan 2007 10:35:51 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id l0N1ZjEv051924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Jan 2007 10:35:45 +0900 (JST)
Date:	Tue, 23 Jan 2007 10:35:45 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, phorton@bitbox.co.uk,
	alan@lxorguk.ukuu.org.uk, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-Id: <20070123103545.1fcce62b.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070122203517.GA26801@linux-mips.org>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
	<20070111143116.GA4451@linux-mips.org>
	<45A79847.1060302@bitbox.co.uk>
	<20070112144042.74c4edca@localhost.localdomain>
	<20070112144905.2919e705@localhost.localdomain>
	<20070114115539.GA5755@linux-mips.org>
	<45AB839A.50003@bitbox.co.uk>
	<20070122203517.GA26801@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Jan 2007 20:35:17 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Jan 15, 2007 at 01:37:30PM +0000, Peter Horton wrote:
> 
> Time to get this going again ...
> 
> > I've just checked on the Qube2 here and the RTC can be found at 
> > 0x1000.0070, 0x1001.0070 etc so the VIA bridge is only decoding the low 
> > 16 address lines for I/O space. Handy really otherwise it wouldn't work 
> > with the GT-64111 :-)
> 
> Thanks, that's what I was expecting.  So to resume the discussion about
> how to fix this I suggest:
> 
>  o Set cobalt_io_resource to the 0x10001000 - 0x10010000 range.
>  o Set ioport_resource to the 0x10000000 - 0x10010000 range.

IDE fixed resources are out of range.

>  o set mips_io_port_base to 0xa0000000
>  o set cobalt_pci_controller.io_offset back to 0
> 
> And then since we're not longer cheating about the true value of the
> port addresses on the PCI bus used, add 0x10000000 to all of the start
> and end values in cobalt_io_resources.
> 
> Does that sound reasonable?

sounds good, excluding above problem.

Yoichi
