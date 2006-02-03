Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 02:18:27 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:29957 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133457AbWBCCRm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 02:17:42 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with SMTP; 3 Feb 2006 02:22:56 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 8632F2038B;
	Fri,  3 Feb 2006 11:22:54 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 73E3A2022E;
	Fri,  3 Feb 2006 11:22:54 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k132Mr4D022348;
	Fri, 3 Feb 2006 11:22:53 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 03 Feb 2006 11:22:53 +0900 (JST)
Message-Id: <20060203.112253.104030567.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43E2BC1F.7080505@ru.mvista.com>
References: <43E25381.4060309@ru.mvista.com>
	<20060203.101705.41198541.nemoto@toshiba-tops.co.jp>
	<43E2BC1F.7080505@ru.mvista.com>
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
X-archive-position: 10319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 03 Feb 2006 05:12:47 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
sshtylyov>     If I don't mistake, the offending code is in
sshtylyov> local_irq_disable, local_irq_save, and local_irq_restore
sshtylyov> macros. The effect would be a crash on any exception taken
sshtylyov> once interrupts get disabled in a module (*and* that code
sshtylyov> happens to fall on a page boundary)... nasty. :-(

Right.  And it can really happen.

---
Atsushi Nemoto
