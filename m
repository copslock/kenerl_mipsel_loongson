Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2009 15:53:12 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:58367 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1491939AbZIQNxF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Sep 2009 15:53:05 +0200
Received: from localhost (p4003-ipad310funabasi.chiba.ocn.ne.jp [123.217.206.3])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5B3506A3B; Thu, 17 Sep 2009 22:52:57 +0900 (JST)
Date:	Thu, 17 Sep 2009 22:52:59 +0900 (JST)
Message-Id: <20090917.225259.173376281.anemo@mba.ocn.ne.jp>
To:	ralf.roesch@rw-gmbh.de
Cc:	linux-mips@linux-mips.org, Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] MIPS: TXx9: Fix error handling / Fix for noenexisting
 gpio_remove.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1253080880-11123-1-git-send-email-ralf.roesch@rw-gmbh.de>
References: <1253080880-11123-1-git-send-email-ralf.roesch@rw-gmbh.de>
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
X-archive-position: 24042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 16 Sep 2009 08:01:20 +0200, Ralf Roesch <ralf.roesch@rw-gmbh.de> wrote:
> error was introduced by commit 0385d1f3d394c6814be0b165c153fc3fc254469a

Thanks, this patch should be holded into the original commit before
mainlining.  The result should be same as Julia's revised patch.

I don't mind ether way, I just hope keeping bisectability on mainline.
Is it too late, (yet another) Ralf ?

---
Atsushi Nemoto
