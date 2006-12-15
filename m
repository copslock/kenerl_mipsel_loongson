Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2006 16:26:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:19961 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038640AbWLOQ0v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2006 16:26:51 +0000
Received: from localhost (p8174-ipad34funabasi.chiba.ocn.ne.jp [124.85.65.174])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 20441BD84; Sat, 16 Dec 2006 01:26:46 +0900 (JST)
Date:	Sat, 16 Dec 2006 01:26:45 +0900 (JST)
Message-Id: <20061216.012645.07642903.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, qemu-devel@nongnu.org
Subject: Re: [MIPS] Use conditional traps for BUG_ON on MIPS II and better.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061203213518.GA22225@linux-mips.org>
References: <S20037651AbWK3BXW/20061130012322Z+10503@ftp.linux-mips.org>
	<20061204.015327.36921579.anemo@mba.ocn.ne.jp>
	<20061203213518.GA22225@linux-mips.org>
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
X-archive-position: 13454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 3 Dec 2006 21:35:18 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > It seems this commit break QEMU kernel ...  or QEMU can not interpret
> > the TNE instruction correctly?
> 
> Thiemo says that's indeed a possibility.  Probably that feature has not
> been well tested in qemu.

I found the bug.  "Trap If XXX" instructions are translated as it was
"Trap If XXX Immediate".

Index: target-mips/translate.c
===================================================================
RCS file: /sources/qemu/qemu/target-mips/translate.c,v
retrieving revision 1.27
diff -u -r1.27 translate.c
--- target-mips/translate.c	10 Dec 2006 22:08:10 -0000	1.27
+++ target-mips/translate.c	15 Dec 2006 16:16:07 -0000
@@ -1276,6 +1276,7 @@
             GEN_LOAD_REG_TN(T1, rt);
             cond = 1;
         }
+        break;
     case OPC_TEQI:
     case OPC_TGEI:
     case OPC_TGEIU:

---
Atsushi Nemoto
