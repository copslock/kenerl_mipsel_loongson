Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2003 12:14:36 +0100 (BST)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:27520
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225211AbTEELOe>; Mon, 5 May 2003 12:14:34 +0100
Received: from mail.inspiretech.com (mail.inspiretech.com [192.168.42.3])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h45BUFSM004475
	for <linux-mips@linux-mips.org>; Mon, 5 May 2003 17:00:24 +0530
Message-Id: <200305051130.h45BUFSM004475@smtp.inspirtek.com>
Received: from WorldClient [192.168.42.3] by inspiretech.com [192.168.42.3]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Mon, 05 May 2003 16:36:45 +0530
Date: Mon, 05 May 2003 16:36:43 +0530
From: "Ashish anand" <ashish.anand@inspiretech.com>
To: linux-mips@linux-mips.org
Subject: Dma data is a byte stream..?
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 192.168.42.3
X-Return-Path: ashish.anand@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <ashish.anand@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish.anand@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,

I have a question regarding endianness bit in PCI bridge dma windiw
setting register.
regardless of this endianness bit setting my n/w card or other pci card
works..it can
only be possible if bus master treats the dma data as byte stream.

now questions are..
1> then why there is provision of a endiannness bit in pci bridge ..though
still i haven't
gone through the every bit of my manual.

2> if dma data is byte stream , then why there would be a aligmenmt
constraints for 
receive or transmit buffers in system memory..

Best Regards,
Ashish Anand
