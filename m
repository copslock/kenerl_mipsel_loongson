Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 16:22:52 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:8174 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133531AbWEOOWp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 16:22:45 +0200
Received: from localhost (p6076-ipad203funabasi.chiba.ocn.ne.jp [222.146.85.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 83994847F; Mon, 15 May 2006 23:22:39 +0900 (JST)
Date:	Mon, 15 May 2006 23:23:24 +0900 (JST)
Message-Id: <20060515.232324.95063110.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org
Subject: Re: kernel patch for QEMU ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060515.105513.27954532.nemoto@toshiba-tops.co.jp>
References: <20060515.010846.25910142.anemo@mba.ocn.ne.jp>
	<20060514182151.GB800@networkno.de>
	<20060515.105513.27954532.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 11429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 15 May 2006 10:55:13 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The stock QEMU 0.8.1 works ok with vmlinux-r1 in mips-test-0.1 so it
> should be something different on kernel side.  Hmm...

It seems the difference comes from configuration.  If I enabled
CONFIG_DEBUG_SPINLOCK, I can run a kernel compiled from current git
tree.  Also, if I used kernel-config in mips-test-0.1 and disabled
CONFIG_DEBUG_SPINLOCK, the kernel stops at the same place.  So I'm
quite sure the option affects qemu's behavior.  But no idea why ...

---
Atsushi Nemoto
