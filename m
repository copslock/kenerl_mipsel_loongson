Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 15:46:19 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52986 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031404AbYAEPqK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2008 15:46:10 +0000
Received: from localhost (p8226-ipad401funabasi.chiba.ocn.ne.jp [123.217.242.226])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 72A1D9A25; Sun,  6 Jan 2008 00:46:06 +0900 (JST)
Date:	Sun, 06 Jan 2008 00:48:34 +0900 (JST)
Message-Id: <20080106.004834.96687248.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Fix modpost warning in raw binary builds.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20039888AbXJPTFk/20071016190540Z+81757@ftp.linux-mips.org>
References: <S20039888AbXJPTFk/20071016190540Z+81757@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 16 Oct 2007 20:05:35 +0100, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Tue Oct 16 20:05:18 2007 +0100
> Commit: 017e3a492683b32d17dcd1b13b279745cc656073
> Gitweb: http://www.linux-mips.org/g/linux/017e3a49
> Branch: master
> 
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x478): Section mismatch: reference to .init.text:start_kernel (between '_stext' and 'run_init_process')

This commit should break CONFIG_BOOT_RAW.  Since I do not have any
good idea to avoid this warning, reverting this commit would be the
best for now.  The warning is just a false positive anyway.

---
Atsushi Nemoto
