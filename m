Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2004 12:34:04 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:4569 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8224893AbUAPMeA>;
	Fri, 16 Jan 2004 12:34:00 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i0GCXre6013050
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Jan 2004 13:33:53 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i0GCXqOw013048;
	Fri, 16 Jan 2004 13:33:52 +0100
Date: Fri, 16 Jan 2004 13:33:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2.6] Update NEC VRC4171 PCMCIA driver
Message-ID: <20040116123352.GA13006@lst.de>
References: <20040116083821.6b65c69f.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116083821.6b65c69f.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Fri, Jan 16, 2004 at 08:38:21AM +0900, Yoichi Yuasa wrote:
> +static int pccard_register_callback(unsigned int slot,
> +                                    void (*handler)(void *, unsigned int),
> +                                    void *info)
> +{
> +	vrc4171_socket_t *socket;
> +
> +	if (slot >= CARD_MAX_SLOTS)
> +		return -EINVAL;
> +
> +	socket = &vrc4171_sockets[slot];
> +
> +	socket->handler = handler;
> +	socket->info = info;
> +
> +	if (handler)
> +		MOD_INC_USE_COUNT;
> +	else
> +		MOD_DEC_USE_COUNT;
> +
> +	return 0;
> +}

This is most certainly wrong.  Module refcounting handling has moved one
layer up in 2.6.
