Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 05:38:53 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:29214 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021692AbXEUEiv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 05:38:51 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 21 May 2007 13:38:49 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4927920855;
	Mon, 21 May 2007 13:38:43 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 3C33B2018B;
	Mon, 21 May 2007 13:38:43 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l4L4cfW0028421;
	Mon, 21 May 2007 13:38:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 21 May 2007 13:38:41 +0900 (JST)
Message-Id: <20070521.133841.63132735.nemoto@toshiba-tops.co.jp>
To:	libc-ports@sourceware.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, kraj@mvista.com,
	drow@false.org
Subject: Re: [PATCH] Fix some system calls with long long arguments
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070518.004759.59650774.anemo@mba.ocn.ne.jp>
References: <20070518.004759.59650774.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 May 2007 00:47:59 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> And here is glibc side fixes for posix_fadvise, posix_fadvise64,
> readahead, sync_file_range.  For O32, add a padding before a long long
> argument pair.  For N32, pass a long long value by one argument.  O32
> readahead borrows ARM EABI implementation.  N32 posix_fadvise64 use C
> implementation (instead of syscalls.list) for versioned symbols.

I filed it at glibc bugzilla:

http://sources.redhat.com/bugzilla/show_bug.cgi?id=4526

---
Atsushi Nemoto
