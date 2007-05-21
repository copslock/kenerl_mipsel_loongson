Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 15:17:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:15351 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022758AbXEUOR4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 15:17:56 +0100
Received: from localhost (p1031-ipad32funabasi.chiba.ocn.ne.jp [221.189.133.31])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9A00AA5DE; Mon, 21 May 2007 23:16:37 +0900 (JST)
Date:	Mon, 21 May 2007 23:16:57 +0900 (JST)
Message-Id: <20070521.231657.108738383.anemo@mba.ocn.ne.jp>
To:	florian.fainelli@telecomint.eu
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] Add GPIO wrappers to Au1x00 boards
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200705210810.11594.florian.fainelli@telecomint.eu>
References: <20070521.002642.108739229.anemo@mba.ocn.ne.jp>
	<200705210130.17957.florian.fainelli@telecomint.eu>
	<200705210810.11594.florian.fainelli@telecomint.eu>
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
X-archive-position: 15107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 21 May 2007 08:10:08 +0200, Florian Fainelli <florian.fainelli@telecomint.eu> wrote:
> -EXPORT_SYMBOL(au1xxx_gpio1_set_inputs);
> -EXPORT_SYMBOL(au1xxx_gpio_tristate);
> -EXPORT_SYMBOL(au1xxx_gpio_write);
> -EXPORT_SYMBOL(au1xxx_gpio_read);

You should export au1xxx_gpio_get_value() etc. otherwise a user of
generic GPIO API can not be built as a module.

---
Atsushi Nemoto
