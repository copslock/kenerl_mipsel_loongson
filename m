Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jan 2004 01:03:39 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:16146
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225239AbUAEBDi>; Mon, 5 Jan 2004 01:03:38 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Jan 2004 01:04:21 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i051431x017671;
	Mon, 5 Jan 2004 10:04:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 05 Jan 2004 10:04:29 +0900 (JST)
Message-Id: <20040105.100429.74756139.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 16 Dec 2003 22:33:41 +0100 (CET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro>  ifdef CONFIG_CPU_TX39XX
macro> -GCCFLAGS	+= -mcpu=r3000 -mips1
macro> +GCCFLAGS	+= $(call set_gccflags,r3000,mips1,r3000,mips1,mips1)
macro>  endif

Recent tools have -march=r3900 option.  Now we can use this without
hitting old tool users.  Please apply this patch.  Thank you.

diff -u linux-mips/arch/mips/Makefile linux/arch/mips/Makefile 
--- linux-mips/arch/mips/Makefile	Mon Jan  5 08:37:51 2004
+++ linux/arch/mips/Makefile	Mon Jan  5 09:50:06 2004
@@ -107,7 +107,7 @@
 GCCFLAGS	+= $(call set_gccflags,r3000,mips1,r3000,mips1,mips1)
 endif
 ifdef CONFIG_CPU_TX39XX
-GCCFLAGS	+= $(call set_gccflags,r3000,mips1,r3000,mips1,mips1)
+GCCFLAGS	+= $(call set_gccflags,r3900,mips1,r3000,mips1,mips1)
 endif
 ifdef CONFIG_CPU_R6000
 GCCFLAGS	+= $(call set_gccflags,r6000,mips2,r6000,mips2,mips2) \

---
Atsushi Nemoto
