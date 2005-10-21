Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 15:03:23 +0100 (BST)
Received: from wbmler1.mail.xerox.com ([13.13.138.216]:18375 "EHLO
	wbmler1.mail.xerox.com") by ftp.linux-mips.org with ESMTP
	id S3465587AbVJUODG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2005 15:03:06 +0100
Received: from wbmlir2.mail.xerox.com (wbmlir2.mail.xerox.com [13.131.8.222])
	by wbmler1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9LE33m3020807
	for <linux-mips@linux-mips.org>; Fri, 21 Oct 2005 10:03:03 -0400
Received: from wbmlir2.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir2.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9LE2NjN027828
	for <linux-mips@linux-mips.org>; Fri, 21 Oct 2005 10:02:23 -0400
Received: from usa7061gw02.na.xerox.net (usa7061gw02.na.xerox.net [13.151.32.4])
	by wbmlir2.mail.xerox.com (8.13.4/8.13.1) with ESMTP id j9LE1sCs027456
	for <linux-mips@linux-mips.org>; Fri, 21 Oct 2005 10:02:23 -0400
Received: from usa0300bh01.na.xerox.net ([13.129.0.48]) by usa7061gw02.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 21 Oct 2005 07:02:17 -0700
Received: from gbrmiteubh01.eu.xerox.net ([13.223.7.13]) by usa0300bh01.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 21 Oct 2005 10:02:10 -0400
Received: from gbrwgceumf02.eu.xerox.net ([13.200.0.54]) by gbrmiteubh01.eu.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 21 Oct 2005 15:01:37 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: au1x00 usb device status
Date:	Fri, 21 Oct 2005 15:01:35 +0100
Message-ID: <DAF42D2FFC65A146BAB240719E4AD214C212F3@gbrwgceumf02.eu.xerox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: au1x00 usb device status
Thread-Index: AcXWR/KSp4fbaApYRVCYVBrb6SSgvQ==
From:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 21 Oct 2005 14:01:37.0557 (UTC) FILETIME=[F40EF450:01C5D647]
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <Ian.Hamilton@xerox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Hamilton@xerox.com
Precedence: bulk
X-list: linux-mips

Hi Rodolfo.

> Are you implemented any Gadget support? Or are you just using the
> tty/raw emulation?

I'm a USB novice, so I'm not sure about this yet. The USB device port is
used
as a communication port to another board, so I guess a tty/raw emulation
would be appropriate, but I don't yet know how it was implemented on the
2.4
kernel. I'm still trying to understand the code.

I was hoping it would be a straight copy from 2.4 to 2.6, but clearly it
isn't :-(

Still, it is an opportunity to learn about USB :-)

Cheers,
Ian.
