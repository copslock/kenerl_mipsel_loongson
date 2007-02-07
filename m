Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 04:38:40 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:42697 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037419AbXBGEig (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Feb 2007 04:38:36 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 7 Feb 2007 13:38:34 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id F3BE041DA1
	for <linux-mips@linux-mips.org>; Wed,  7 Feb 2007 13:38:09 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E744E206AB
	for <linux-mips@linux-mips.org>; Wed,  7 Feb 2007 13:38:09 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l174c9W0062264
	for <linux-mips@linux-mips.org>; Wed, 7 Feb 2007 13:38:09 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 07 Feb 2007 13:38:09 +0900 (JST)
Message-Id: <20070207.133809.71085888.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20038814AbXBEQMb/20070205161231Z+24864@ftp.linux-mips.org>
References: <S20038814AbXBEQMb/20070205161231Z+24864@ftp.linux-mips.org>
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
X-archive-position: 13954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 05 Feb 2007 16:12:26 +0000, linux-mips@linux-mips.org wrote:
> Author: Chris Dearman <chris@mips.com> Thu Feb 1 19:54:13 2007 +0000
> Comitter: Ralf Baechle <ralf@linux-mips.org> Mon Feb 5 15:56:18 2007 +0000
> Commit: a9e080c2c615bc4e9d9987330c0be35ea5226eed
> Gitweb: http://www.linux-mips.org/g/linux/a9e080c2
> Branch: master
> 
> Signed-off-by: Chris Dearman <chris@mips.com>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  arch/mips/kernel/r4k_fpu.S |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

r2300_fpu.S and r6000_fpu.S should be fixed too?

Also, fpu_emulator_restore_context() should check FCSR too? (it should
not harm FPU-less CPU, but on MIPS_MT, FCSR value restored by fpu
emulator might be used for real FPU, right?)

---
Atsushi Nemoto
