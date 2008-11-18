Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:00:24 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:56806 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S23754228AbYKRWAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2008 22:00:16 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Interrupt routing issue on BCM1480.
Date:	Tue, 18 Nov 2008 14:00:08 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C50144C3F0@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Interrupt routing issue on BCM1480.
Thread-Index: AclJyQV1qAXifd8PSWmd9UFiQLEb5A==
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Hi guys,

Ralf's fixes in arch/mips/pci/pci-bcm1480.c break on our board. Multiple
devices somehow report the same pin number (or perhaps some invalid pin
number that is mapped to 1).  The mapping function then assigns IRQ 8 to
multiple devices.

The old ``return dev->irq'' in pcibios_map_irq worked fine.

What was the issue: is it that CFE sets up these IRQ numbers, such that
they might not correspond to pins?
