Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Apr 2005 15:35:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:57567 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8226060AbVD3Ofc>; Sat, 30 Apr 2005 15:35:32 +0100
Received: from localhost (p2095-ipad22funabasi.chiba.ocn.ne.jp [220.104.80.95])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BC8857D9F; Sat, 30 Apr 2005 23:35:26 +0900 (JST)
Date:	Sat, 30 Apr 2005 23:36:51 +0900 (JST)
Message-Id: <20050430.233651.25908949.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: preempt safe fpu-emulator
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050428134118.GC1276@linux-mips.org>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp>
	<20050428134118.GC1276@linux-mips.org>
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
X-archive-position: 7841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 28 Apr 2005 14:41:18 +0100, Ralf Baechle <ralf@linux-mips.org> said:

ralf> I applied both your patches with some slight cleanup for the
ralf> endianess stuff in arch/mips/math-emu/ieee754.h and non-Linux
ralf> stuff.

Thanks.  Since the fpu emulator run without FPU ownership now, the
patch I posted a few weeks ago is necessary to emulate cp1 branch
instructions.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20050420.165320.42204293.nemoto%40toshiba-tops.co.jp

Please apply this also.  Thank you.
---
Atsushi Nemoto
