Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2003 07:19:09 +0000 (GMT)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:51599
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225073AbTCSHTI>; Wed, 19 Mar 2003 07:19:08 +0000
Received: from mail.inspiretech.com (mail.inspiretech.com [150.1.1.1])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h2J7YeQm029902
	for <linux-mips@linux-mips.org>; Wed, 19 Mar 2003 13:04:43 +0530
Message-Id: <200303190734.h2J7YeQm029902@smtp.inspirtek.com>
Received: from WorldClient [150.1.1.1] by inspiretech.com [150.1.1.1]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Wed, 19 Mar 2003 12:41:52 +0530
Date: Wed, 19 Mar 2003 12:41:50 +0530
From: "Ashish anand" <ashish.anand@inspiretech.com>
To: linux-mips@linux-mips.org
Subject: PCI status error 0x2a80..
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 150.1.1.1
X-Return-Path: ashish.anand@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <ashish.anand@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish.anand@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,
I am experiencing the PCI bus error for a network card(Realtek 8139)
operation.
whenever it tries to transmit packets it prints the error like

eth0: PCI Bus error 0x2a80.

PCI status 0x2a80 as per pci specs suggests pci master and target
abort.
other basic infrastructures like  interupts , pci-dma and cards pci
resources are well in place.also i am able to receive all packets.
I have ensured other pci config registers like Latency timer and
command register are initialised to appropiate values.
pci command has been set to 0x7  ( io + mem + busmaster).

1.what can be other reasons for this to happen ..?

2.if pci master and target abort happens how the card is able to recive
the packets..?

3.does this situation demand pci debugging or driver level debugging?

Best Regards,
Ashish Anand
