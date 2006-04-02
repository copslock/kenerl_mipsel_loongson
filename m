Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2006 17:06:16 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:3070 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133594AbWDBQGD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2006 17:06:03 +0100
Received: from localhost (p6135-ipad211funabasi.chiba.ocn.ne.jp [58.91.162.135])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 77F469EDF; Mon,  3 Apr 2006 01:16:55 +0900 (JST)
Date:	Mon, 03 Apr 2006 01:17:11 +0900 (JST)
Message-Id: <20060403.011711.74751665.anemo@mba.ocn.ne.jp>
To:	fxzhang@ict.ac.cn
Cc:	linux-mips@linux-mips.org
Subject: Re: stack backtrace
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <442FE1CA.4030905@ict.ac.cn>
References: <442FE1CA.4030905@ict.ac.cn>
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
X-archive-position: 11007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 02 Apr 2006 22:38:02 +0800, Fuxin Zhang <fxzhang@ict.ac.cn> said:

>     Instead for my need I just hack up a simple version of way 1, with
> frame pointer kept on: CONFIG_FRAME_POINTER.

> BTW:It seems nobody use this option for MIPS? Is it dangerous? The size
> and performance overhead should be barable at most time for debugging?

> here is the code patch(just for reference), it depends on
> CONFIG_KALLSYMS too.

The get_frame_info() in process.c in kernel 2.6.16 no longer depends
on a frame pointer.  It would fit your needs better.  I think you can
use it with slight modifications.

BTW, Is there any point using -fno-omit-frame-pointer on MIPS now?
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y is better for MIPS, isn't it?

---
Atsushi Nemoto
