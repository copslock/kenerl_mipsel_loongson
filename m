Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 16:59:55 +0000 (GMT)
Received: from host94-201-dynamic.14-87-r.retail.telecomitalia.it ([87.14.201.94]:37760
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20030567AbXKEQ7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 16:59:47 +0000
Received: from casa ([192.168.2.34] helo=eppesuigoccas.homedns.org)
	by eppesuigoccas.homedns.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ip5Fa-00011e-Gi
	for linux-mips@linux-mips.org; Mon, 05 Nov 2007 17:56:36 +0100
Received: from giuseppe by eppesuigoccas.homedns.org with local (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ip5E3-00016H-Qs
	for linux-mips@linux-mips.org; Mon, 05 Nov 2007 17:54:59 +0100
Subject: Re: 2.6.24-rc1 does not boot on SGI
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <1194268551.4842.3.camel@scarafaggio>
References: <1193468825.7474.6.camel@scarafaggio>
	 <20071029.000713.59464443.anemo@mba.ocn.ne.jp>
	 <1193599031.14874.1.camel@scarafaggio>
	 <20071029150625.GB4165@linux-mips.org>
	 <1194268551.4842.3.camel@scarafaggio>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 05 Nov 2007 17:54:59 +0100
Message-Id: <1194281699.4192.3.camel@casa>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno lun, 05/11/2007 alle 14.15 +0100, Giuseppe Sacco ha scritto:
[...]
> The latest git update, gave a bootable 2.6.24-rc1 but now, while
> booting, the system start looping and calling function print_irq_desc()
> from kernel/irq/internals.h. I can only read "...count:...unhandled:..."
[...]

Here it is:

sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:4:0: Attached scsi CD-ROM sr0
mice: PS/2 mouse device common for all mice
irq 13, desc: ffffffff804486e0, depth: 1, count: 0, unhandled: 0
->handle_irq():  ffffffff800663c0, handle_bad_irq+0x0/0x2c0
->chip(): ffffffff8043e320, 0xffffffff8043e320
->action(): 0000000000000000
  IRQ_DISABLED set
unexpected IRQ # 13
irq 13, desc: ffffffff804486e0, depth: 1, count: 0, unhandled: 0
->handle_irq():  ffffffff800663c0, handle_bad_irq+0x0/0x2c0
->chip(): ffffffff8043e320, 0xffffffff8043e320
->action(): 0000000000000000
  IRQ_DISABLED set
unexpected IRQ # 13


and keep printing about interrupt #13. The log from the start is
available here
http://eppesuigoccas.homedns.org/~giuseppe/debian/sgi-2.6.24-rc1-unexpted-irq13.log.bz

Bye,
Giuseppe
