Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2006 00:25:59 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:43220 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038667AbWIGXZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2006 00:25:57 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 64-bit 2.6.17.7 SMP hangs in __cpu_up().
Date:	Thu, 7 Sep 2006 16:25:51 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D390152@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 64-bit 2.6.17.7 SMP hangs in __cpu_up().
Thread-Index: AcbS1PVG2vPyjOlUQySm6lGUUHn3SQ==
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Anyone seen anything like this?

Execution does not get past the loop:

  while (!cpu_isset(cpu, cpu_callin_map))
    udelay(100);

The other CPU is not coming up.

32 bit SMP works fine.

The board is a relative of the Broadcom BigSur. The processor CPU is the
1280, dual core.
