Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 17:16:40 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50637 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573816AbXBRRQf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2007 17:16:35 +0000
Received: from localhost (p2027-ipad11funabasi.chiba.ocn.ne.jp [219.162.37.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id D9192B7C2
	for <linux-mips@linux-mips.org>; Mon, 19 Feb 2007 02:15:14 +0900 (JST)
Date:	Mon, 19 Feb 2007 02:15:15 +0900 (JST)
Message-Id: <20070219.021515.118967791.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: fadvise on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070217.004812.03978264.anemo@mba.ocn.ne.jp>
References: <20070217.004329.108739438.anemo@mba.ocn.ne.jp>
	<20070217.004812.03978264.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 Feb 2007 00:48:12 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > 2) On O32, glibc pass a 'long long' argument by hi and lo words, but
> > kernel needs padding word between 'fd' and 'offset' argument.
> > 
> > 3) On N32, glibc pass a 'long long' argument by hi and lo words, but
> > kernel expects a single register value for 'long long' argument.
> 
> And sync_file_range() has some problem too.

Hmm, for other system calls with long long argument, such as
ftruncate64, glibc and uClibc provides mips specific version just for
insert a padding argument.

This is a general rule?  Or for new system call, we can do that
adjustment in kernel to avoid fixing each C libraries?

---
Atsushi Nemoto
