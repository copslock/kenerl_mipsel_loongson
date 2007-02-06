Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 07:03:01 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:55500 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037871AbXBFHCy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 07:02:54 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 6 Feb 2007 16:02:48 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4F11E420CF;
	Tue,  6 Feb 2007 16:02:22 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 3AB4C203A7;
	Tue,  6 Feb 2007 16:02:22 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1672LW0057784;
	Tue, 6 Feb 2007 16:02:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 06 Feb 2007 16:02:21 +0900 (JST)
Message-Id: <20070206.160221.07643905.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Work around bogus gcc warnings.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20037630AbWK3BWw/20061130012252Z+10493@ftp.linux-mips.org>
References: <S20037630AbWK3BWw/20061130012252Z+10493@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 30 Nov 2006 01:22:47 +0000, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Thu Nov 30 00:14:48 2006 +0000
> Commit: df300391b4833167841465189f6ef32560f0282d
> Gitweb: http://www.linux-mips.org/g/linux/df300391
> Branch: master
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  arch/mips/kernel/traps.c |   43 ++++++++++++++++++++++---------------------
>  1 files changed, 22 insertions(+), 21 deletions(-)

This commit broke gdb, since any BREAK or TRAP instruction cause
SIGSEGV.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 2a932ca..cfd1785 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -708,6 +708,7 @@ asmlinkage void do_bp(struct pt_regs *regs)
 		die_if_kernel("Break instruction in kernel code", regs);
 		force_sig(SIGTRAP, current);
 	}
+	return;
 
 out_sigsegv:
 	force_sig(SIGSEGV, current);
@@ -751,6 +752,7 @@ asmlinkage void do_tr(struct pt_regs *regs)
 		die_if_kernel("Trap instruction in kernel code", regs);
 		force_sig(SIGTRAP, current);
 	}
+	return;
 
 out_sigsegv:
 	force_sig(SIGSEGV, current);
