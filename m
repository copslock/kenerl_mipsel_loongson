Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 15:42:21 +0100 (BST)
Received: from mercurio.srv.dsi.unimi.it ([IPv6:::ffff:159.149.130.201]:36760
	"EHLO mercurio.srv.dsi.unimi.it") by linux-mips.org with ESMTP
	id <S8226256AbVGEOmG>; Tue, 5 Jul 2005 15:42:06 +0100
Received: from thetys.sm.dsi.unimi.it (tethys.sm.dsi.unimi.it [159.149.132.22])
	by mercurio.srv.dsi.unimi.it (8.13.3/8.13.3) with ESMTP id j65EgI3K003674
	for <linux-mips@linux-mips.org>; Tue, 5 Jul 2005 16:42:18 +0200
From:	Arianna Arona <arianna@dsi.unimi.it>
To:	linux-mips@linux-mips.org
Subject: 2.6.12 does not read MAC address
Date:	Tue, 5 Jul 2005 16:43:09 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051643.09070.arianna@dsi.unimi.it>
X-DSI-MailScanner-Information: Please contact the staff for more information
X-DSI-MailScanner: Found to be clean
X-MailScanner-From: arianna@dsi.unimi.it
Return-Path: <arianna@dsi.unimi.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arianna@dsi.unimi.it
Precedence: bulk
X-list: linux-mips

Hi everybody,

my network problem are now due to MAC address.
Kernel does not read it and forcing the value via ifconfig does not solve the 
problem.

I need to merge the old driver, which detects MAC addr but eth0 link is down,
with the new one that does the contraty..... opsss.... I could have a not 
working at all driver.... :((

A.

-- 
Arianna Arona
Servizi Informatici
Dipartimento di Scienze dell'Informazione
Via Comelico 39
20135 Milano
