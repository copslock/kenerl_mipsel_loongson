Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jun 2005 23:57:01 +0100 (BST)
Received: from orb.pobox.com ([IPv6:::ffff:207.8.226.5]:18412 "EHLO
	orb.pobox.com") by linux-mips.org with ESMTP id <S8225260AbVFRW4p>;
	Sat, 18 Jun 2005 23:56:45 +0100
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id CD3451FB3
	for <linux-mips@linux-mips.org>; Sat, 18 Jun 2005 18:56:33 -0400 (EDT)
Received: from troglodyte.asianpear (c-24-21-141-200.hsd1.or.comcast.net [24.21.141.200])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 84BAD87
	for <linux-mips@linux-mips.org>; Sat, 18 Jun 2005 18:56:33 -0400 (EDT)
Subject: xxs1500 hangs on CF wifi card insertion
From:	Kevin Turner <kevin.m.turner@pobox.com>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Date:	Sat, 18 Jun 2005 15:57:17 -0700
Message-Id: <1119135438.1513.259.camel@troglodyte.asianpear>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Return-Path: <kevin.m.turner@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin.m.turner@pobox.com
Precedence: bulk
X-list: linux-mips

running linux-mips.org linux_2_4 CVS on an xxs1500, compiled with gcc
3.4.3 with Pete's 64bit_pcmcia.patch and the corresponding patch to
pcmcia-cs's copies of those include files.

When I insert my sandisk connectplus wifi card, the hostap drivers load
and start saying:

kernel: wifi0: Interrupt, but dev not OK
kernel: NET: 3067338 messages suppressed.

and the system is unresponsive until I eject the card.

With CONFIG_PM enabled, it seems to log somewhat fewer "Interrupt, but
dev not OK" messages but has a lot of 

huge offset 12c992, last_pc0 47e3e1 last_match20 47e3e1 pc0 5aad73
huge offset 12ca53, last_pc0 47e3e1 last_match20 47e3e1 pc0 5aae34

messages with continuously growing values.


here's the log prior to when it hangs:

cardmgr[247]: socket 0: SanDisk ConnectPlus w/ Memory
kernel: hostap_crypt: registered algorithm 'NULL'
kernel: hostap_cs: 0.3.7 - 2005-02-12 (Jouni Malinen <jkmaline@cc.hut.fi>)
kernel: hostap_cs: setting Vcc=33 (constant)
kernel: hostap_cs: CS_EVENT_CARD_INSERTION
kernel: hostap_cs: ignoring Vcc=33 (from config)
kernel: Checking CFTABLE_ENTRY 0x01 (default 0x01)
kernel: IO window settings: cfg->io.nwin=1 dflt.io.nwin=1
kernel: io->flags = 0x0047, io.base=0x0000, len=128
kernel: hostap_cs: Registered netdevice wifi0


Any suggestions?

Thanks,

 - Kevin

-- 
The moon is waxing gibbous, 83.5% illuminated, 10.8 days old.
