Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2004 14:53:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:63428 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225254AbUIYNxs>; Sat, 25 Sep 2004 14:53:48 +0100
Received: from localhost (p8149-ipad01funabasi.chiba.ocn.ne.jp [61.207.82.149])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C322D7F01; Sat, 25 Sep 2004 22:53:44 +0900 (JST)
Date: Sat, 25 Sep 2004 23:03:41 +0900 (JST)
Message-Id: <20040925.230341.74756845.anemo@mba.ocn.ne.jp>
To: Filip@Linux4.Be
Cc: linux-mips@linux-mips.org
Subject: Re: "Can't analyze prologue code ..." at boot time
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <41549C74.3090309@Linux4.Be>
References: <20040924.190640.09669815.nemoto@toshiba-tops.co.jp>
	<20040924121107.GB24730@enix.org>
	<41549C74.3090309@Linux4.Be>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sat, 25 Sep 2004 00:15:16 +0200, Filip Onkelinx <Filip@Linux4.Be> said:

Filip> I just applied your patch to our current 2.6.9-rc2 kernel for
Filip> the BE300 project (Casio BE300/BE500 PDA with NEC vr4131
Filip> rev1.2), and the "Couldn't analyze prologue code .." message is
Filip> gone as well.

Good to hear that.

Filip> Before, the kernel was very unreliable, but I also sync'ed with
Filip> the latest from CVS and switched gcc version , so I'm not sure
Filip> if it is your patch that's responsible for the stabiltity or
Filip> one of the other changes.

I'm pretty sure it is not my patch.  The problem fixed by my patch
should not be a so fatal.  Congratulation anyway.

---
Atsushi Nemoto
