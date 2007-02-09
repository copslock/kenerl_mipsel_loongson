Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 16:20:01 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:12755 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038782AbXBIQT4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Feb 2007 16:19:56 +0000
Received: from localhost (p4029-ipad301funabasi.chiba.ocn.ne.jp [122.17.254.29])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 617C0B6EC; Sat, 10 Feb 2007 01:18:35 +0900 (JST)
Date:	Sat, 10 Feb 2007 01:18:35 +0900 (JST)
Message-Id: <20070210.011835.08318488.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11710336591652-git-send-email-fbuihuu@gmail.com>
References: <1171033658561-git-send-email-fbuihuu@gmail.com>
	<11710336591652-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 14009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri,  9 Feb 2007 16:07:38 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>   CC      arch/mips/kernel/signal.o
> arch/mips/kernel/signal.c: In function `sys_sigaction':
> arch/mips/kernel/signal.c:266: warning: cast to pointer from integer of different size
> 
> This warning is due to the following line:
> 
> 	__get_user(new_ka.sa.sa_handler, &act->sa_handler);

This usage of __get_user() should be absolutely legal.

> 	new_ka.sa.sa_handler = (__sighandler_t) __gu_tmp;
> 
> Here we try to cast an 'unsigned long long' into a 32 bits pointer and
> that's the reason of the warning.

This line is never executed on 32bit kernel and gcc optimize out.  On
64-bit kernel, this line is executed without any problem without
warning.

I think this is a problem of __get_user() implementation or gcc
itself.  Though I can not find better solution yet, hacking the caller
to avoid the warning would not be right things to to.

---
Atsushi Nemoto
