Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 19:40:37 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:13841 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224936AbUKVTkc>; Mon, 22 Nov 2004 19:40:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B9495F59BD; Mon, 22 Nov 2004 20:40:25 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20206-05; Mon, 22 Nov 2004 20:40:25 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 513F5F59A8; Mon, 22 Nov 2004 20:40:25 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAMJedeI025245;
	Mon, 22 Nov 2004 20:40:40 +0100
Date: Mon, 22 Nov 2004 19:40:28 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-mips@linux-mips.org
Subject: Re: titan code question
In-Reply-To: <41A2234C.8090809@mvista.com>
Message-ID: <Pine.LNX.4.58L.0411221936220.31113@blysk.ds.pg.gda.pl>
References: <200411191623.14760.thomas.koeller@baslerweb.com>
 <41A2234C.8090809@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/590/Wed Nov 17 22:03:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 22 Nov 2004, Manish Lachwani wrote:

> Hence, they used this register. I am not sure if this is even 
> documented. However, this code has been written based on the feedback 
> from the chip designers. If you dont use this code, the MAC subsystem of 
> titan will stop aligning IP headers and you will need to implement the 
> code in the driver to do the aligning.

 That means you should use macros for registers and their contents,
preferably with some nearby documentation in the form of comments to
clarify less obvious bits.  Otherwise you end up with an unmaintainable
mess, especially once other sources of information drain out.

  Maciej
