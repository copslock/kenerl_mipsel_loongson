Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 16:08:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:1479 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225202AbTDOPIp>; Tue, 15 Apr 2003 16:08:45 +0100
Received: from localhost (p6041-ip02funabasi.chiba.ocn.ne.jp [219.96.148.41])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 55AD8112D; Wed, 16 Apr 2003 00:08:36 +0900 (JST)
Date: Wed, 16 Apr 2003 00:15:09 +0900 (JST)
Message-Id: <20030416.001509.59462441.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp, linux-mips@linux-mips.org
Subject: Re: End c-tx49.c's misserable existence
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030414174825.A9808@linux-mips.org>
References: <20030414055038.A29923@linux-mips.org>
	<20030414.152903.41628304.nemoto@toshiba-tops.co.jp>
	<20030414174825.A9808@linux-mips.org>
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
X-archive-position: 2060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 14 Apr 2003 17:48:25 +0200, Ralf Baechle <ralf@linux-mips.org> said:

>> One more request.  Please enclose R4600_V1_HIT_CACHEOP_WAR and
>> R4600_V2_HIT_CACHEOP_WAR with appropriate CONFIG_CPU_XXX.  I do not
>> know what CPUs need this workaround... (at least TX49 does not need
>> this)

ralf> I'll leave it unconditionally enabled for now because the
ralf> Makefiles could behave in undefined ways if multiple
ralf> CONFIG_CPU_* options are selected and quite a few systems
ralf> support both the R4600 and other processors like the Indy.
ralf> Another day.

I have been misunderstood that people who needs the workaround always
select CONFIG_CPU_R4X00.  But it is not true.  Now I understand.

But recent reorganization increased a number of c-r4k.c users
somewhat.  How about introducing new config macros such as
CONFIG_R4600_V1_WORKAROUNDS ?

---
Atsushi Nemoto
