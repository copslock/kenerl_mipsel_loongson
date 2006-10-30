Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2006 14:41:40 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:21478 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038686AbWJ3Old (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Oct 2006 14:41:33 +0000
Received: from localhost (p7141-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.141])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AF268B719; Mon, 30 Oct 2006 23:41:28 +0900 (JST)
Date:	Mon, 30 Oct 2006 23:43:57 +0900 (JST)
Message-Id: <20061030.234357.48823890.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] remove an unused variable about Au1000
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061029233740.21a93cbb.yoichi_yuasa@tripeaks.co.jp>
References: <20061029233740.21a93cbb.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 13117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 29 Oct 2006 23:37:40 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> This patch has removed an unused variable about Au1000.
> 
> arch/mips/au1000/common/time.c: In function `mips_timer_interrupt':
> arch/mips/au1000/common/time.c:82: warning: unused variable `count'

That's my fault ... Thanks!

---
Atsushi Nemoto
