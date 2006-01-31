Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 10:34:38 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:61400 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133489AbWAaKeU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 10:34:20 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 385C9C094
	for <linux-mips@linux-mips.org>; Tue, 31 Jan 2006 11:39:13 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id CA4361BC095
	for <linux-mips@linux-mips.org>; Tue, 31 Jan 2006 11:39:14 +0100 (CET)
Received: from kupljenlap (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id A1E001A18C2
	for <linux-mips@linux-mips.org>; Tue, 31 Jan 2006 11:39:14 +0100 (CET)
Subject: PCMCIA on AU1200
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 31 Jan 2006 11:39:13 +0100
Message-Id: <1138703953.7932.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

I am trying to use PCMCIA on a DBAU1200 with 16bit card.
>From the docs for the board, I see that the PCMCIA interface 
is on CE[3], but the value of the mem_staddr3 is
0x1000000.

Looking at the Linux source code, I see that the PCMCIA is
ioremap-ed to 0xf00000000 (36 bit). It also uses PSEUDO
addresses for the skt->phys_attr and skt->phys_mem.

At what (physical) address can I find the card's I/O space,
so I can use tools like devmem2 to see the cards CIS?
Should I configure mem_stadd3 to same other value?
To 0xf0000000?

BR,
Matej
