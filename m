Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2005 13:43:19 +0100 (BST)
Received: from mercurio.srv.dsi.unimi.it ([IPv6:::ffff:159.149.130.201]:65234
	"EHLO mercurio.srv.dsi.unimi.it") by linux-mips.org with ESMTP
	id <S8226154AbVGDMnC>; Mon, 4 Jul 2005 13:43:02 +0100
Received: from thetys.sm.dsi.unimi.it (tethys.sm.dsi.unimi.it [159.149.132.22])
	by mercurio.srv.dsi.unimi.it (8.13.3/8.13.3) with ESMTP id j64Ch91r030678
	for <linux-mips@linux-mips.org>; Mon, 4 Jul 2005 14:43:09 +0200
From:	Arianna Arona <arianna@dsi.unimi.it>
To:	linux-mips@linux-mips.org
Subject: IOC3 not working on SGI O2K
Date:	Mon, 4 Jul 2005 14:44:00 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507041444.00289.arianna@dsi.unimi.it>
X-DSI-MailScanner-Information: Please contact the staff for more information
X-DSI-MailScanner: Found to be clean
X-MailScanner-From: arianna@dsi.unimi.it
Return-Path: <arianna@dsi.unimi.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arianna@dsi.unimi.it
Precedence: bulk
X-list: linux-mips

Hi everybody,

I have a SGI O2K, and I'm trying to install linux.
I've downloaded vmlinux.ip27-20040428 from 
http://www.total-knowledge.com/progs/mips/kernels/ and it boots and mount a 
local root file system.
IOC3 ethernet card doesn't work.

Here are boot logs:
[.....]
[33] 0:1 0; <6> eth%d: link down 0000000004e00791
[.....]
[63] 0:1 0; 725e700004e00791
Found DS1981U NIC registration number 07:e0:04:70:5e, CRC 72.
Ethernet address is 08:00:69:0d:16:00
eth0: link down
eth0: using PHY 0, vendor 0x2000, model 0, rev 3.
eth0: IOC3 SSRAm has 128Kbytes.


IOC3 is on a board with 2 consoles and a SCSI port.
Could be this the problem? Is there any solution?

Thank you very much,
Arianna
-- 
Arianna Arona
Servizi Informatici
Dipartimento di Scienze dell'Informazione
Via Comelico 39
20135 Milano
