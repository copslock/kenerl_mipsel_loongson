Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 04:29:32 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:47876
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225202AbTDND3Z>; Mon, 14 Apr 2003 04:29:25 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 14 Apr 2003 03:29:23 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.8/8.12.8) with ESMTP id h3E3TD2D002194;
	Mon, 14 Apr 2003 12:29:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 14 Apr 2003 12:35:14 +0900 (JST)
Message-Id: <20030414.123514.74756574.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: End c-tx49.c's misserable existence
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20030412163215Z8225197-1272+1264@linux-mips.org>
References: <20030412163215Z8225197-1272+1264@linux-mips.org>
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
X-archive-position: 2014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sat, 12 Apr 2003 17:32:09 +0100, ralf@linux-mips.org said:
ralf> Modified files:
ralf> 	include/asm-mips: Tag: linux_2_4 war.h 
ralf> 	include/asm-mips64: Tag: linux_2_4 war.h 
ralf> 	arch/mips/mm   : Tag: linux_2_4 Makefile c-r4k.c 
ralf> 	arch/mips64/mm : Tag: linux_2_4 c-r4k.c 
ralf> Removed files:
ralf> 	arch/mips/mm   : Tag: linux_2_4 c-tx49.c 

ralf> Log message:
ralf> 	End c-tx49.c's misserable existence and move it into c-r4k.c.

I'm happy to see this change and have one more request.

TOSHIBA_ICACHE_WAR can be removed.  This workaround is not needed
if kernel does not modify the cache codes itself in run-time.

When I wrote c-tx49.c I blindly followed the statement in TX49/H2
manual's statement. ("If the instruction (i.e. CACHE) is issued for
the line which this instruction itself exists, the following operation
is not guaranteed.")  Now I know this warning is only for
self-modified code.  There must be no problem if the codes is not
modified in run-time.  So please remove all TOSHIBA_ICACHE_WAR stuff
and make c-r4k.c more clean.

Thank you.
---
Atsushi Nemoto
The old PGP key (ID B6D728B1) has been revoked.  New key ID is 2874D52F.
