Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 16:03:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:19966 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022730AbXICPDj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2007 16:03:39 +0100
Received: from localhost (p7196-ipad03funabasi.chiba.ocn.ne.jp [219.160.87.196])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 55A11E231
	for <linux-mips@linux-mips.org>; Tue,  4 Sep 2007 00:03:36 +0900 (JST)
Date:	Tue, 04 Sep 2007 00:05:01 +0900 (JST)
Message-Id: <20070904.000501.41013092.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org>
References: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org>
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
X-archive-position: 16357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 07 Aug 2007 17:27:37 +0100, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Tue Aug 7 17:18:28 2007 +0100
> Commit: 00cc123703425aa362b0af75616134cbad4e0689
> Gitweb: http://www.linux-mips.org/g/linux/00cc1237
> Branch: master

With this commit, ide_default_io_base(0) and ide_default_io_base(1)
always returns non-zero value so some platform ide driver (such as
ide/mips/swarm.c) may be assigned to ide2, instead of ide0.

It seems restoreing the pci_get_class() checking would revert the old
behavior, but I cannot see whole story of SMTC vs. ide_default_io_base().

Why pci_get_class() in ide_default_io_base() cause crash on SMTC?

---
Atsushi Nemoto
