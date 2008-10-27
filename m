Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 14:04:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53189 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22504931AbYJ0OEd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 14:04:33 +0000
Received: from localhost (p4040-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9A997AD29; Mon, 27 Oct 2008 23:04:28 +0900 (JST)
Date:	Mon, 27 Oct 2008 23:04:28 +0900 (JST)
Message-Id: <20081027.230428.18313184.anemo@mba.ocn.ne.jp>
To:	Geert.Uytterhoeven@sonycom.com
Cc:	linux-mips@linux-mips.org
Subject: Re: RBTX4927 with VxWorks boot loader crashes in prom_getenv()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0810271419280.19980@vixen.sonytel.be>
References: <Pine.LNX.4.64.0810241605380.23415@vixen.sonytel.be>
	<20081024.233538.48533304.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0810271419280.19980@vixen.sonytel.be>
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
X-archive-position: 20993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 27 Oct 2008 14:39:32 +0100 (CET), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > BTW, it looks fw_arg0 is not 'argc'.  Fortunately current code just
> > ignores argv if argc was negative, but it is not intentional
> > behaviour, just a luck ;)
> 
> Woops...
> 
> The memory pointed to by fw_arg0 and fw_arg1 contains just zeroes.
> 
> According to the sources, the VxWorks bootloader just jumps to the kernel's
> entry point, without passing any parameters in a0-a3 at all. So they're just
> leftovers.

Wow, what a simple loader ...

> > You can put a string starting with "-" in CONFIG_CMDLINE, so that
> > fw_arg0 is ignored regardless of its value.  Hmm... putting "noenv" or
> > something in CONFIG_CMDLINE (and check it in preprocess_cmdline()) can
> > be an another workaround for getenv problem...
> 
> Prepending my command line in CONFIG_CMDLINE with `-' doesn't help.
> prom_getenv() is still called.
>
> So I came up with the patch below.

Oh, yes, the '-' does not prevent prom_getenv().  It just prevents
argc/argv parsing.  Anyway, checking invalid fw_argN should be good.

> Subject: [PATCH] txx9: Make firmware parameter passing more robust
> 
> When booting Linux on a txx9 board with VxWorks boot loader, it crashes in
> prom_getenv(), as VxWorks doesn't pass firmware parameters in a0-a3 (in my
> case, the actual leftover values in these registers were 0x80002000,
> 0x80001fe0, 0x2000, and 0x20).
> 
> Make the parsing of argc, argv, and envp a bit more robust by checking if argc
> is a number below CKSEG0, and argv/envp point to CKSEG0.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Look OK for me, except for coding style :)

If TAB was used for indent,
Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
