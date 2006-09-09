Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2006 15:42:19 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:27597 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038436AbWIIOmR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Sep 2006 15:42:17 +0100
Received: from localhost (p6097-ipad210funabasi.chiba.ocn.ne.jp [58.88.125.97])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E630DB258; Sat,  9 Sep 2006 23:42:12 +0900 (JST)
Date:	Sat, 09 Sep 2006 23:44:10 +0900 (JST)
Message-Id: <20060909.234410.08076589.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] fix errors detected by "make headers_check"
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060907.010022.126141861.anemo@mba.ocn.ne.jp>
References: <20060907.010022.126141861.anemo@mba.ocn.ne.jp>
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
X-archive-position: 12542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 07 Sep 2006 01:00:22 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> * export asm/sgidefs.h
> * include asm/isadep.h only if in kernel
> * do not export contents of asm/timex.h and asm/user.h
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
>  Kbuild   |    2 ++
>  ptrace.h |    3 +--
>  timex.h  |    4 ++++
>  user.h   |    4 ++++
>  4 files changed, 11 insertions(+), 2 deletions(-)

David Woodhouse posted a patch titled "[PATCH] [2/6] Remove
<asm/timex.h> from user export" to LKML today.  If his patch was
applied, the timex.h part of my patch can be reverted.

---
Atsushi Nemoto
