Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA04774; Mon, 14 Apr 1997 11:06:45 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA13473 for linux-list; Mon, 14 Apr 1997 11:04:31 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.41]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA13370; Mon, 14 Apr 1997 11:04:16 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA10353; Mon, 14 Apr 1997 11:05:52 -0700
Date: Mon, 14 Apr 1997 11:05:52 -0700
Message-Id: <199704141805.LAA10353@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "David S. Miller" <davem@jenolan.rutgers.edu>
Cc: knobi@munich.sgi.com, alambie@wellington.sgi.com, shaver@neon.ingenia.ca,
        linux@cthulhu.engr.sgi.com
Subject: Re: init=/bin/sh and serial devices
In-Reply-To: <199704140817.EAA00522@jenolan.caipgeneral>
References: <334B3FF5.41C6@munich.sgi.com>
	<199704140817.EAA00522@jenolan.caipgeneral>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
 >    Date: Wed, 09 Apr 1997 09:06:29 +0200
 >    From: Martin Knoblauch <knobi@munich.sgi.com>
 > 
 >    do we already have drivers for the textport?
 > 
 > I wrote the text console driver for 24-bit Newport INDY frame buffers,
 > and it is in the SGI/Linux code.  I was never able to get around to
 > doing the 8-bit frame buffer card driver though, so if you've got one
 > of those in the INDY you are a out of luck for now.  (hinv -v from the
 > firmware prompt will tell you if you have the 24-bit or 8-bit card)
...

     Does the textport driver run in color-index mode?  If so, it will
probably work on the 8-bit card.  The cards are largely identical, except
for the depth of the frame buffer.
