Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 02:53:39 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:10442 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225214AbUARCxi>;
	Sun, 18 Jan 2004 02:53:38 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id LAA08099;
	Sun, 18 Jan 2004 11:53:28 +0900 (JST)
Received: 4UMDO01 id i0I2rRY11278; Sun, 18 Jan 2004 11:53:27 +0900 (JST)
Received: 4UMRO00 id i0I2rOj29259; Sun, 18 Jan 2004 11:53:25 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sun, 18 Jan 2004 11:53:21 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Christoph Hellwig <hch@lst.de>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][2.6] Update NEC VRC4171 PCMCIA driver
Message-Id: <20040118115321.5ab75e5e.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040116123352.GA13006@lst.de>
References: <20040116083821.6b65c69f.yuasa@hh.iij4u.or.jp>
	<20040116123352.GA13006@lst.de>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Fri, 16 Jan 2004 13:33:52 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jan 16, 2004 at 08:38:21AM +0900, Yoichi Yuasa wrote:
> > +static int pccard_register_callback(unsigned int slot,
> > +                                    void (*handler)(void *, unsigned int),
> > +                                    void *info)
> > +{
> > +	vrc4171_socket_t *socket;
> > +
> > +	if (slot >= CARD_MAX_SLOTS)
> > +		return -EINVAL;
> > +
> > +	socket = &vrc4171_sockets[slot];
> > +
> > +	socket->handler = handler;
> > +	socket->info = info;
> > +
> > +	if (handler)
> > +		MOD_INC_USE_COUNT;
> > +	else
> > +		MOD_DEC_USE_COUNT;
> > +
> > +	return 0;
> > +}
> 
> This is most certainly wrong.  Module refcounting handling has moved one
> layer up in 2.6.
> 

Oops, I sent old one.
Wait a moment.

Yoichi
