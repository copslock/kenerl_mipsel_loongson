Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 15:45:42 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:5580 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20046799AbXAKPph (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jan 2007 15:45:37 +0000
Received: from localhost (p2161-ipad26funabasi.chiba.ocn.ne.jp [220.104.88.161])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9B185BD9D; Fri, 12 Jan 2007 00:45:31 +0900 (JST)
Date:	Fri, 12 Jan 2007 00:45:31 +0900 (JST)
Message-Id: <20070112.004531.132304408.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070111234747.7eed9028.yoichi_yuasa@tripeaks.co.jp>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
	<20070111143116.GA4451@linux-mips.org>
	<20070111234747.7eed9028.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 13587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 11 Jan 2007 23:47:47 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > <Ralf> I think he should have io_offset = 0.
> 
> When I tried io_offset = 0, tulip net driver didn't work.
> 
> > Which is what other GT-64120 platforms are using, so I wonder why that is
> > different on Cobalt.
> 
> I don't know, but io_offset is needed for Cobalt.

If io_offset = 0, GT-64120 must be programmed to remap physicall
address GT_DEF_PCI0_IO_BASE to PCI IO address 0.  Maybe other GT-64120
users have such configuraion?

---
Atsushi Nemoto
