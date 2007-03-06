Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 15:37:19 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:34293 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021405AbXCFPhO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2007 15:37:14 +0000
Received: from localhost (p5247-ipad28funabasi.chiba.ocn.ne.jp [220.107.204.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 14594BA90
	for <linux-mips@linux-mips.org>; Wed,  7 Mar 2007 00:35:54 +0900 (JST)
Date:	Wed, 07 Mar 2007 00:35:53 +0900 (JST)
Message-Id: <20070307.003553.48531257.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: fadvise on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070303.012914.15243240.anemo@mba.ocn.ne.jp>
References: <20070217.004329.108739438.anemo@mba.ocn.ne.jp>
	<20070217.004812.03978264.anemo@mba.ocn.ne.jp>
	<20070303.012914.15243240.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 03 Mar 2007 01:29:14 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > For N32 and O32, kernel should be fixed anyway, but which syscall
> > should be supported?  And whether kernel or libc should take care of
> > 'long long' issue?
> 
> Then how about this absolutely untested patch?

I had forgotten changing __NR_Linux_syscalls, etc.  And I found
readahead() has same problem, and sys32_readahead() and
sys32_sync_file_range() does not match with glibc.  I'll send a new
patch, fixing them all in kernel side.

---
Atsushi Nemoto
