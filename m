Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2004 14:16:32 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.177]:2517 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225208AbUAPOQW> convert rfc822-to-8bit; Fri, 16 Jan 2004 14:16:22 +0000
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1AhUlo-0000OW-00
	for linux-mips@linux-mips.org; Fri, 16 Jan 2004 15:16:20 +0100
Received: from [80.129.131.133] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1AhUlo-0002ec-00
	for linux-mips@linux-mips.org; Fri, 16 Jan 2004 15:16:20 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
Organization: 4G Systems
To: linux-mips <linux-mips@linux-mips.org>
Subject: hang in setup_irq
Date: Fri, 16 Jan 2004 15:16:19 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401161516.19386.bruno.randolf@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d41044fba7cf33548d8f98fdbdd6d515
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello!

i have a mtx-1 system (mipsel kernel 2.4.21) with 2 mini-pci prism2 cards, 
both sharing the same interrupt. everything works fine when i power on
the system.

but when i reboot (without removing the power), the initialization of the 
driver (hostap) hangs in the function setup_irq before 
spin_unlock_irqrestore. this does not happen when the cards have seperate 
irqs or with only one card. what could be the problem?

bruno
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAB/Izfg2jtUL97G4RAiWKAJ0ctq3ixQWapHor5q3e8rtcwJNtDwCfS/Is
CV5n5t3W5MUpaGXcyaV0vvw=
=E7lR
-----END PGP SIGNATURE-----
