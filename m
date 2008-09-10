Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 16:12:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:39361 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S62088073AbYIJPMz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2008 16:12:55 +0100
Received: from localhost (p1216-ipad302funabasi.chiba.ocn.ne.jp [123.217.139.216])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9A9E3B3BA; Thu, 11 Sep 2008 00:12:50 +0900 (JST)
Date:	Thu, 11 Sep 2008 00:12:58 +0900 (JST)
Message-Id: <20080911.001258.07457550.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	alan@lxorguk.ukuu.org.uk, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48C6AD7E.10005@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
	<48C6AD7E.10005@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 09 Sep 2008 21:08:14 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>+#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)
> 
> > Why do you have void __iomem casts all over the write methods not in the
> > _BASE() method - that would let sparse do its job properly
> 
>     I don't get why there's need for & at all -- isn't IDE data register 
> address always on 4K boundary?

On little endian, yes.  On big endian, this controller flips addr[2:0].

---
Atsushi Nemoto
