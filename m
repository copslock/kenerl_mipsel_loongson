Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 10:09:23 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28522 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037627AbWIZJJV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 10:09:21 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 26 Sep 2006 18:09:20 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 648FB28257;
	Tue, 26 Sep 2006 18:07:21 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9F2BC280DD;
	Tue, 26 Sep 2006 18:07:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8Q97FW0065495;
	Tue, 26 Sep 2006 18:07:18 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 26 Sep 2006 18:07:15 +0900 (JST)
Message-Id: <20060926.180715.133446218.nemoto@toshiba-tops.co.jp>
To:	imipak@yahoo.com
Cc:	linux-mips@linux-mips.org
Subject: Re: 64K page patch hiccup on SB1
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060925210932.36813.qmail@web31505.mail.mud.yahoo.com>
References: <20060923.235203.126573787.anemo@mba.ocn.ne.jp>
	<20060925210932.36813.qmail@web31505.mail.mud.yahoo.com>
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
X-archive-position: 12669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 25 Sep 2006 14:09:32 -0700 (PDT), Jonathan Day <imipak@yahoo.com> wrote:
> I'll take your word for it that it's more useful - it
> doesn't look a whole lot clearer to me! Anyways, this
> is the output, with CONFIG_KALLSYMS enabled:
...
> Trace:[<ffffffff80102d38>][<ffffffff8010a020>][<ffffffff80126dec>][<ffffffff8010a020>][<ffffffff80102d38>][<ffffffff801273e0>][<ffffffff8012a7dc>][<fff]

This is excerpt from arch/mips/kernel/traps.c:

	printk("Call Trace:");
#ifdef CONFIG_KALLSYMS
	printk("\n");
#endif

Your output does not have a newline right after "Call Trace:" so it
looks CONFIG_KALLSYMS disabled.

---
Atsushi Nemoto
