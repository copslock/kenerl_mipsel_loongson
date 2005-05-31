Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 15:51:00 +0100 (BST)
Received: from RT-soft-1.Moscow.itn.ru ([IPv6:::ffff:80.240.96.90]:62095 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225796AbVEaOuq>; Tue, 31 May 2005 15:50:46 +0100
Received: from 192.168.1.226 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j4VEoct06771;
	Tue, 31 May 2005 19:50:38 +0500
Subject: [PATCH]  PCI IDs for NEC VR5701-SG2 Board
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	mj@ucw.cz
Cc:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista
Date:	Tue, 31 May 2005 18:50:56 +0400
Message-Id: <1117551056.5564.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hi Martin!

Attached is PCI IDs for NEC VR5701-SG2 Board. The CPU is Vr5701, Vr5500
core. The CPU has internal IDE interface and USB interface with the same
device ID - 0000. The internal AC97 interface uses the same device ID as
VRC5477 system controller for AC97 interface. The board works with
Lynx3DM SM722 video adapter, Silicon Motion Inc. The Silicon Motion IDs
had been added to drivers/pci/pci.ids early. Please review it.

Best wishes,
Sergey Podstavin.
