Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 17:20:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7940 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021652AbXGKQUH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 17:20:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 30CB0E1D02;
	Wed, 11 Jul 2007 18:19:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dWhZlsNfE5A5; Wed, 11 Jul 2007 18:19:31 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BF6B8E1C67;
	Wed, 11 Jul 2007 18:19:31 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6BGJcMU020867;
	Wed, 11 Jul 2007 18:19:38 +0200
Date:	Wed, 11 Jul 2007 17:19:36 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org, sibyte-users@bitmover.com,
	Mark Mason <mason@broadcom.com>
Subject: Re: [PATCH][CFT] Move SB1250 DUART support to the serial subsystem
In-Reply-To: <20070711155021.GA26548@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0707111712100.26459@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0707111206200.26459@blysk.ds.pg.gda.pl>
 <20070711155021.GA26548@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3635/Wed Jul 11 13:30:51 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jul 2007, Ralf Baechle wrote:

> How far do you trust this driver?  Unless the answer is "not as far as
> I can throw a hardcopy of the code on marble" I suggest you feed this

 As much as I would trust myself to be coherent.  Is that a compatible 
answer?

 Honestly I would not mind if somebody tested it with some real as opposed 
to toy use.  SLIP or PPP would qualify; checking against a modem would be 
a good idea too.

> driver upstream ASAP such that Sibyte can finally become usable from
> kernel.org.  I don't mind keeping this old driver in the lmo git tree
> for another while.

 Except it is unlikely to work if build at all after the changes to the 
headers anymore.  Though that could be trivially dealt with if somebody 
really admires the old code (no, I am not going to do that).

  Maciej
