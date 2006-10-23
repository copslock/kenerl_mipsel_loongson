Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 04:04:13 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:41628 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038922AbWJWDEL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 04:04:11 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 23 Oct 2006 12:04:10 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5251541942;
	Mon, 23 Oct 2006 12:04:08 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 3E3B641919;
	Mon, 23 Oct 2006 12:04:08 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9N347W0085553;
	Mon, 23 Oct 2006 12:04:07 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 23 Oct 2006 12:04:07 +0900 (JST)
Message-Id: <20061023.120407.122620341.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, tglx@linutronix.de,
	johnstul@us.ibm.com
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <453BC5B4.50005@ru.mvista.com>
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
	<453BC5B4.50005@ru.mvista.com>
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
X-archive-position: 13060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Oh I missed final comment ...

On Sun, 22 Oct 2006 23:25:40 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	init_mips_clocksource();
> 
>     Well, this is usually done via module_init()...

As I wrote in reply to Manish, I do not see good reason to use
module_init here.

---
Atsushi Nemoto
