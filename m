Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 15:05:10 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:35544 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030802AbYAEPFB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2008 15:05:01 +0000
Received: from localhost (p8226-ipad401funabasi.chiba.ocn.ne.jp [123.217.242.226])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8FFD19838; Sun,  6 Jan 2008 00:04:57 +0900 (JST)
Date:	Sun, 06 Jan 2008 00:07:25 +0900 (JST)
Message-Id: <20080106.000725.75184768.anemo@mba.ocn.ne.jp>
To:	gregor.waltz@raritan.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <477E7DAE.2080005@raritan.com>
References: <477E6296.7090605@raritan.com>
	<20080104172136.GD22809@networkno.de>
	<477E7DAE.2080005@raritan.com>
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
X-archive-position: 17927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 04 Jan 2008 13:40:46 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
> sendRRQ vmlinux.bin
> load linux length 0x34408a
> Checking CRC on downloaded RAM image
>  /
> CRC Check passed
> Image Started At Address 0x80020000.
> Image Length = 3424394 (0x34408a).
> Exception! EPC=80056eb4 CAUSE=30000008(TLBL)
> 80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc

Are you loading an ELF binary or a raw binary image?  If your loader
does not handle ELF headers, you should do some trick to start running
your kernel at correct address.

If you were using 2.6.23, CONFIG_BOOT_RAW might help you.

But it seems CONFIG_BOOT_RAW is broken on current git again.  It will
be an another story... :-<

---
Atsushi Nemoto
