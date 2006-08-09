Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 15:24:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:9435 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20042376AbWHIOYZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2006 15:24:25 +0100
Received: from localhost (p2191-ipad201funabasi.chiba.ocn.ne.jp [222.146.65.191])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8089AA073; Wed,  9 Aug 2006 23:24:13 +0900 (JST)
Date:	Wed, 09 Aug 2006 23:25:51 +0900 (JST)
Message-Id: <20060809.232551.74752502.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ths@networkno.de, linux-mips@linux-mips.org, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44D99B02.1070406@innova-card.com>
References: <44D898FE.7080006@innova-card.com>
	<20060809.010526.18607898.anemo@mba.ocn.ne.jp>
	<44D99B02.1070406@innova-card.com>
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
X-archive-position: 12248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 09 Aug 2006 10:21:22 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Maybe you can add something like "initrdmem=xxx@yyy", keeping
> > "rd_start" and "rd_size" for the backward compatibility.  Just a
> > thought.
> 
> Well that what I was planning when writing this patch but I didn't.
> I think that we will end up with two different semantics and the
> old one never replaced by the new one... Except if we mark them as
> deprecated by showing a warning at boot. What do you think ?

While the kernel command line is very limited resource (only 256
chars), I prefer a single short option to specify initrd range, if
available.

But nothing wrong with rd_start and rd_size, and it seems there are
some boot loader expected them already, so removing them would not be
good (especially without some grace period).

I don't care if there were two way to specify initrd range.  It would
be somewhat redundant, but that is usual on "Backword compatibility"
issue, isn't it?  ;-)

---
Atsushi Nemoto
