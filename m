Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2003 15:53:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:29400 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224802AbTHHOxA>; Fri, 8 Aug 2003 15:53:00 +0100
Received: from localhost (p4124-ip02funabasi.chiba.ocn.ne.jp [61.112.102.124])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A25B12E9D; Fri,  8 Aug 2003 23:52:56 +0900 (JST)
Date: Sat, 09 Aug 2003 00:06:03 +0900 (JST)
Message-Id: <20030809.000603.74756723.anemo@mba.ocn.ne.jp>
To: ica2_ts@csv.ica.uni-stuttgart.de
Cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030808030705.GJ3759@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030807231518.GH3759@rembrandt.csv.ica.uni-stuttgart.de>
	<20030808.101102.71082885.nemoto@toshiba-tops.co.jp>
	<20030808030705.GJ3759@rembrandt.csv.ica.uni-stuttgart.de>
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
X-archive-position: 3009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 8 Aug 2003 05:07:05 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
>> The b.S is just one line "lw $2, 0x80000000".
Thiemo> Using 0xffffffff80000000 is a really ugly workaround for it.
Thiemo> Seems like the constant isn't properly sign-extended inernally
Thiemo> by the assembler.

Yes the workaround works.  But I modified binutils (just remove the
checking code) instead of changing many constant definitions in my
programs.  For now it is enough for me.  Thank you.
---
Atsushi Nemoto
