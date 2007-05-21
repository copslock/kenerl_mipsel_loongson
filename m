Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 15:11:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:26104 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022758AbXEUOLo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 15:11:44 +0100
Received: from localhost (p1031-ipad32funabasi.chiba.ocn.ne.jp [221.189.133.31])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DD2C8A3B5; Mon, 21 May 2007 23:11:40 +0900 (JST)
Date:	Mon, 21 May 2007 23:12:00 +0900 (JST)
Message-Id: <20070521.231200.74752428.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, florian.fainelli@telecomint.eu,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add MIPS generic GPIO support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200705210729.l4L7TZB3079730@mbox31.po.2iij.net>
References: <20070521.001238.41198930.anemo@mba.ocn.ne.jp>
	<20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp>
	<200705210729.l4L7TZB3079730@mbox31.po.2iij.net>
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
X-archive-position: 15106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 21 May 2007 16:29:35 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> This patch has added support for the generic GPIO API header file to MIPS.

With the change, adding these lines to Kconfig would be better.

config GENERIC_GPIO
        bool

---
Atsushi Nemoto
