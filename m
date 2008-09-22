Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2008 16:16:17 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57811 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20149252AbYIVPPo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2008 16:15:44 +0100
Received: from localhost (p7139-ipad310funabasi.chiba.ocn.ne.jp [123.217.209.139])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 988A7AA33; Tue, 23 Sep 2008 00:15:38 +0900 (JST)
Date:	Tue, 23 Sep 2008 00:16:02 +0900 (JST)
Message-Id: <20080923.001602.51867636.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48D7B365.6070305@ru.mvista.com>
References: <48D51B48.2090400@ru.mvista.com>
	<20080922.235608.106262139.anemo@mba.ocn.ne.jp>
	<48D7B365.6070305@ru.mvista.com>
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
X-archive-position: 20589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Sep 2008 19:01:57 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>  BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?
> 
> > Yes, next plan.  It should be much simpler than the tx4939ide driver.
> 
>     I suspect {ide|pata}_platform could be able to cover it... though I got 
> muddled in the timing diagrams for the TX4938 external bus...

We need .set_pio_mode routine to get best PIO speed, but current
{ide|pata}_platform driver does not provide a hook for it (please
correct me if I was wrong).  So current code I have does not use
ide_platform...

---
Atsushi Nemoto
