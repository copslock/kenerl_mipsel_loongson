Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 10:24:12 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:4359
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225072AbTHLJYI>; Tue, 12 Aug 2003 10:24:08 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 12 Aug 2003 09:24:06 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h7C9Nt2S000528;
	Tue, 12 Aug 2003 18:23:55 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Tue, 12 Aug 2003 18:25:29 +0900 (JST)
Message-Id: <20030812.182529.18309031.nemoto@toshiba-tops.co.jp>
To: kumba@gentoo.org
Cc: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3F388E0C.50802@gentoo.org>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp>
	<3F388E0C.50802@gentoo.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 12 Aug 2003 02:49:48 -0400, Kumba <kumba@gentoo.org> said:
kumba> I don't claim to be an expert on all things mips yet, but If I
kumba> recall correctly, the R4K processor line is a MIPS III capable
kumba> processor.  So -mips3 -mabi=32 should be safe for it.  I've
kumba> been building kernels off linux-mips.org CVS using "-mips3
kumba> -mabi=32 -Wa,--trap" in the arch/mips/Makefile, and it works
kumba> great.

Only affected code I found is __BUILD_clear_ade.  So the 32-bit kernel
compiled with -mips3 will work fine normally, but once an address
error occur the kernel will crash.

As Thiemo said, it seems include/asm-mips/asm.h should be fixed
instead of Makefile.  Still investigating...

---
Atsushi Nemoto
