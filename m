Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 May 2007 14:51:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:60876 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022603AbXEMNvp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 May 2007 14:51:45 +0100
Received: from localhost (p2070-ipad03funabasi.chiba.ocn.ne.jp [219.160.82.70])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7B91EA522; Sun, 13 May 2007 22:51:40 +0900 (JST)
Date:	Sun, 13 May 2007 22:51:54 +0900 (JST)
Message-Id: <20070513.225154.74753893.anemo@mba.ocn.ne.jp>
To:	sam@ravnborg.org
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070512185854.GA8647@uranus.ravnborg.org>
References: <cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
	<20070513.014713.74753298.anemo@mba.ocn.ne.jp>
	<20070512185854.GA8647@uranus.ravnborg.org>
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
X-archive-position: 15052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 12 May 2007 20:58:54 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> > Subject: [PATCH] MIPS: Simplify missing-syscalls for N32 and O32
> 
> This is overengineered. The only reason to make the syscall check
> for each and every build was that this was easy and the missing syscalls
> are easy to spot during a normal build.
> But checking all combinations is just not worth it.
> The arch responsible are assumed to build for the different architectures
> once in a while so a missing syscall are likely to be detected anyway.
> 
> We cannot run each and every consistency check in all combinations
> for each build - that would end in only build noise.

Well, 64-bit MIPS has three ABIs and each ABI has complete set of
syscalls.  So a result of default "missing-syscalls" target (which is
for N64 ABI) is not useful at all for other two ABIs.

I think checking them is worth even if the S/N ratio was quite low.
---
Atsushi Nemoto
