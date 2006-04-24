Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 12:32:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52096 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133737AbWDXL3g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 12:29:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3OBgZBV006517;
	Mon, 24 Apr 2006 12:42:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3OA9G7L003689;
	Mon, 24 Apr 2006 11:09:16 +0100
Date:	Mon, 24 Apr 2006 11:09:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: "relocation truncated to fit: R_MIPS_CALL16"
Message-ID: <20060424100916.GD3194@linux-mips.org>
References: <50c9a2250604222002x37b949fbi585ed5fb31087d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250604222002x37b949fbi585ed5fb31087d5@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 23, 2006 at 11:02:46AM +0800, zhuzhenhua wrote:

> i want to write a mini bootloader for my board, so i need jump to c
> code from asm code
> but when i compile and ld, i get "relocation truncated to fit:
> R_MIPS_CALL16" messages for every function call..
> i have try the mips_4KCle-gcc(worked for u-boot),
> mips_fp_le-gcc(worked for mvita linux), and also a
> mipsel-linux-gcc(worked for my linux 2.6 kernel), but they all failed,
> even i add -G0 to gcc.
> and i only compile success by using mips-elf-gcc under cygwin.
> does it be caused by binutils version? or gcc compile CFLAGS?
> thanks for any hints

PIC code.  Use -fno-pic -mno-abicalls.

  Ralf
