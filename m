Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2009 14:26:08 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:15612 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21365860AbZAPOZa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2009 14:25:30 +0000
Received: from localhost (p4226-ipad212funabasi.chiba.ocn.ne.jp [58.91.168.226])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B799B9CEC; Fri, 16 Jan 2009 23:25:24 +0900 (JST)
Date:	Fri, 16 Jan 2009 23:25:27 +0900 (JST)
Message-Id: <20090116.232527.59651191.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-ide@vger.kernel.org, bzolnier@gmail.com,
	linux-mips@linux-mips.org, stable@kernel.org
Subject: Re: [PATCH] tx4939ide: Do not use zero count PRD entry
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <497082D1.5030504@ru.mvista.com>
References: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
	<497082D1.5030504@ru.mvista.com>
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
X-archive-position: 21771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 16 Jan 2009 15:51:29 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +			 * This workaround for zero count seems required.
> > +			 * (standard ide_build_dmatable do it too)
> 
>     s/do/does/

Thanks!

> > +			if ((bcount & 0xffff) == 0x0000)
> 
>    Why not just bcount == 0x10000?

Indeed.  It is just because ide_build_dmatable does so :)

I will prepare another patch, while the patch is already mainlined and
queued for stable, and this time changes are not suitable for stable
tree.

---
Atsushi Nemoto
