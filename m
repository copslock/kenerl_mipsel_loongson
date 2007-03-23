Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 15:26:04 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:59885 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022419AbXCWP0D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2007 15:26:03 +0000
Received: from localhost (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F18D3856E; Sat, 24 Mar 2007 00:24:40 +0900 (JST)
Date:	Sat, 24 Mar 2007 00:24:40 +0900 (JST)
Message-Id: <20070324.002440.93023010.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, vagabon.xyz@gmail.com
Subject: Re: Building 64 bit kernel on Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4603DA74.70707@gentoo.org>
References: <20070322.020756.25910272.anemo@mba.ocn.ne.jp>
	<cda58cb80703211231u68e2f3b0g3a8a490a35f9d07f@mail.gmail.com>
	<4603DA74.70707@gentoo.org>
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
X-archive-position: 14633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 23 Mar 2007 09:47:32 -0400, Kumba <kumba@gentoo.org> wrote:
> Can someone review this patch for sanity?  It achieves my desire and
> lets IP32 boot using the way I've been told (BUILD_ELF64 + -msym32 +
> vmlinux.32).  Likely, it'll also do the same for Cobalt and IP22
> 64bit kernels (good luck getting those to work right anyways).

Let me ask again:  Why do you want to use CONFIG_BUILD_ELF64=y ?

If your board use CKSEG0 load address, I can not see any point setting
CONFIG_BUILD_ELF64=y.  I think the description in Kconfig (and the
name of CONFIG_BUILD_ELF64 itself) should be changed to make people
enable it only if really needed.  And it is already done by Franck's
pending patchset.

---
Atsushi Nemoto
