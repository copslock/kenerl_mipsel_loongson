Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 02:45:15 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:10776 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133507AbWBCCo4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 02:44:56 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with SMTP; 3 Feb 2006 02:50:10 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A84C72037F;
	Fri,  3 Feb 2006 11:50:08 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9393020336;
	Fri,  3 Feb 2006 11:50:08 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k132o74D022548;
	Fri, 3 Feb 2006 11:50:08 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 03 Feb 2006 11:50:07 +0900 (JST)
Message-Id: <20060203.115007.112625083.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf@linux-mips.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43E2BF68.2000208@ru.mvista.com>
References: <Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl>
	<20060202165656.GC17352@linux-mips.org>
	<43E2BF68.2000208@ru.mvista.com>
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
X-archive-position: 10321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 03 Feb 2006 05:26:48 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
sshtylyov>     And.. how do you imagine placing a NOP (which surely
sshtylyov> just moves MFC0 down so that it's a 1st insn. on the next
sshtylyov> page). What if it'll move it to the errata prone address
sshtylyov> from a safe one instead?

The NOP will break the "If mfc0 $12 follows store" condition.

Actually, the condition is more strict.  This is a code sequence from
the errata. (It seems English version is not updated yet...)

	Load/Store instruction
	Load/Store/Sync instruction
	Mfc0 rt,rd	; rd is Status/Cause
	-- page boundary --
	nop		; TLB mapped area

For Cause register case, Linux modules should never read it so it
would not be a problem.

---
Atsushi Nemoto
