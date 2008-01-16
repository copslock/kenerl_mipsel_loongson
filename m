Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 15:47:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:46067 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026234AbYAPPrY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2008 15:47:24 +0000
Received: from localhost (p6085-ipad307funabasi.chiba.ocn.ne.jp [123.217.184.85])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 387369CEC; Thu, 17 Jan 2008 00:47:20 +0900 (JST)
Date:	Thu, 17 Jan 2008 00:47:16 +0900 (JST)
Message-Id: <20080117.004716.59650985.anemo@mba.ocn.ne.jp>
To:	frank.rowand@am.sony.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] serial_txx9 driver support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1200436432.4092.38.camel@bx740>
References: <1200436139.4092.30.camel@bx740>
	<1200436432.4092.38.camel@bx740>
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
X-archive-position: 18079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 15 Jan 2008 14:33:52 -0800, Frank Rowand <frank.rowand@am.sony.com> wrote:
> Add polled debug driver support to serial_txx9.c for kgdb, and initialize
> the driver for the Toshiba RBTX4927.

I think Jason Wessel's kgdb patchset is a way to go.

Anyway, some comments below.

> +int kgdb_initialized;

Should be static.

> +void txx9_sio_kgdb_hook(unsigned int port, unsigned int baud_rate)

Should be static.  The baud_rate is not used.

> +void
> +txx9_sio_kdbg_init(unsigned int port_number)
> +{
> +	if (port_number == 1) {
> +		txx9_sio_kgdb_hook(port_number, 38400);
> +		kgdb_initialized = 1;
> +	} else {
> +		printk(KERN_ERR
> +			"txx9_sio_kdbg_init(): Bad Port Number [%u] != [1]\n",
> +			port_number);
> +	}
> +
> +	return;
> +}

Why port_number other than 1 is bad?

The "return" at the end of the function is redundant.

> +u8
> +txx9_sio_kdbg_rd(void)
> +{
> +	unsigned int status, ch;
> +	struct uart_txx9_port *up = &serial_txx9_ports[1];

Oh this assumes port number 1.  The gdb port number should be customizable.

> +			sio_out(up, TXX9_SITFIFO, (u32)ch);

The cast is not needed.

---
Atsushi Nemoto
