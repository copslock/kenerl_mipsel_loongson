Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V74WG05622
	for linux-mips-outgoing; Tue, 31 Jul 2001 00:04:32 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V74VV05619
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 00:04:31 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA22597;
	Tue, 31 Jul 2001 09:03:19 +0200 (MET DST)
Date: Tue, 31 Jul 2001 09:03:18 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <20010728214114.C27316@lug-owl.de>
Message-ID: <Pine.GSO.4.21.0107310902210.976-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 28 Jul 2001, Jan-Benedict Glaw wrote:
> However, the chip actually does not transmit the frame. Please look
> at it because I don't have a clue about the lance chip. Especially,
> I see there problems:
> 	- lp->tx_buf_ptr_lnc[i] and lp->rx_buf_ptr_lnc[i] are
> 	  quite low addresses. Is this correct? Are they relative
> 	  to some other address (TC slot address?)

Are these the addresses that link the ring buffers? If yes, they are adresses
from the LANCE's point of view.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
