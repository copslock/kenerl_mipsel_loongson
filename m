Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2006 13:42:25 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59632 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038804AbWLCNmU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2006 13:42:20 +0000
Received: from localhost (p6165-ipad201funabasi.chiba.ocn.ne.jp [222.146.69.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 08537C1E9; Sun,  3 Dec 2006 22:42:15 +0900 (JST)
Date:	Sun, 03 Dec 2006 22:42:14 +0900 (JST)
Message-Id: <20061203.224214.74752582.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	kaz@zeugmasystems.com, linux-mips@linux-mips.org
Subject: Re: N32 shmat problem identified! Kernel fix needed.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061202022404.GA28637@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D4B5F5F@exchange.ZeugmaSystems.local>
	<20061202022404.GA28637@linux-mips.org>
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
X-archive-position: 13327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 2 Dec 2006 02:24:04 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > The fix is to remove this function from the code base and quite simply
> > to wire the normal sys_shmat into the n32 syscall table. Since there is
> > in fact no pointer-to-pointer argument, this function doesn't have a 32
> > bit compatibility issues.
> 
> That's fixed since two months.

Minor correction: about a month, not two :)

http://www.linux-mips.org/archives/linux-mips/2006-11/msg00030.html

This fix is already merged to master and linux-2.6.1x-stable branches
in linux-mips.org tree, though not merged to kernel.org's tree yet
unfortunately.

---
Atsushi Nemoto
