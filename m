Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 14:24:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:33232 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20036835AbYGMNYb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 14:24:31 +0100
Received: from localhost (p1204-ipad207funabasi.chiba.ocn.ne.jp [222.145.83.204])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A21BDA9DC; Sun, 13 Jul 2008 22:24:27 +0900 (JST)
Date:	Sun, 13 Jul 2008 22:26:14 +0900 (JST)
Message-Id: <20080713.222614.130240873.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][2/5][MIPS] txx9_cpu_clock setup move to
 rbtx4927_time_init()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080713195408.f3878fb2.yoichi_yuasa@tripeaks.co.jp>
References: <20080713195155.08c4285d.yoichi_yuasa@tripeaks.co.jp>
	<20080713195408.f3878fb2.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 19807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 13 Jul 2008 19:54:08 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> txx9_cpu_clock setup move to rbtx4927_time_init().
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

I'm thinking of replacing some magic constant used in
rbtx4927_mem_setup with txx9_cpu_clock, but it is not done yet, so no
problem for now.  I'll be back ;)

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
