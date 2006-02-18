Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 13:00:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:10210 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133519AbWBRNAb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2006 13:00:31 +0000
Received: from localhost (p7103-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.103])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9CC1EAEF7; Sat, 18 Feb 2006 22:07:12 +0900 (JST)
Date:	Sat, 18 Feb 2006 22:07:01 +0900 (JST)
Message-Id: <20060218.220701.25910111.anemo@mba.ocn.ne.jp>
To:	tbm@cyrius.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Oops with git: do_signal32 on 64-bit
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060217225216.GA15781@deprecation.cyrius.com>
References: <20060217191937.GA20521@deprecation.cyrius.com>
	<20060217225216.GA15781@deprecation.cyrius.com>
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
X-archive-position: 10509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 17 Feb 2006 22:52:16 +0000, Martin Michlmayr <tbm@cyrius.com> said:

tbm> And the same do_signal32 problem on IP22 with current git.  I
tbm> quickly tried reverting some of the recent signal changes but
tbm> that didn't help and I've no time to investigate properly right
tbm> now.  Maybe someone else can take a look.  (Unsurprisingly, rc2
tbm> works whereas rc3 and current git don't.)

It seems following commit on 8 Feb broke signal32.c.

    [MIPS] Add support for TIF_RESTORE_SIGMASK.

Obviously do_signal32() was not synced.  I can not fix it by myself
for a few days.  Someone?

---
Atsushi Nemoto
