Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Nov 2004 12:37:36 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:32460 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224931AbUKFMhb>; Sat, 6 Nov 2004 12:37:31 +0000
Received: from localhost (p7216-ipad29funabasi.chiba.ocn.ne.jp [221.184.74.216])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 69B1684B6; Sat,  6 Nov 2004 21:37:23 +0900 (JST)
Date: Sat, 06 Nov 2004 21:40:18 +0900 (JST)
Message-Id: <20041106.214018.74755085.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Cc: rsandifo@redhat.com, ralf@linux-mips.org
Subject: Re: failed to merge string constant? (gcc 3.4.2 + binutils 2.15)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041029.225817.76758438.nemoto@toshiba-tops.co.jp>
References: <20041029.225817.76758438.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 6272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 29 Oct 2004 22:58:17 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> I have some strange kernel panic with gcc 3.4.2 + binutils
anemo> 2.15.  Address of some string constant seems broken.
...
anemo> If I compiled kernel with -fno-merge-constants, this problem
anemo> does not happen.  gcc 3.3.4 + bintuils 2.15 also works fine.

It has been fixed in binutils CVS.  I tried with binutils 2.15.92.0.2
and it works.

---
Atsushi Nemoto
