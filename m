Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 15:49:51 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:35783 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224908AbUJSOtn>; Tue, 19 Oct 2004 15:49:43 +0100
Received: from localhost (p1242-ipad30funabasi.chiba.ocn.ne.jp [221.184.76.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id DD3974723
	for <linux-mips@linux-mips.org>; Tue, 19 Oct 2004 23:49:36 +0900 (JST)
Date: Tue, 19 Oct 2004 23:51:29 +0900 (JST)
Message-Id: <20041019.235129.25480859.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Subject: kmalloc alignment
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 6101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

In include/asm-mips/cache.h:

#define ARCH_KMALLOC_MINALIGN	8

Is this line really needed?

If it was not defined (and ARCH_KMALLOC_FLAGS was also not defined),
default alignment (cache_line_size()) will be used for kmalloc.  It is
enough, isn't it?

Also, with current 8 byte alignment, many PCI drivers which are using
kmalloc and dma_map_single are broken on non-coherent system.  I was
told that those drivers should use dma_get_cache_alignment() API, but
currently nobody do it anyway.  Removing ARCH_KMALLOC_MINALIGN will
help those (broken?) drivers.

---
Atsushi Nemoto
