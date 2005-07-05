Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 12:05:33 +0100 (BST)
Received: from mercurio.srv.dsi.unimi.it ([IPv6:::ffff:159.149.130.201]:10207
	"EHLO mercurio.srv.dsi.unimi.it") by linux-mips.org with ESMTP
	id <S8226240AbVGELFN>; Tue, 5 Jul 2005 12:05:13 +0100
Received: from thetys.sm.dsi.unimi.it (tethys.sm.dsi.unimi.it [159.149.132.22])
	by mercurio.srv.dsi.unimi.it (8.13.3/8.13.3) with ESMTP id j65B5OKR019783
	for <linux-mips@linux-mips.org>; Tue, 5 Jul 2005 13:05:24 +0200
From:	Arianna Arona <arianna@dsi.unimi.it>
To:	linux-mips@linux-mips.org
Subject: IOC3 and kernel panic
Date:	Tue, 5 Jul 2005 13:06:15 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051306.15102.arianna@dsi.unimi.it>
X-DSI-MailScanner-Information: Please contact the staff for more information
X-DSI-MailScanner: Found to be clean
X-MailScanner-From: arianna@dsi.unimi.it
Return-Path: <arianna@dsi.unimi.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arianna@dsi.unimi.it
Precedence: bulk
X-list: linux-mips

I have some news.

executing:
# ifconfgi eth0 down
#ifconfig eth0 up

I have:

kernel panic - not syncing: could not identify cpu/level for irq 2

boot params were: bootp(): root=/dev/sdb1 nosmp

A.

-- 
Arianna Arona
Servizi Informatici
Dipartimento di Scienze dell'Informazione
Via Comelico 39
20135 Milano
