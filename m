Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 15:06:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:10699 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225425AbTIROGq>; Thu, 18 Sep 2003 15:06:46 +0100
Received: from localhost (p0341-ip01funabasi.chiba.ocn.ne.jp [211.130.235.87])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3170B3FBC; Thu, 18 Sep 2003 23:06:37 +0900 (JST)
Date: Thu, 18 Sep 2003 23:22:02 +0900 (JST)
Message-Id: <20030918.232202.07646481.anemo@mba.ocn.ne.jp>
To: macro@ds2.pg.gda.pl
Cc: linux-mips@linux-mips.org
Subject: Re: mips64 cpu-probe.c compile failure
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.3.96.1030918121138.15508B-100000@delta.ds2.pg.gda.pl>
References: <20030918.180536.08320519.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.3.96.1030918121138.15508B-100000@delta.ds2.pg.gda.pl>
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
X-archive-position: 3204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 18 Sep 2003 12:17:54 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:

macro>  I wanted to avoid that as the resulting code would be ugly.  I
macro> guess there is no other choice, although I think that's a bug
macro> in gcc.

I have no idea that is a gcc bug, but I think align_mod() inline
function is not so beautiful because it can not be compiled anyway if
non-constant value was passed.

macro>  Can you quote the exact command line used for building the
macro> file?

mips64el-linux-gcc -D__KERNEL__ -I/home/anemo/work/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I /home/anemo/work/linux/include/asm/gcc -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe  -march=r4600   -nostdinc -iwithprefix include -DKBUILD_BASENAME=cpu_probe  -c -o cpu-probe.o cpu-probe.c

I also tried with -finline-limit=100000 but no luck.

Does this help?

---
Atsushi Nemoto
