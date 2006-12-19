Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 16:29:25 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:7404 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577320AbWLSQ3U (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 16:29:20 +0000
Received: from localhost (p7053-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.53])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 220E1B836; Wed, 20 Dec 2006 01:29:17 +0900 (JST)
Date:	Wed, 20 Dec 2006 01:29:16 +0900 (JST)
Message-Id: <20061220.012916.96686413.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	danieljlaird@hotmail.com, linux-mips@linux-mips.org,
	vwool@ru.mvista.com
Subject: Re: 2.6.19 timer API changes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45880AC4.5010403@ru.mvista.com>
References: <7943218.post@talk.nabble.com>
	<20061219.233410.25911550.anemo@mba.ocn.ne.jp>
	<45880AC4.5010403@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 19 Dec 2006 18:52:36 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>     I would like to discourage you from repeating those JMR3927
> clocksource "tricks" when you have 3 spare count/compare regs. This
> will warrant troubles when clockevents support gets merged into
> mainline (in fact, it was not necessary even on JMR3927 which has 3
> timers). Although, if the timer isn't auto-reloading (I assume it
> isn't), the trick shouldn't be needed.

Indeed.  JMR3927 is not good for reference on writing new code.

Though I do not know the PNX8550 timer details, if writing to the
COMPARE reset the COUNTER or COUNTER wrapped to zero at a value in
COMPARE, perhaps we can not use c0_hpt_read for clocksource.

---
Atsushi Nemoto
