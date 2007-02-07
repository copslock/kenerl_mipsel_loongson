Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 15:42:17 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45022 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039193AbXBGPmL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2007 15:42:11 +0000
Received: from localhost (p4022-ipad202funabasi.chiba.ocn.ne.jp [222.146.75.22])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3FAA6C159; Thu,  8 Feb 2007 00:40:50 +0900 (JST)
Date:	Thu, 08 Feb 2007 00:40:49 +0900 (JST)
Message-Id: <20070208.004049.51866970.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 9/10] signal: do not use save_static_function() anymore
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11706854703880-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
	<11706854703880-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 13956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon,  5 Feb 2007 15:24:27 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> For the sys_sigsuspend() case, I don't see any reasons...

Maybe that was needed before commit
7b3e2fc847c8325a7b35185fa1fc2f1729ed9c5b.  At that time
sys_sigsuspend() called do_signal() (which includes
setup_sigcontext()) directly.  So all registers must be saved to
kernel stack.

Now do_signal() is called only from do_notify_resume(), so I agree
save_static_function is not needed.
---
Atsushi Nemoto
