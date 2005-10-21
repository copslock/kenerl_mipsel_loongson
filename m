Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 14:19:23 +0100 (BST)
Received: from wbmler1.mail.xerox.com ([13.13.138.216]:64673 "EHLO
	wbmler1.mail.xerox.com") by ftp.linux-mips.org with ESMTP
	id S8133440AbVJUNTG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2005 14:19:06 +0100
Received: from wbmlir1.mail.xerox.com (wbmlir1.mail.xerox.com [13.131.8.221])
	by wbmler1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9LDJ40P019237
	for <linux-mips@linux-mips.org>; Fri, 21 Oct 2005 09:19:05 -0400
Received: from wbmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9LDIEbt001565
	for <linux-mips@linux-mips.org>; Fri, 21 Oct 2005 09:18:14 -0400
Received: from usa7061gw02.na.xerox.net (usa7061gw02.na.xerox.net [13.151.32.4])
	by wbmlir1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9LDHvuW001186
	for <linux-mips@linux-mips.org>; Fri, 21 Oct 2005 09:18:14 -0400
Received: from usa0300bh01.na.xerox.net ([13.129.0.48]) by usa7061gw02.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 21 Oct 2005 06:18:07 -0700
Received: from gbrmiteubh01.eu.xerox.net ([13.223.7.13]) by usa0300bh01.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 21 Oct 2005 09:18:07 -0400
Received: from gbrwgceumf02.eu.xerox.net ([13.200.0.54]) by gbrmiteubh01.eu.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 21 Oct 2005 14:17:16 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: Re: au1x00 usb device status
Date:	Fri, 21 Oct 2005 14:17:08 +0100
Message-ID: <DAF42D2FFC65A146BAB240719E4AD214C212BF@gbrwgceumf02.eu.xerox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: au1x00 usb device status
Thread-Index: AcXWQQ+89WZDW1BoQe6vrK6DFON1sAAAIXgg
From:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 21 Oct 2005 13:17:16.0500 (UTC) FILETIME=[C1F1E140:01C5D641]
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <Ian.Hamilton@xerox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Hamilton@xerox.com
Precedence: bulk
X-list: linux-mips

Hi Pete and Rodolfo.

I also need to get the device USB port working on an au1100 board.

We have code running under a 2.4 kernel working on this board, and I'm
currently porting the code to a 2.6 kernel.

The USB device port seems to work OK for us with the 2.4 kernel.


Pete,

Is there a full description of the timing problem somewhere on the web?
In particular, how quickly does the interrupt need to be serviced?


Rodolfo,

Have you done any more work on this, or are you giving it up as a lost
cause?


Cheers,
Ian



On Thu, 2005-10-06 at 17:47 +0200, Rodolfo Giometti wrote:
> On Thu, Oct 06, 2005 at 08:32:52AM -0700, Pete Popov wrote:
> > USB Host should be working fine. USB Gadget on the
Au1000,1100,1500,1550
> > just won't happen due to hw limitations. USB host and gadget on the
1200
> 
> Thanks for your answer!
> 
> Can you please explain to me (in brief :) which hw limitations are you
> talking about? Do you mean that usb device support in Linux cannot be
> implemented, or just that this can be done but with some restriction?

Timing issues with the Au1x00 (not the au1200) make the Linux gadget
implementation extremely difficult to support. If you don't service the
usb interrupt within a certain amount of time, you lose the status and
the gadget loses its state.

Pete
