Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 16:05:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51677 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574545AbYAPQFG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2008 16:05:06 +0000
Received: from localhost (p6085-ipad307funabasi.chiba.ocn.ne.jp [123.217.184.85])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2207C96FE; Thu, 17 Jan 2008 01:05:03 +0900 (JST)
Date:	Thu, 17 Jan 2008 01:04:59 +0900 (JST)
Message-Id: <20080117.010459.51867104.anemo@mba.ocn.ne.jp>
To:	gregor.waltz@raritan.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <478E22A4.4070604@raritan.com>
References: <478D121C.4020701@raritan.com>
	<20080115231421.GB9767@networkno.de>
	<478E22A4.4070604@raritan.com>
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
X-archive-position: 18081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jan 2008 10:28:36 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
> I double checked today and found that even the vmlinux make target 
> removes that option from .config.
> Is there another way to set that option?

The CONFIG_BOOT_RAW is not user-selectable.  You must add "select
BOOT_RAW" to TOSHIBA_JMR3927 block in arch/mips/Kconfig.

> I saw the option used only in arch/mips/kernel/head.S, so I commented 
> out the __INIT. Now, I see kernel_entry at the start of the kernel and 
> the kernel does not cause an exception, however, it reboots instead 
> saying "Rebooting..."

Hmm.  The puts() in arch/mips/jmr3927/common/puts.c looks usable even
on kernel entry.  You can verify if it can really be used on
start_kernel(), then start tracking down the problem.

---
Atsushi Nemoto
