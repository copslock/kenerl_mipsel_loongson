Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6T0EFH29480
	for linux-mips-outgoing; Sat, 28 Jul 2001 17:14:15 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6T0ECV29465
	for <linux-mips@oss.sgi.com>; Sat, 28 Jul 2001 17:14:13 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D881A881; Sun, 29 Jul 2001 02:14:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C6C9C4375; Sun, 29 Jul 2001 02:14:00 +0200 (CEST)
Date: Sun, 29 Jul 2001 02:14:00 +0200
From: Florian Lohoff <flo@rfc822.org>
To: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
Message-ID: <20010729021400.C6113@paradigm.rfc822.org>
References: <20010728214114.C27316@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010728214114.C27316@lug-owl.de>; from jbglaw@lug-owl.de on Sat, Jul 28, 2001 at 09:41:14PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 28, 2001 at 09:41:14PM +0200, Jan-Benedict Glaw wrote:
> However, the chip actually does not transmit the frame. Please look
> at it because I don't have a clue about the lance chip. Especially,
> I see there problems:
> 	- lp->tx_buf_ptr_lnc[i] and lp->rx_buf_ptr_lnc[i] are
> 	  quite low addresses. Is this correct? Are they relative
> 	  to some other address (TC slot address?)

If its a TC base address all addresses must be below 128*1024 as
a TC Slot IIRC has a 128K Window.

> 	- while kernel's bootp tries to send the packet, only
> 	  buffers [0] to [5] are used. Why are not all 16 buffers
> 	  used?

Split between TX and RX ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
