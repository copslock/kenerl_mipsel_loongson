Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 11:09:33 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57998 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038685AbXBGLJc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Feb 2007 11:09:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l17B9UPN018503;
	Wed, 7 Feb 2007 11:09:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l17B9TdX018502;
	Wed, 7 Feb 2007 11:09:29 GMT
Date:	Wed, 7 Feb 2007 11:09:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from a context.
Message-ID: <20070207110929.GA17660@linux-mips.org>
References: <S20038814AbXBEQMb/20070205161231Z+24864@ftp.linux-mips.org> <20070207.133809.71085888.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070207.133809.71085888.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 07, 2007 at 01:38:09PM +0900, Atsushi Nemoto wrote:

> >  arch/mips/kernel/r4k_fpu.S |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> r2300_fpu.S and r6000_fpu.S should be fixed too?
> 
> Also, fpu_emulator_restore_context() should check FCSR too? (it should
> not harm FPU-less CPU, but on MIPS_MT, FCSR value restored by fpu
> emulator might be used for real FPU, right?)

Correct in all points.

  Ralf
