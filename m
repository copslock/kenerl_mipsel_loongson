Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 14:57:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:28125 "EHLO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with ESMTP id S8133576AbVJGN5D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2005 14:57:03 +0100
Received: from localhost (p8236-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id C162620E1;
	Fri,  7 Oct 2005 22:56:59 +0900 (JST)
Date:	Fri, 07 Oct 2005 22:55:44 +0900 (JST)
Message-Id: <20051007.225544.41197582.anemo@mba.ocn.ne.jp>
To:	sjhill@realitydiluted.com
Cc:	john.cooper@timesys.com, ralf@linux-mips.org,
	greg.weeks@timesys.com, linux-mips@linux-mips.org
Subject: Re: PREEMPT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E1ENakd-0005up-Pl@real.realitydiluted.com>
References: <43457563.60505@timesys.com>
	<E1ENakd-0005up-Pl@real.realitydiluted.com>
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
X-archive-position: 9181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 6 Oct 2005 13:45:55 -0500 (CDT), sjhill@realitydiluted.com said:

sjhill> Um, did no one have a look at Atsushi Nemoto's patch earlier
sjhill> today that addressed pre-emption and CPU1, or am I missing
sjhill> something?

The patch I posted yesterday affects just for ptrace.  I suppose this
is not irrelevant.

Also, though it might irrelevant too, I think there are still possible
bug related signal and fpu_context.  I'll post a patch again.

---
Atsushi Nemoto
