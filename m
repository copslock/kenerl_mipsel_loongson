Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2004 14:40:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:45013 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225555AbUGANke>; Thu, 1 Jul 2004 14:40:34 +0100
Received: from localhost (p6018-ipad28funabasi.chiba.ocn.ne.jp [220.107.205.18])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 78E307346; Thu,  1 Jul 2004 22:40:30 +0900 (JST)
Date: Thu, 01 Jul 2004 22:45:35 +0900 (JST)
Message-Id: <20040701.224535.71082878.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 pci_dma_sync_sg fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040701132240.GA6219@linux-mips.org>
References: <20040701.222120.41626500.anemo@mba.ocn.ne.jp>
	<20040701132240.GA6219@linux-mips.org>
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
X-archive-position: 5391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 1 Jul 2004 15:22:40 +0200, Ralf Baechle <ralf@linux-mips.org> said:

ralf> Leave the #ifdef stuff there - or otherwise gcc might optimize
ralf> this into empty loops ...

The loop contains paranoid out_of_line_bug, so it never be optimized
to empty.

---
Atsushi Nemoto
