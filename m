Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 15:42:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:19702 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20027211AbXFGOmH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2007 15:42:07 +0100
Received: from localhost (p2004-ipad22funabasi.chiba.ocn.ne.jp [220.104.80.4])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C6E46B499; Thu,  7 Jun 2007 23:40:45 +0900 (JST)
Date:	Thu, 07 Jun 2007 23:41:17 +0900 (JST)
Message-Id: <20070607.234117.61509367.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: smp_mb() in asm-mips/bitops.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070607122344.GD26047@linux-mips.org>
References: <20070607.165301.63743560.nemoto@toshiba-tops.co.jp>
	<20070607122344.GD26047@linux-mips.org>
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
X-archive-position: 15331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jun 2007 13:23:44 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> Funny indeed ;-)  Below patch should do the trick.
> 
> Due to very inagressive memory reordering on the few non-strongly ordered
> MIPS SMP systems I am somewhat confident this didn't break anything but
> if so, Sibyte and PMC-Sierra RM9000 SMP systems are affected.
> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks, looks good for me.

---
Atsushi Nemoto
