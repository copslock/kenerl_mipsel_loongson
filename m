Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AHrdl08564
	for linux-mips-outgoing; Thu, 10 May 2001 10:53:39 -0700
Received: from web11904.mail.yahoo.com (web11904.mail.yahoo.com [216.136.172.188])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4AHrdF08561
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 10:53:39 -0700
Message-ID: <20010510175339.83183.qmail@web11904.mail.yahoo.com>
Received: from [209.243.184.191] by web11904.mail.yahoo.com; Thu, 10 May 2001 10:53:39 PDT
Date: Thu, 10 May 2001 10:53:39 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: Configuration of PCI Video card on a BIOS-less board
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   Pete Popov <ppopov@mvista.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.4.10.10105101919230.14224-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert, Pete,

Thanks for your input, it makes me question things I
should have questioned before.

0xC000 0000 is the actual address I am trying to use.
I used it because another PCI card that I have a
driver for was using it and so I just carried on its
use. I didnt really question the value or its use. But
obviously it works for that card.

After your emails I revisited that code and now I
partially understand why it works. The chip has an
internal bus that translates address requests
internally. So when i write to 0xC000 0000 it would
never make to the actual address lines of the chip and
instead be routed to the PCI controller ( I think :) )

The original card i had a problem had an ATI Rage
chip. I am now experimenting with a VGA card with a
Cirrus Logic chip. I've got this card to accept the
programmed base address and am in teh process of
studying clgenfb.c to see if I can modify it to my
needs. 
On first inspection clgenfb.c is written for the
Amiga??? and so I am trying to weed out the
dependencies. If anyone knows of a more generic driver
it would be much appreciated.

Wayne

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
