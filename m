Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 17:40:58 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:22726 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133637AbWEJPku (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 17:40:50 +0200
Received: from localhost (p5181-ipad27funabasi.chiba.ocn.ne.jp [220.107.196.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C64B1B499; Thu, 11 May 2006 00:40:44 +0900 (JST)
Date:	Thu, 11 May 2006 00:41:26 +0900 (JST)
Message-Id: <20060511.004126.01916795.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] use generic DWARF_DEBUG
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060510112423.GC7813@networkno.de>
References: <20060510071937.GA7813@networkno.de>
	<20060510.165616.108981664.nemoto@toshiba-tops.co.jp>
	<20060510112423.GC7813@networkno.de>
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
X-archive-position: 11393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 10 May 2006 12:24:23 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > Also, I suppose we can use STABS_DEBUG too, but not sure.  Current
> > MIPS vmlinux.lds.S have this line:
> > 
> >   .comment : { *(.comment) }
> > 
> > and it seems conflicts with a .comment line in STABS_DEBUG.  Can we
> > use generic STABS_DEBUG and drop the .comment line in mips
> > vmlinux.lds.S ?
> 
> Isn't stabs in general deprecated by now?

I think so, but someone might think it's still useful since its size
is much smaller. (less than half or so)

Anyway, how about this patch?


[PATCH] use generic STABS_DEBUG macro.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 73f7aca..b84d1f9 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -151,16 +151,13 @@ SECTIONS
 
   /* This is the MIPS specific mdebug section.  */
   .mdebug : { *(.mdebug) }
-  /* These are needed for ELF backends which have not yet been
-     converted to the new style linker.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
+
+  STABS_DEBUG
 
   DWARF_DEBUG
 
   /* These must appear regardless of  .  */
   .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
   .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
-  .comment : { *(.comment) }
   .note : { *(.note) }
 }
