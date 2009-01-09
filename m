Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2009 13:36:20 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:42188 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21365064AbZAINgR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2009 13:36:17 +0000
Received: from localhost (p2189-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.189])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 80903A785; Fri,  9 Jan 2009 22:36:11 +0900 (JST)
Date:	Fri, 09 Jan 2009 22:36:13 +0900 (JST)
Message-Id: <20090109.223613.61508682.anemo@mba.ocn.ne.jp>
To:	theperan@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problem compiling glibc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <164c42ea0901090408h377e9f4eqb417443ef7a1ad@mail.gmail.com>
References: <164c42ea0901080443sace24b2v176bcc0a4d23836a@mail.gmail.com>
	<164c42ea0901090408h377e9f4eqb417443ef7a1ad@mail.gmail.com>
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
X-archive-position: 21708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 9 Jan 2009 13:08:26 +0100, "Per Andreas Gulbrandsen" <theperan@gmail.com> wrote:
> /tools/include/linux/byteorder.h:8:3: error: #error Fix
> asm/byteorder.h to define one endianness
> make[2]: *** [/mnt/clfs/sources/glibc-build/socket/sa_len.o] Error 1
> make[2]: Leaving directory `/mnt/clfs/sources/glibc-2.8/socket'
> make[1]: *** [socket/subdir_lib] Error 2
> make[1]: Leaving directory `/mnt/clfs/sources/glibc-2.8'
> make: *** [all] Error 2
> 
> I've looked at asm/byteorder.h, but I can't figure out what to do. I
> can't understand how I'm suppose to "fix" it. I've tried different
> stuff, i.e. undefing __MIPSEB__ and/or __BIG_ENDIAN if __MIPSEB__ is
> defined. But I still get the same error.
> However, If I undef __BIG_ENDIAN in /tools/include/linux/byteorder.h
> just before the check that triggers the error it compiles. But this
> doesn't seem like a very good solution. Seems like I should get rid of
> the initial definition of __BIG_ENDIAN (alt. __MIPSEB). Can anyone
> please advice? I'd like to get this right, and not just hack my way

I suppose this patchset will fix this problem.  (already mainlined)

http://lkml.org/lkml/2009/1/6/341
---
Atsushi Nemoto
