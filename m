Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 02:52:11 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:57314 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20033935AbYHDBwA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Aug 2008 02:52:00 +0100
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Mon, 4 Aug 2008 10:51:58 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id AD58042B17;
	Mon,  4 Aug 2008 10:51:52 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A24CF1CE88;
	Mon,  4 Aug 2008 10:51:52 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m741ppfl049801;
	Mon, 4 Aug 2008 10:51:51 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 04 Aug 2008 10:51:51 +0900 (JST)
Message-Id: <20080804.105151.213759441.nemoto@toshiba-tops.co.jp>
To:	tsbogend@alpha.franken.de
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	a.zummo@towertech.it, ralf@linux-mips.org
Subject: Re: [PATCH] M48T35: new RTC driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080803174140.797B51DA6F4@solo.franken.de>
References: <20080803174140.797B51DA6F4@solo.franken.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun,  3 Aug 2008 19:41:40 +0200 (CEST), Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> This driver replaces the broken ip27-rtc driver in drivers/char and
> gives back RTC support for SGI IP27 machines.
...
> +config RTC_DRV_M48T35
> +	tristate "ST M48T35"
> +	depends on SGI_IP27

Is this driver really IP27 specific?  Let's make drivers generic as
possible.

> +	if (yrs < 1970)
> +		return -EINVAL;
> +
> +	leap_yr = ((!(yrs % 4) && (yrs % 100)) || !(yrs % 400));
> +
> +	if ((mon > 12) || (day == 0))
> +		return -EINVAL;
> +
> +	if (day > (days_in_mo[mon] + ((mon == 2) && leap_yr)))
> +		return -EINVAL;
> +
> +	if ((hrs >= 24) || (min >= 60) || (sec >= 60))
> +		return -EINVAL;

rtc_valid_tm() can be used?

> +	if (!request_mem_region(res->start, priv->size, pdev->name)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	priv->baseaddr = res->start;
> +	priv->reg = (struct m48t35_rtc __iomem *)res->start;

It seems priv->baseaddr is a physical address and priv->reg is a
virtual address.  ioremap() is not needed?

---
Atsushi Nemoto
