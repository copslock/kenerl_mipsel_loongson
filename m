Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2007 13:55:10 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:23489 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20042476AbXALNzE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2007 13:55:04 +0000
Received: from localhost (p8091-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.91])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 04F14A8CE; Fri, 12 Jan 2007 22:55:00 +0900 (JST)
Date:	Fri, 12 Jan 2007 22:54:59 +0900 (JST)
Message-Id: <20070112.225459.106262484.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070112114618.78d10a3d.yoichi_yuasa@tripeaks.co.jp>
References: <20070111234747.7eed9028.yoichi_yuasa@tripeaks.co.jp>
	<20070112.004531.132304408.anemo@mba.ocn.ne.jp>
	<20070112114618.78d10a3d.yoichi_yuasa@tripeaks.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 12 Jan 2007 11:46:18 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > If io_offset = 0, GT-64120 must be programmed to remap physicall
> > address GT_DEF_PCI0_IO_BASE to PCI IO address 0.  Maybe other GT-64120
> > users have such configuraion?
> 
> GT-64111(used for Cobalt) has no remap register.
> It cannot be programmed to address remap.

Then, inb(0) converted to physical address 0x10000000
(GT_DEF_PCI0_IO_BASE), and on PCI bus it is PCI IO address 0? or
0x10000000?

If PCI IO address was 0, io_offset should be 0.  Otherwise, io_offset
should be -0x10000000, as current code does.

So if it does not work now, something's going wrong... but I have no
idea now.

---
Atsushi Nemoto
