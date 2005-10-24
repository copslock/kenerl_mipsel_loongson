Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2005 10:42:34 +0100 (BST)
Received: from wvmler3.mail.xerox.com ([13.8.138.218]:18352 "EHLO
	wvmler3.mail.xerox.com") by ftp.linux-mips.org with ESMTP
	id S3465639AbVJXJmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Oct 2005 10:42:06 +0100
Received: from wvmlir1.mail.xerox.com (wvmlir1.mail.xerox.com [13.147.8.221])
	by wvmler3.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9O9g11k026437;
	Mon, 24 Oct 2005 02:42:04 -0700
Received: from wvmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wvmlir1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9O9f8wx017064;
	Mon, 24 Oct 2005 02:41:08 -0700
Received: from usa7061gw02.na.xerox.net (usa7061gw02.na.xerox.net [13.151.32.4])
	by wvmlir1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9O9emGD016893;
	Mon, 24 Oct 2005 02:41:04 -0700
Received: from usa7061bh01.na.xerox.net ([13.151.33.5]) by usa7061gw02.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 24 Oct 2005 02:40:55 -0700
Received: from gbrmiteubh01.eu.xerox.net ([13.223.7.13]) by usa7061bh01.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 24 Oct 2005 02:40:55 -0700
Received: from gbrwgceumf02.eu.xerox.net ([13.200.0.54]) by gbrmiteubh01.eu.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 24 Oct 2005 10:40:41 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: au1x00 usb device status
Date:	Mon, 24 Oct 2005 10:40:37 +0100
Message-ID: <DAF42D2FFC65A146BAB240719E4AD214C21486@gbrwgceumf02.eu.xerox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: au1x00 usb device status
Thread-Index: AcXWVMQyPe7uhDGcQgWYMoSNVdHwmACJvGdg
From:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
To:	"Dan Malek" <dan@embeddedalley.com>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 24 Oct 2005 09:40:41.0173 (UTC) FILETIME=[FF5D9850:01C5D87E]
Return-Path: <Ian.Hamilton@xerox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Hamilton@xerox.com
Precedence: bulk
X-list: linux-mips

Thanks Dan, that's very helpful.

I haven't seen anything in the drivers/usb/gadget directory which
looks like an au1100 driver, so if you could send me any code you
have, I'd be grateful :-)

Cheers,
Ian.

-----Original Message-----
From: Dan Malek [mailto:dan@embeddedalley.com] 
Sent: 21 October 2005 16:36
To: Hamilton, Ian
Cc: 'linux-mips@linux-mips.org' MIPS
Subject: Re: au1x00 usb device status


On Oct 21, 2005, at 9:17 AM, Hamilton, Ian wrote:

> Is there a full description of the timing problem somewhere on the
web?
> In particular, how quickly does the interrupt need to be serviced?

There are two major challenges (and many minor ones).
The major challenges are timing related.  First, the USB status
is not cumulative, if you can't service the interrupt within the
latency of the next status change, you lose. The second challenge
is the management of the data flow.  You need to turn around
DMA buffers very quickly, as the FIFO is small.  If you happen
to DMA a power of 2 size that matches what you just told the FIFOs,
you then have to also do a zero length DMA to properly terminate
the transfer on the USB.  To reduce the latency of DMA processing,
I was considering not using the general DMA functions, but
rather implementing custom versions of the DMA functions in
the USB driver.  This will reduce the latency window, but not
eliminate it.  Oh yeah, there is also an "old" and "new" version
of this peripheral in the Au1100.  The new one tried to address
some of the problems, and it helped a little.  If you code to
the "old" interface, I believe it will work on all silicon (with
challenges), but if you detect the new silicon it's a little easier
to meet the latency requirements.  However, I could always
find too many cases where the interrupt latency of Linux
just caused us to miss interrupts and lose the USB state.
The Gadget interface is really nice, but the additional
indirection of the software layers makes the problems
even more challenging.

Good Luck.  I've been there and don't care to visit again.


	-- Dan
