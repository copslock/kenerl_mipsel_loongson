Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2003 05:03:45 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:33035
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224939AbTLAFDo>; Mon, 1 Dec 2003 05:03:44 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 1 Dec 2003 05:04:15 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hB1545nd029154
	for <linux-mips@linux-mips.org>; Mon, 1 Dec 2003 14:04:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 01 Dec 2003 14:07:01 +0900 (JST)
Message-Id: <20031201.140701.59648708.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20031107.015421.55515336.anemo@mba.ocn.ne.jp>
References: <20031104.200222.70226623.nemoto@toshiba-tops.co.jp>
	<1067968386.3491.7.camel@ghostwheel.sfbay.redhat.com>
	<20031107.015421.55515336.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 07 Nov 2003 01:54:21 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> My problem is runtime failure, not link error.  So it may be a
anemo> different problem.

My problem was solved by recent fix in binutils.

The patch is:

http://sources.redhat.com/ml/binutils/2003-11/msg00469.html

and is already in binutils CVS.  Thank you.

---
Atsushi Nemoto
