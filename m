Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Nov 2005 17:35:32 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:44226 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133450AbVKSRfM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Nov 2005 17:35:12 +0000
Received: from localhost (p1084-ipad205funabasi.chiba.ocn.ne.jp [222.146.96.84])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 205F5AA9D; Sun, 20 Nov 2005 02:37:31 +0900 (JST)
Date:	Sun, 20 Nov 2005 02:36:41 +0900 (JST)
Message-Id: <20051120.023641.41197425.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	maillist@jg555.com, kumba@gentoo.org, linux-mips@linux-mips.org,
	pdh@colonel-panic.org
Subject: mips iomap.c (Was: Re: MIPS - 64bit woes)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051118172948.GE2707@linux-mips.org>
References: <20051118171706.GD2707@linux-mips.org>
	<437E0E68.7010008@jg555.com>
	<20051118172948.GE2707@linux-mips.org>
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
X-archive-position: 9525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 18 Nov 2005 17:29:48 +0000, Ralf Baechle <ralf@linux-mips.org> said:

ralf> No.  It's broken for machines with multiple PCI busses and I've
ralf> explicitly rejected the patch which is in kernel.org before.

Could you explain a bit _how_ broken current kernel.org's
arch/mips/lib/iomap.c ?  Is it a single mips_io_port_base issue?

I suppose it works as well as traditional way (request_region +
in[bwl] for IO resource, request_mem_region + iomap + read[bwl] for
MEM resource).

I think it is better than generic iomap.c (except that
ioremap_cacheable_cow which is not available for R3000 is used).

---
Atsushi Nemoto
