Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 14:21:09 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:19908 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3465592AbWAQOUo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 14:20:44 +0000
Received: from localhost (p4109-ipad209funabasi.chiba.ocn.ne.jp [58.88.115.109])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 61574A2FB; Tue, 17 Jan 2006 23:24:18 +0900 (JST)
Date:	Tue, 17 Jan 2006 23:23:50 +0900 (JST)
Message-Id: <20060117.232350.93019515.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	maillist@jg555.com, tbm@cyrius.com, pdh@colonel-panic.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/1] 64-bit fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060117135145.GE3336@linux-mips.org>
References: <20060116154543.GA26771@deprecation.cyrius.com>
	<43CBCAAE.6030403@jg555.com>
	<20060117135145.GE3336@linux-mips.org>
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
X-archive-position: 9936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 17 Jan 2006 13:51:45 +0000, Ralf Baechle <ralf@linux-mips.org> said:

>> This include the iomap.c, which is not accepted by Ralf.

ralf> Yes - and the reasons are archived on this list.  Reposting the
ralf> patch leaves me entirely unimpressed.

Ralf, is this the reason?

> Subject: Re: MIPS - 64bit woes
> From: Ralf Baechle <ralf@linux-mips.org>
> Date:	Fri, 18 Nov 2005 17:29:48 +0000
> 
> No.  It's broken for machines with multiple PCI busses and I've explicitly
> rejected the patch which is in kernel.org before.

It seems a bit obscured for me --- and perhaps for some other people.
So I asked:

> Subject: mips iomap.c (Was: Re: MIPS - 64bit woes)
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Date:	Sun, 20 Nov 2005 02:36:41 +0900 (JST)
> 
> Could you explain a bit _how_ broken current kernel.org's
> arch/mips/lib/iomap.c ?  Is it a single mips_io_port_base issue?
> 
> I suppose it works as well as traditional way (request_region +
> in[bwl] for IO resource, request_mem_region + iomap + read[bwl] for
> MEM resource).
> 
> I think it is better than generic iomap.c (except that
> ioremap_cacheable_cow which is not available for R3000 is used).

But got no response at that time.  So I ask again.  Could you tell us
how the iomap patch broken verbosely, please?

---
Atsushi Nemoto
