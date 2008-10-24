Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 15:35:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:41711 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22299274AbYJXOf1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 15:35:27 +0100
Received: from localhost (p4039-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DC0E3AC53; Fri, 24 Oct 2008 23:35:20 +0900 (JST)
Date:	Fri, 24 Oct 2008 23:35:38 +0900 (JST)
Message-Id: <20081024.233538.48533304.anemo@mba.ocn.ne.jp>
To:	Geert.Uytterhoeven@sonycom.com
Cc:	linux-mips@linux-mips.org
Subject: Re: RBTX4927 with VxWorks boot loader crashes in prom_getenv()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0810241605380.23415@vixen.sonytel.be>
References: <Pine.LNX.4.64.0810241118120.27263@vixen.sonytel.be>
	<20081024.230250.59651236.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0810241605380.23415@vixen.sonytel.be>
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
X-archive-position: 20929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 24 Oct 2008 16:06:28 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > | fw_arg0 = 0x80002000
> > > | fw_arg1 = 0x80001fe0
> > > | fw_arg2 = 0x2000
> > > | fw_arg3 = 0x20
> > > 
> > > So your assumption that bootloaders other than YAMON pass NULL for fw_arg2 is
> > > apparently wrong.
> > 
> > Indeed.  We should know what sort of value was passed by fw_arg2, and
> > I hope auto-detection.
> > 
> > Do you know what value the boot loader passes via fw_arg2?  If fw_arg2
> 
> Unfortunately not. I'll try to Google a bit for it...

BTW, it looks fw_arg0 is not 'argc'.  Fortunately current code just
ignores argv if argc was negative, but it is not intentional
behaviour, just a luck ;)

You can put a string starting with "-" in CONFIG_CMDLINE, so that
fw_arg0 is ignored regardless of its value.  Hmm... putting "noenv" or
something in CONFIG_CMDLINE (and check it in preprocess_cmdline()) can
be an another workaround for getenv problem...

---
Atsushi Nemoto
