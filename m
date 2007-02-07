Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 16:23:42 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:27346 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039534AbXBGQXg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2007 16:23:36 +0000
Received: from localhost (p4022-ipad202funabasi.chiba.ocn.ne.jp [222.146.75.22])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DD5BDBC4C; Thu,  8 Feb 2007 01:22:16 +0900 (JST)
Date:	Thu, 08 Feb 2007 01:22:16 +0900 (JST)
Message-Id: <20070208.012216.103777705.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070207110929.GA17660@linux-mips.org>
References: <S20038814AbXBEQMb/20070205161231Z+24864@ftp.linux-mips.org>
	<20070207.133809.71085888.nemoto@toshiba-tops.co.jp>
	<20070207110929.GA17660@linux-mips.org>
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
X-archive-position: 13959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 7 Feb 2007 11:09:29 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > r2300_fpu.S and r6000_fpu.S should be fixed too?
> > 
> > Also, fpu_emulator_restore_context() should check FCSR too? (it should
> > not harm FPU-less CPU, but on MIPS_MT, FCSR value restored by fpu
> > emulator might be used for real FPU, right?)
> 
> Correct in all points.

If the format of FCSR was common to all CPU (I hope so), we can do
check it in caller of fp_restore_context(), in C language.

BTW, why R6000 does not use r4k_fpu.S?
---
Atsushi Nemoto
