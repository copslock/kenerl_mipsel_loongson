Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2004 15:31:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:27106 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225254AbUIYObT>; Sat, 25 Sep 2004 15:31:19 +0100
Received: from localhost (p8149-ipad01funabasi.chiba.ocn.ne.jp [61.207.82.149])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E44CE7F5D; Sat, 25 Sep 2004 23:31:15 +0900 (JST)
Date: Sat, 25 Sep 2004 23:41:12 +0900 (JST)
Message-Id: <20040925.234112.41626050.anemo@mba.ocn.ne.jp>
To: mlachwani@mvista.com
Cc: linux-mips@linux-mips.org
Subject: Re: IDE woos in BE mode 2.6 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4154B069.8010708@mvista.com>
References: <414B388D.8060705@mvista.com>
	<20040918.231947.74754644.anemo@mba.ocn.ne.jp>
	<4154B069.8010708@mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 24 Sep 2004 16:40:25 -0700, Manish Lachwani <mlachwani@mvista.com> said:

mlachwani> These changes below work and attached is the patch based on
mlachwani> your suggestion. However, I have made changes to
mlachwani> include/asm-mips/ide.h since I think there may be problems
mlachwani> with other MIPS boards to in BE mode.  And, I have not
mlachwani> included the (dma_cache_wback) in the patch.

Hmm, I think declaration of mips_io_port_base is not needed since
asm/io.h must be included before asm/ide.h.  If asm/io.h was not
included first, ide.h can not override these functions anyway.

Also, moving the fixup block before "#include <ide.h>" will give a
chance to override these functions again in mach-dependent ide.h. (for
more weired hardware)

---
Atsushi Nemoto
