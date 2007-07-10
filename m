Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 15:09:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14314 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021592AbXGJOJw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2007 15:09:52 +0100
Received: from localhost (p1061-ipad210funabasi.chiba.ocn.ne.jp [58.88.120.61])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 470A48901; Tue, 10 Jul 2007 23:09:48 +0900 (JST)
Date:	Tue, 10 Jul 2007 23:10:41 +0900 (JST)
Message-Id: <20070710.231041.05598442.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] DEC: Fix modpost warning.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070710130409.GA14723@linux-mips.org>
References: <S20022577AbXGJLug/20070710115036Z+13637@ftp.linux-mips.org>
	<Pine.LNX.4.64N.0707101401001.18036@blysk.ds.pg.gda.pl>
	<20070710130409.GA14723@linux-mips.org>
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
X-archive-position: 15667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 10 Jul 2007 14:04:09 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> Yes, the root cause was the reference to serial_console_setup.  It's hard
> to teach modpost that this reference is bogus so I fixed the driver instead.
> Other console drivers had the same issue.

The modpost has "_console" name in its whitelist.  So minimum
workaround would be something like this:

--- a/drivers/tc/zs.c
+++ b/drivers/tc/zs.c
@@ -136,6 +136,7 @@ struct dec_serial *zs_chain;	/* list of all channels */
 struct tty_struct zs_ttys[NUM_CHANNELS];
 
 #ifdef CONFIG_SERIAL_DEC_CONSOLE
+#define sercons ser_console
 static struct console sercons;
 #endif
 #if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && \
