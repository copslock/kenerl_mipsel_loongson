Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 14:58:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2439 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574195AbYAGO6n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 14:58:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m07EwNFU030776;
	Mon, 7 Jan 2008 14:58:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m07EwMwS030775;
	Mon, 7 Jan 2008 14:58:22 GMT
Date:	Mon, 7 Jan 2008 14:58:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix modpost warning in raw binary builds.
Message-ID: <20080107145822.GA14955@linux-mips.org>
References: <S20039888AbXJPTFk/20071016190540Z+81757@ftp.linux-mips.org> <20080106.004834.96687248.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080106.004834.96687248.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 06, 2008 at 12:48:34AM +0900, Atsushi Nemoto wrote:

> > 
> >   MODPOST vmlinux.o
> > WARNING: vmlinux.o(.text+0x478): Section mismatch: reference to .init.text:start_kernel (between '_stext' and 'run_init_process')
> 
> This commit should break CONFIG_BOOT_RAW.  Since I do not have any
> good idea to avoid this warning, reverting this commit would be the
> best for now.  The warning is just a false positive anyway.

But a somewhat nervragging one and it'd be easy to fix now that
__INIT_REFOK is in the kernel, something like the below patch should do
the trick.

  Ralf

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 2367687..50be56c 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -136,7 +136,8 @@ EXPORT(_stext)
 	 * kernel load address.  This is needed because this platform does
 	 * not have a ELF loader yet.
 	 */
-	__INIT
+FEXPORT(__kernel_entry)
+	j	kernel_entry
 #endif
 
 	__INIT_REFOK
