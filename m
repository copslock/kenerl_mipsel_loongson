Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2007 20:35:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12469 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28580782AbXAVUfV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Jan 2007 20:35:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0MKZJxn028045;
	Mon, 22 Jan 2007 20:35:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0MKZHNQ028044;
	Mon, 22 Jan 2007 20:35:17 GMT
Date:	Mon, 22 Jan 2007 20:35:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <phorton@bitbox.co.uk>
Cc:	Alan <alan@lxorguk.ukuu.org.uk>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-ID: <20070122203517.GA26801@linux-mips.org>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net> <20070111143116.GA4451@linux-mips.org> <45A79847.1060302@bitbox.co.uk> <20070112144042.74c4edca@localhost.localdomain> <20070112144905.2919e705@localhost.localdomain> <20070114115539.GA5755@linux-mips.org> <45AB839A.50003@bitbox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AB839A.50003@bitbox.co.uk>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 15, 2007 at 01:37:30PM +0000, Peter Horton wrote:

Time to get this going again ...

> I've just checked on the Qube2 here and the RTC can be found at 
> 0x1000.0070, 0x1001.0070 etc so the VIA bridge is only decoding the low 
> 16 address lines for I/O space. Handy really otherwise it wouldn't work 
> with the GT-64111 :-)

Thanks, that's what I was expecting.  So to resume the discussion about
how to fix this I suggest:

 o Set cobalt_io_resource to the 0x10001000 - 0x10010000 range.
 o Set ioport_resource to the 0x10000000 - 0x10010000 range.
 o set mips_io_port_base to 0xa0000000
 o set cobalt_pci_controller.io_offset back to 0

And then since we're not longer cheating about the true value of the
port addresses on the PCI bus used, add 0x10000000 to all of the start
and end values in cobalt_io_resources.

Does that sound reasonable?

  Ralf
