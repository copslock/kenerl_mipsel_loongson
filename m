Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 17:17:19 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:63434 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3465649AbWBBRRB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 17:17:01 +0000
Received: from localhost (p4005-ipad24funabasi.chiba.ocn.ne.jp [220.104.82.5])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2189DB070; Fri,  3 Feb 2006 02:22:10 +0900 (JST)
Date:	Fri, 03 Feb 2006 02:21:50 +0900 (JST)
Message-Id: <20060203.022150.130238538.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060203.020428.59032357.anemo@mba.ocn.ne.jp>
References: <Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl>
	<20060202165656.GC17352@linux-mips.org>
	<20060203.020428.59032357.anemo@mba.ocn.ne.jp>
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
X-archive-position: 10312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 03 Feb 2006 02:04:28 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> However, It can be more readable since we can safely mask
anemo> bit[5:1] (as local_irq_enable() does).  Like this:

Correction: bit[4:1] (0x1e)
