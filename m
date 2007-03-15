Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 01:36:07 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:24977 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022505AbXCOBfl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Mar 2007 01:35:41 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 15 Mar 2007 10:35:40 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 047064205B;
	Thu, 15 Mar 2007 10:35:17 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E3F00202BC;
	Thu, 15 Mar 2007 10:35:16 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2F1ZBW0028999;
	Thu, 15 Mar 2007 10:35:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 15 Mar 2007 10:35:11 +0900 (JST)
Message-Id: <20070315.103511.89758184.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, kraj@mvista.com, libc-ports@sourceware.org
Subject: Re: [PATCH] Fix some system calls with long long arguments
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070309.003749.39154822.anemo@mba.ocn.ne.jp>
References: <20070307.003931.25235381.anemo@mba.ocn.ne.jp>
	<20070307.231410.15268922.anemo@mba.ocn.ne.jp>
	<20070309.003749.39154822.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 09 Mar 2007 00:37:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > fadvise64(), readahead(), sync_file_range() have long long argument(s)
> > but glibc passes it by hi/lo pair without padding, on both O32 and
> > N32.
> > 
> > Also wire up fadvise64_64() and fixup confusion of it with
> > fadvise64().
> 
> If best performance was preferred, the O32 readahead and
> sync_file_range should not changed and libc should provide MIPS
> specific syscall wrappers, like pread64.  The N32 can also use
> standard sys_readahead(), etc. and libc should provide wrappers, too.
> 
> Anyway fadvice64() needs to be fixed.
> 
> Any comments from libc side?  Original patch is here:
> http://www.linux-mips.org/archives/linux-mips/2007-03/msg00092.html

Any comments?

I think this patch has less maintainance cost but a little bit slow.

These syscalls can be a little bit faster, but needs more works on
glibc (and uClibc, etc.) side.

Anyway we should take some action while current implementation is
broken (except N64).

Which is a way to go?

---
Atsushi Nemoto
