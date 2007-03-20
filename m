Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 01:43:30 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:45517 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022473AbXCTBn2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 01:43:28 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 20 Mar 2007 10:43:27 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CB44A421F0;
	Tue, 20 Mar 2007 10:43:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B608641FB5;
	Tue, 20 Mar 2007 10:43:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2K1h0W0051892;
	Tue, 20 Mar 2007 10:43:00 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 20 Mar 2007 10:43:00 +0900 (JST)
Message-Id: <20070320.104300.107967447.nemoto@toshiba-tops.co.jp>
To:	dsaxena@plexity.net
Cc:	mingo@elte.hu, ralf@linux-mips.org, linux-mips@linux-mips.org,
	mlachwani@mvista.com
Subject: Re: [PATCH] Make MIPS udelay() preempt safe
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070320000300.GA12123@plexity.net>
References: <20070319234945.GA11944@plexity.net>
	<20070320000300.GA12123@plexity.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 17:03:00 -0700, Deepak Saxena <dsaxena@plexity.net> wrote:
> Nevermind on this one. I just noticed that the original patch is not
> needed.

Why?  I think the patch is needed to silence error message with
CONFIG_DEBUG_PREEMPT.

---
Atsushi Nemoto
