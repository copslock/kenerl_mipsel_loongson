Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 17:30:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:43765 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021424AbXFAQ36 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2007 17:29:58 +0100
Received: from localhost (p8230-ipad205funabasi.chiba.ocn.ne.jp [222.146.103.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 43258ACE2; Sat,  2 Jun 2007 01:29:55 +0900 (JST)
Date:	Sat, 02 Jun 2007 01:30:22 +0900 (JST)
Message-Id: <20070602.013022.52128810.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Fix modpost warnings by making start_secondary __cpuinit
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S28573756AbXEaP7t/20070531155949Z+115@ftp.linux-mips.org>
References: <S28573756AbXEaP7t/20070531155949Z+115@ftp.linux-mips.org>
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
X-archive-position: 15221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 31 May 2007 16:59:44 +0100, linux-mips@linux-mips.org wrote:
> WARNING: arch/mips/kernel/built-in.o(.text+0x9a58): Section mismatch: reference to .init.text:cpu_report (between 'start_secondary' and 'smp_prepare_boot_cpu')

Looking at arch/mips/kernel/smp.c, I suppose there should be much more
functions to be marked as __cpuinit.  For example,
prom_init_secondary(), prom_smp_finish(), prom_smp_finish(),
prom_boot_secondary(), etc.

And then, smtc_init_secondary(), smtc_smp_finish(), etc. ...

---
Atsushi Nemoto
