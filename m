Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 16:13:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:44541 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225072AbTHLPNa>; Tue, 12 Aug 2003 16:13:30 +0100
Received: from localhost (p0964-ip01funabasi.chiba.ocn.ne.jp [61.119.148.202])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id CAC5421A5
	for <linux-mips@linux-mips.org>; Wed, 13 Aug 2003 00:13:23 +0900 (JST)
Date: Wed, 13 Aug 2003 00:26:44 +0900 (JST)
Message-Id: <20030813.002644.59461513.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030812101625.GJ23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de>
	<20030812.190636.39150536.nemoto@toshiba-tops.co.jp>
	<20030812101625.GJ23104@rembrandt.csv.ica.uni-stuttgart.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 12 Aug 2003 12:16:25 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:

>> Does anybody know why __BUILD_clear_ade uses MFC0 and REG_S
>> though other parts using mfc0 and sw ?

Thiemo> Probably because BADVADDR has to be 64bit for 64bit
Thiemo> kernels. :-)

If so, MFC0 and REG_S should be controlled by __mips64 (or
CONFIG_MIPS64) as you and Maciej W. Rozycki said in other mails.  I
wonder why currently is not.  Historical reason ? :-)

Now I'm looking 2.6 codes and there is same problem.  But 2.6 codes
does not use REG_S at all so the stack corruption will never happen.
FYI.

--- Atsushi Nemoto
