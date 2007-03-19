Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:47:37 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:63188 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021868AbXCSOrc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 14:47:32 +0000
Received: from localhost (p3228-ipad01funabasi.chiba.ocn.ne.jp [61.207.77.228])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7B949A68B; Mon, 19 Mar 2007 23:46:11 +0900 (JST)
Date:	Mon, 19 Mar 2007 23:46:11 +0900 (JST)
Message-Id: <20070319.234611.65191592.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	arnaud.giersch@free.fr
Subject: Re: IP32 prom crashes due to __pa() funkiness
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45FE9D22.1030407@gentoo.org>
References: <45FC9E39.7010506@gentoo.org>
	<45FE95EE.5030108@innova-card.com>
	<45FE9D22.1030407@gentoo.org>
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
X-archive-position: 14555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 10:24:34 -0400, Kumba <kumba@gentoo.org> wrote:
> Most of this is because IP22 (Indy/Idigo2 R4xx) and IP32 (O2 R5xxx),
> while supporting 64bit kernels (same for cobalt, since it's a
> mips4-level CPU), we had to "trick" them into accepting 64bit code.
> IP32 at one point ran 32bit kernels only, but it was later converted
> to supporting only 64bit kernels, hence the hackery involved.  We
> describe it as wrapping 64bit code into a 32bit object, because
> their proms will only recognize 32bit objects (specifically, IP22
> will only boot 32bit objects; crash on 64bit; IP32 will take both,
> but likes 32bit better).
> 
> So really, CONFIG_BUILD_ELF64 was probably part of this "magic" to
> stuff 64bit code into a candy-coated 32bit wrapper for the Indy (And
> later the O2) to suck down w/o complaint.  Hence, __pa() probably
> needs to replicate this support, or we all need to brainstorm a
> proper way to get these systems to boot.

The "magic" is CONFIG_BOOT_ELF32 and CONFIG_BOOT_ELF64, isn't it?
CONFIG_BUILD_ELF64 is not irrelevant to ELF format.

I feel there are some confusions about this issue on this discussion...
---
Atsushi Nemoto
