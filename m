Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 10:26:59 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:31994 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022599AbXF1J0y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Jun 2007 10:26:54 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 28 Jun 2007 18:26:52 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id C228F2074F;
	Thu, 28 Jun 2007 18:26:48 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B6705204B2;
	Thu, 28 Jun 2007 18:26:48 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l5S9QlAF043083;
	Thu, 28 Jun 2007 18:26:47 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 28 Jun 2007 18:26:46 +0900 (JST)
Message-Id: <20070628.182646.129446079.nemoto@toshiba-tops.co.jp>
To:	hch@lst.de
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] generic clk API implementation for MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070628083725.GA23394@lst.de>
References: <20070627153932.GA6016@lst.de>
	<20070628.112223.96686654.nemoto@toshiba-tops.co.jp>
	<20070628083725.GA23394@lst.de>
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
X-archive-position: 15560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 28 Jun 2007 10:37:25 +0200, Christoph Hellwig <hch@lst.de> wrote:
> > But I gave up for now ;) I will leave all implementation for platform
> > code.
> 
> I really dislike duplicating thing over architectures.  If you copy code
> from another architecture the first though should be 'could and should
> this be generic ?'.  So please try to get this lifted to common code
> instead of duplicating it.

OK, I see.  But now I think the best thing we can provide as generic
is only "no clocks" implementation.

Do you think it is worth to put into lib/ directory?

struct clk *__weak clk_get(struct device *dev, const char *id)
{
	return ERR_PTR(-ENOENT);
}
EXPORT_SYMBOL(clk_get);

int __weak clk_enable(struct clk *clk)
{
	return 0;
}
EXPORT_SYMBOL(clk_enable);

void __weak clk_disable(struct clk *clk)
{
}
EXPORT_SYMBOL(clk_disable);

unsigned long __weak clk_get_rate(struct clk *clk)
{
	return 0;
}
EXPORT_SYMBOL(clk_get_rate);

void __weak clk_put(struct clk *clk)
{
}
EXPORT_SYMBOL(clk_put);


This might conflict with some current implementations which export
these APIs as EXPORT_SYMBOL_GPL...

---
Atsushi Nemoto
