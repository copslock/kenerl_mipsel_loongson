Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 15:14:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52989 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133657AbWBQPOY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 15:14:24 +0000
Received: from localhost (p2067-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 215A5B518; Sat, 18 Feb 2006 00:21:01 +0900 (JST)
Date:	Sat, 18 Feb 2006 00:20:49 +0900 (JST)
Message-Id: <20060218.002049.75184722.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] use __raw access function for fb
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060209.005655.96684595.anemo@mba.ocn.ne.jp>
References: <20060209.005655.96684595.anemo@mba.ocn.ne.jp>
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
X-archive-position: 10491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I just sent another non-intrusive fix (add __force tag to fb_readb,
etc) to LKML.

BTW, current fb_readw(), etc. are really appropriate for IP22/IP32?
It seems they have funny __swizzle_addr_w ...

---
Atsushi Nemoto
