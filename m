Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2006 10:34:59 +0200 (CEST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:35167 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133372AbWE2Iew (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 May 2006 10:34:52 +0200
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 29 May 2006 17:34:51 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0901820401;
	Mon, 29 May 2006 17:34:48 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E7AA6203ED;
	Mon, 29 May 2006 17:34:47 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k4T8YliX033610;
	Mon, 29 May 2006 17:34:47 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 29 May 2006 17:34:47 +0900 (JST)
Message-Id: <20060529.173447.99454031.nemoto@toshiba-tops.co.jp>
To:	mchitale@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: oprofile for mips 24k
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <d096a3ee0605290123g7169e430t17ea1fb8bd9e7627@mail.gmail.com>
References: <d096a3ee0605282258y210244c7sbdf994d8c075a5e@mail.gmail.com>
	<20060529.154457.27952799.nemoto@toshiba-tops.co.jp>
	<d096a3ee0605290123g7169e430t17ea1fb8bd9e7627@mail.gmail.com>
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
X-archive-position: 11592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 29 May 2006 13:53:15 +0530, "Mayuresh Chitale" <mchitale@gmail.com> wrote:
> The output of kill -l seems to be proper.
> for eg. kill -l USR1 returns value of 16 which looks like the correct
> value for mips.

One note: did you try "kill -l" in bash (instead of /bin/kill) ?  If
so, I have no more idea ...

You can debug by inserting many echo commands in opcontrol script.
---
Atsushi Nemoto
