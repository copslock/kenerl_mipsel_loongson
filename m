Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2008 15:03:26 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:64481 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28780300AbYDXODY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Apr 2008 15:03:24 +0100
Received: from localhost (p8067-ipad312funabasi.chiba.ocn.ne.jp [123.217.226.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7DB23C3EF; Thu, 24 Apr 2008 23:03:12 +0900 (JST)
Date:	Thu, 24 Apr 2008 23:04:13 +0900 (JST)
Message-Id: <20080424.230413.108119529.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/2] [MIPS] add DS1287 clockevent
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200804240057.m3O0vPcP017636@po-mbox300.hop.2iij.net>
References: <200804240057.m3O0vPcP017636@po-mbox300.hop.2iij.net>
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
X-archive-position: 19011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 24 Apr 2008 09:56:51 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> --- linux-orig/arch/mips/kernel/cevt-ds1287.c	1970-01-01 09:00:00.000000000 +0900
> +++ linux/arch/mips/kernel/cevt-ds1287.c	2008-04-24 09:12:31.330105290 +0900
...
> +#include <irq.h>

Is this needed?

---
Atsushi Nemoto
