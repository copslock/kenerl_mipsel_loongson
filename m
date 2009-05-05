Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2009 17:11:47 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:61002 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022385AbZEEQLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 May 2009 17:11:41 +0100
Received: from localhost (p8102-ipad210funabasi.chiba.ocn.ne.jp [58.88.127.102])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5E826AAB7; Wed,  6 May 2009 01:11:35 +0900 (JST)
Date:	Wed, 06 May 2009 01:11:24 +0900 (JST)
Message-Id: <20090506.011124.260797104.anemo@mba.ocn.ne.jp>
To:	geert@linux-m68k.org
Cc:	linux-mips@linux-mips.org
Subject: Re: rbtx4927 and sound?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <10f740e80905040945i186e995ap1ecb43c2ad3e2458@mail.gmail.com>
References: <10f740e80905040945i186e995ap1ecb43c2ad3e2458@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 4 May 2009 18:45:09 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Did anyone ever try to get sound working on the Toshiba RBTX4927?
> It seems the AD1881A codec is connected to PIO2-4 of the TMPR4927 SoC.

I'm writing a ASoC driver for TXx9 ACLC based on (non-ASoC) driver in
RBTX49xx patch from CELF Patch Archive [1].

I can send it if you want to try, though it is still under debugging.
This driver depends on DMAC driver in linux-mips queue tree [2].

[1] http://tree.celinuxforum.org/CelfPubWiki/PatchArchive
[2] http://www.linux-mips.org/git?p=linux-queue.git
---
Atsushi Nemoto
