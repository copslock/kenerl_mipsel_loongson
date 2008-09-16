Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 16:20:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:18394 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20145389AbYIPPUZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2008 16:20:25 +0100
Received: from localhost (p3175-ipad211funabasi.chiba.ocn.ne.jp [58.91.159.175])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 89326B742; Wed, 17 Sep 2008 00:20:18 +0900 (JST)
Date:	Wed, 17 Sep 2008 00:20:34 +0900 (JST)
Message-Id: <20080917.002034.27955909.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48CF8A87.6030908@ru.mvista.com>
References: <48CC3516.9080404@ru.mvista.com>
	<20080914.220512.126760706.anemo@mba.ocn.ne.jp>
	<48CF8A87.6030908@ru.mvista.com>
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
X-archive-position: 20505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 16 Sep 2008 14:29:27 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>    This doesn't look consistent (aside from the TX4939IDE_REG8/16 issue) 
> >> -- mm_outsw_swap() calls cpu_to_le16() before writing 16-bit data but 
> >> this code doesn't. So, either one of those should be wrong...
> >
> > Thanks, this code should be wrong.  IDE_TFLAG_OUT_DATA is totally
> > untested...
> 
>    Hum, not necessarily...
>    If the data register is BE, this should work correctly, if I don't 
> mistake (once you fix the data register's address).

Hmm... or ide_tf_load()/ide_tf_read() is broken for big endian MIPS ?
(and possibly SPARC etc.)

__ide_mm_writesw(port, &data, 1) should be used instead of writew()
for IDE_TFLAG_OUT_DATA?

---
Atsushi Nemoto
