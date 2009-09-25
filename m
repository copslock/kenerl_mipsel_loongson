Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2009 15:57:48 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:56462 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492751AbZIYN5m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Sep 2009 15:57:42 +0200
Received: from localhost (p8215-ipad310funabasi.chiba.ocn.ne.jp [123.217.210.215])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 28CF36F28; Fri, 25 Sep 2009 22:57:32 +0900 (JST)
Date:	Fri, 25 Sep 2009 22:57:33 +0900 (JST)
Message-Id: <20090925.225733.193685723.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf.roesch@rw-gmbh.de, linux-mips@linux-mips.org, julia@diku.dk
Subject: Re: [PATCH] MIPS: TXx9: Fix error handling / Fix for noenexisting
 gpio_remove.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4AB3B3B9.1040804@ru.mvista.com>
References: <1253080880-11123-1-git-send-email-ralf.roesch@rw-gmbh.de>
	<20090917.225259.173376281.anemo@mba.ocn.ne.jp>
	<4AB3B3B9.1040804@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 Sep 2009 20:22:17 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > I don't mind ether way, I just hope keeping bisectability on mainline.
> > Is it too late, (yet another) Ralf ?
> 
>     Well, Ralf B. has already committed Julia's broken patch at 9/14.

Then,
Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
