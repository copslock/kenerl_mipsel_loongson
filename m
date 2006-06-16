Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 17:58:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35520 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8134029AbWFPQ6o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2006 17:58:44 +0100
Received: from localhost (p7155-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7BB099AB2; Sat, 17 Jun 2006 01:58:39 +0900 (JST)
Date:	Sat, 17 Jun 2006 01:59:42 +0900 (JST)
Message-Id: <20060617.015942.63131409.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	dan@debian.org, macro@linux-mips.org
Subject: Re: mips RDHWR instruction in glibc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060617.005845.93020013.anemo@mba.ocn.ne.jp>
References: <20060616.002837.59465125.anemo@mba.ocn.ne.jp>
	<20060615153252.GA21598@nevyn.them.org>
	<20060617.005845.93020013.anemo@mba.ocn.ne.jp>
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
X-archive-position: 11748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 Jun 2006 00:58:45 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> It looks too bad for arg == 0 case.  I should ask on gcc list.

OTOH, I think it would be better to reduce RDHWR overhead in kernel
anyway.

I've heard about "fastpath" approach by Maciej, but now I can not find
the patch on linux-mips ML archive.  Is it available on somewhere?  Maciej?

---
Atsushi Nemoto
