Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 15:05:34 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:5835 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022491AbXJ1PFY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2007 15:05:24 +0000
Received: from localhost (p8247-ipad201funabasi.chiba.ocn.ne.jp [222.146.71.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 05DC99C4A; Mon, 29 Oct 2007 00:05:18 +0900 (JST)
Date:	Mon, 29 Oct 2007 00:07:13 +0900 (JST)
Message-Id: <20071029.000713.59464443.anemo@mba.ocn.ne.jp>
To:	giuseppe@eppesuigoccas.homedns.org
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.4.24-rc1 does not boot on SGI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1193468825.7474.6.camel@scarafaggio>
References: <1193468825.7474.6.camel@scarafaggio>
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
X-archive-position: 17260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 27 Oct 2007 09:07:05 +0200, Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> wrote:
> The new kernel once again does not boot on SGI O2. What happens is that
> arcboot write its messages and nothing more is displayed on the screen.
> The last message is "Starting ELF64 kernel". The previous running kernel
> were 2.6.23 from linux-mips.org and 2.6.23.1 from kernel.org.
> 
> Does anyone have a suggestion about what to look for? I will start
> looking at all diffs in arch/mips/sgi-ip32.

Could you try this one?

http://www.linux-mips.org/archives/linux-mips/2007-10/msg00431.html

I suppose currently all 64-bit platforms which use cevt-r4k.c are
broken.

---
Atsushi Nemoto
