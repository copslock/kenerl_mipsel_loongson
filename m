Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2007 15:39:16 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14785 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021756AbXCHPjL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Mar 2007 15:39:11 +0000
Received: from localhost (p8013-ipad201funabasi.chiba.ocn.ne.jp [222.146.71.13])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0007CBA41; Fri,  9 Mar 2007 00:37:49 +0900 (JST)
Date:	Fri, 09 Mar 2007 00:37:49 +0900 (JST)
Message-Id: <20070309.003749.39154822.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, kraj@mvista.com, libc-ports@sourceware.org
Subject: Re: [PATCH] Fix some system calls with long long arguments
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070307.231410.15268922.anemo@mba.ocn.ne.jp>
References: <20070307.003931.25235381.anemo@mba.ocn.ne.jp>
	<20070307.231410.15268922.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 07 Mar 2007 23:14:10 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> fadvise64(), readahead(), sync_file_range() have long long argument(s)
> but glibc passes it by hi/lo pair without padding, on both O32 and
> N32.
> 
> Also wire up fadvise64_64() and fixup confusion of it with
> fadvise64().

If best performance was preferred, the O32 readahead and
sync_file_range should not changed and libc should provide MIPS
specific syscall wrappers, like pread64.  The N32 can also use
standard sys_readahead(), etc. and libc should provide wrappers, too.

Anyway fadvice64() needs to be fixed.

Any comments from libc side?  Original patch is here:
http://www.linux-mips.org/archives/linux-mips/2007-03/msg00092.html

---
Atsushi Nemoto
