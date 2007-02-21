Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 12:57:18 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:19985 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037800AbXBUM5N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Feb 2007 12:57:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4F23CE1CAE;
	Wed, 21 Feb 2007 13:56:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3-ZafIbSTbb; Wed, 21 Feb 2007 13:56:32 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D4FB6E1C72;
	Wed, 21 Feb 2007 13:56:31 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l1LCuedl013520;
	Wed, 21 Feb 2007 13:56:40 +0100
Date:	Wed, 21 Feb 2007 12:56:36 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Kaz Kylheku <kaz@zeugmasystems.com>,
	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Clean up serial console support on Sibyte 1250 duart
In-Reply-To: <20070220181348.GA6049@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0702211242310.29504@blysk.ds.pg.gda.pl>
References: <66910A579C9312469A7DF9ADB54A8B7D627017@exchange.ZeugmaSystems.local>
 <20070220181348.GA6049@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90/2616/Wed Feb 21 11:36:16 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 20 Feb 2007, Ralf Baechle wrote:

> While that's strongly prefered I wasn't picky in this case because this
> driver only has a single job left to do - as a stop gap until there is
> a new driver for the drivers/serial subsystem.

 Which will be a funny exercise because of that AC97 codec hanging off one 
of the lines.  I guess it gives me enough incentive to put it on my to-do 
list for not such a distant future. ;-)

 It's a pity they did not wire the clock lines (TxC, RxC) to the serial 
port connectors (I guess PCB space was more important) -- it would have 
given me yet more incentive...

  Maciej
