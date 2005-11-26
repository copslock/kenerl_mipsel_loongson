Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Nov 2005 16:14:08 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:22010 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133637AbVKZQNu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Nov 2005 16:13:50 +0000
Received: from localhost (p1238-ipad202funabasi.chiba.ocn.ne.jp [222.146.72.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1393AA217; Sun, 27 Nov 2005 01:16:51 +0900 (JST)
Date:	Sun, 27 Nov 2005 01:16:04 +0900 (JST)
Message-Id: <20051127.011604.41198575.anemo@mba.ocn.ne.jp>
To:	dan@debian.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix gdb-stub for kernel compiled with higher ISA level
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051125192742.GA6013@nevyn.them.org>
References: <20051124.165043.112050815.nemoto@toshiba-tops.co.jp>
	<20051125192742.GA6013@nevyn.them.org>
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
X-archive-position: 9555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 25 Nov 2005 14:27:42 -0500, Daniel Jacobowitz <dan@debian.org> said:

dan> FYI, it is a known limitation in GDB that it can't cope with
dan> either format, and I hope to fix it sometime soon.  It's
dan> definitely a bug that it expects 64-bit registers for mips3
dan> 32-bit binaries; I think the change in question was crazy...

dan> You can "set architecture mips:isa32" before connecting to get
dan> around this.

Thank you for the information.  Then I revoke this patch.

Ralf, please ignore this patch.  (And please apply my another gdb-stub
patch which is just fix a build error ...)

---
Atsushi Nemoto
