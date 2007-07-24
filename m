Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 16:11:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:2496 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023079AbXGXPLB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 16:11:01 +0100
Received: from localhost (p1202-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.202])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 367F0A347; Wed, 25 Jul 2007 00:10:57 +0900 (JST)
Date:	Wed, 25 Jul 2007 00:11:59 +0900 (JST)
Message-Id: <20070725.001159.59652243.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix marge error due to conflict in
 arch/mips/kernel/head.S
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070724150332.GA20621@linux-mips.org>
References: <20070723.000734.08075709.anemo@mba.ocn.ne.jp>
	<20070724150332.GA20621@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jul 2007 16:03:32 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > __INIT directive just before kernel_entry was dropped for most
> > (i.e. BOOT_RAW=n) platforms by merge accident (perhaps).  This patch
> > fixes it and get rid of this warning:
> 
> Whatever the reason - applied.

Thanks.  And now MIPSsim and PMC MSP would see the warning :)
I'm looking for a workaround ...

---
Atsushi Nemoto
