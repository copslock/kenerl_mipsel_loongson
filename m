Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2003 02:09:54 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:55812
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225217AbTHHBJv>; Fri, 8 Aug 2003 02:09:51 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 8 Aug 2003 01:09:50 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h7819YDV094347;
	Fri, 8 Aug 2003 10:09:35 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 08 Aug 2003 10:11:02 +0900 (JST)
Message-Id: <20030808.101102.71082885.nemoto@toshiba-tops.co.jp>
To: ica2_ts@csv.ica.uni-stuttgart.de
Cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030807231518.GH3759@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030807.190330.26271096.nemoto@toshiba-tops.co.jp>
	<20030807231518.GH3759@rembrandt.csv.ica.uni-stuttgart.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 8 Aug 2003 01:15:18 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
Thiemo> It shouldn't trigger for 32bit, because 0x80000000 is a
Thiemo> sign-extended 32bit number. How is mips-linux-as actually
Thiemo> invoked?

Like this (using mipsel):

$ mipsel-linux-gcc -o b.o -c -v b.S
Reading specs from /usr/lib/gcc-lib/mipsel-linux/3.3/specs
Configured with: ../gcc-3.3/configure --target=mipsel-linux --prefix=/usr --disable-nls --enable-languages=c --disable-shared --disable-threads
Thread model: single
gcc version 3.3
 /usr/lib/gcc-lib/mipsel-linux/3.3/cc1 -E -lang-asm -quiet -v -D__GNUC__=3 -D__GNUC_MINOR__=3 -D__GNUC_PATCHLEVEL__=0 b.S -o /tmp/cceVg6Jo.s
ignoring nonexistent directory "/usr/mipsel-linux/sys-include"
ignoring nonexistent directory "/usr/mipsel-linux/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/lib/gcc-lib/mipsel-linux/3.3/include
End of search list.
 /usr/lib/gcc-lib/mipsel-linux/3.3/../../../../mipsel-linux/bin/as -EL -g0 -32 -v -KPIC -o b.o /tmp/cceVg6Jo.s
GNU assembler version 2.14 (mipsel-linux) using BFD version 2.14 20030612
b.S: Assembler messages:
b.S:1: Error: load/store address overflow (max 32 bits)

The b.S is just one line "lw $2, 0x80000000".

Just typing "mipsel-linux-as -o b.o b.S" produces same error.

---
Atsushi Nemoto
