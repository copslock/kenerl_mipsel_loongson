Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 06:59:56 +0000 (GMT)
Received: from orb.pobox.com ([IPv6:::ffff:207.8.226.5]:21412 "EHLO
	orb.pobox.com") by linux-mips.org with ESMTP id <S8224893AbVA1G7k>;
	Fri, 28 Jan 2005 06:59:40 +0000
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id B9AA195
	for <linux-mips@linux-mips.org>; Fri, 28 Jan 2005 01:59:37 -0500 (EST)
Received: from troglodyte.asianpear (c-24-21-141-200.client.comcast.net [24.21.141.200])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 6812489
	for <linux-mips@linux-mips.org>; Fri, 28 Jan 2005 01:59:37 -0500 (EST)
Subject: pcmcia on au1x00
From:	Kevin Turner <kevin.m.turner@pobox.com>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 27 Jan 2005 22:59:35 -0800
Message-Id: <1106895575.4059.42.camel@troglodyte.asianpear>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Return-Path: <kevin.m.turner@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin.m.turner@pobox.com
Precedence: bulk
X-list: linux-mips

Compiling from current CVS:

  CC [M]  drivers/pcmcia/au1000_pb1x00.o
drivers/pcmcia/au1000_pb1x00.c:29:26: linux/tqueue.h: No such file or directory
drivers/pcmcia/au1000_pb1x00.c:42:28: pcmcia/bus_ops.h: No such file or directory
drivers/pcmcia/au1000_pb1x00.c:49:24: asm/au1000.h: No such file or directory
drivers/pcmcia/au1000_pb1x00.c:50:31: asm/au1000_pcmcia.h: No such file or directory
drivers/pcmcia/au1000_pb1x00.c:58:24: asm/pb1500.h: No such file or directory

What's the status of pcmcia on au1x00?
Selecting db1x00 instead of pb1x00 seems to compile cleanly.

Can you give me an idea of what'll be necessary to do to get pcmcia
working on a new Au1500-based board?

Thanks,

 - Kevin T.

-- 
The moon is waning gibbous, 94.6% illuminated, 17.0 days old.
