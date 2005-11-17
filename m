Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2005 07:05:40 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:63760 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133414AbVKQHFV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Nov 2005 07:05:21 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 17 Nov 2005 07:08:38 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2EA0B1FDED;
	Thu, 17 Nov 2005 16:08:34 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id BCBED1F4B6;
	Thu, 17 Nov 2005 16:08:33 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jAH78XhO048194;
	Thu, 17 Nov 2005 16:08:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 17 Nov 2005 16:08:33 +0900 (JST)
Message-Id: <20051117.160833.130850703.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: cpu_idle and cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051117.112144.108306652.nemoto@toshiba-tops.co.jp>
References: <20051117.011906.25910026.anemo@mba.ocn.ne.jp>
	<20051116184201.GJ3229@linux-mips.org>
	<20051117.112144.108306652.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 9518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 17 Nov 2005 11:21:45 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> And I checked x86 implemetation and found that HLT or MWAIT
anemo> instruction also must be used with interrupts enabled.  So IIUC
anemo> it seems x86 have same latency problem too.

No, I was wrong.  MWAIT (and MONITOR) instruction provides something
like "test and wait" mechanism.  mwait_idle() is using them for
thread_flag, so there is no latency problem on processors which have
MWAIT/MONITOR.

---
Atsushi Nemoto
