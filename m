Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 16:32:25 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:1260 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8134409AbWASQcA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 16:32:00 +0000
Received: from localhost (p1188-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.188])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9F04D8689; Fri, 20 Jan 2006 01:35:46 +0900 (JST)
Date:	Fri, 20 Jan 2006 01:35:19 +0900 (JST)
Message-Id: <20060120.013519.25910221.anemo@mba.ocn.ne.jp>
To:	maillist@jg555.com
Cc:	ralf@linux-mips.org, tbm@cyrius.com, pdh@colonel-panic.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/1] 64-bit fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43CE821A.6060004@jg555.com>
References: <20060117135145.GE3336@linux-mips.org>
	<20060117.232350.93019515.anemo@mba.ocn.ne.jp>
	<43CE821A.6060004@jg555.com>
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
X-archive-position: 9998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 18 Jan 2006 09:59:54 -0800, Jim Gifford <maillist@jg555.com> said:

jim> We all need to understand the concerns with the current
jim> method. The only issue I see from Ralf is the following:

jim>     Broken on multiple PCI busses.

Yes, it is an only reason I have ever seen.

jim>     Now the way I understand the issue is the current iomap.c
jim> only handles a single bus, Ralf's point is that if there are
jim> multiple busses this patch may not work properly. Is that a
jim> correct statement Ralf.

I think the current iomap can handle multiple busses.

The traditional way (ioremap + read[bwl] for memory space and in[bwl]
for IO space) can be used on multiple PCI busses if pci resources were
properly configured.  (Though IO space address might be a bit strange
value due to single global mips_io_port_base, it works anyway.)  The
current iomap basically do same jobs.

---
Atsushi Nemoto
