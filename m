Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 18:28:34 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:47331 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S8133389AbWATS2O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 18:28:14 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1F013R-0001Ag-00; Fri, 20 Jan 2006 19:32:09 +0100
Subject: Re: Time slowing down while doing IDE PIO transfer
From:	Maxime Bizon <mbizon@freebox.fr>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1137780938.24161.25.camel@localhost.localdomain>
References: <1137777997.16631.147.camel@sakura.staff.proxad.net>
	 <1137780938.24161.25.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 20 Jan 2006 19:32:09 +0100
Message-Id: <1137781929.16631.155.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Fri, 2006-01-20 at 18:15 +0000, Alan Cox wrote:

> > This is I guess related to the interrupts being disabled during pio
> > transfer (I can't use unmaskirq btw).

> Silly question - but why not ?

It just doesn't work :)

Transfers stall and here is the kind of message I get:

hdb: lost interrupt
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hdb: drive not ready for command
hdb: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: drive not ready for command

-- 
Maxime
