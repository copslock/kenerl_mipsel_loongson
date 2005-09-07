Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 15:48:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:14803 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225274AbVIGOsk>; Wed, 7 Sep 2005 15:48:40 +0100
Received: from localhost (p5166-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 420A485BF; Wed,  7 Sep 2005 23:55:37 +0900 (JST)
Date:	Wed, 07 Sep 2005 23:56:49 +0900 (JST)
Message-Id: <20050907.235649.96687998.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050907.234413.108737010.anemo@mba.ocn.ne.jp>
References: <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl>
	<20050907134717.GA3493@linux-mips.org>
	<20050907.234413.108737010.anemo@mba.ocn.ne.jp>
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
X-archive-position: 8891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 07 Sep 2005 23:44:13 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> My fix #2 is more generic approach, but even with the fix, the
anemo> test program eats CPU until killed by SIGKILL.  With my fix #1,
anemo> the test program will exit immediately.

Oh, I forgot to say: my fix #1 will not work on 64bit kernel due to
another problem.  I posted a patch for it a few days ago.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20050901.011551.96687558.anemo%40mba.ocn.ne.jp

Please apply this first.  Thank you.

---
Atsushi Nemoto
