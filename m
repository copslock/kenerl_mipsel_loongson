Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 14:50:22 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:3595 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225193AbUCVOuT>;
	Mon, 22 Mar 2004 14:50:19 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1B5Qdv-0003i0-00; Mon, 22 Mar 2004 14:43:07 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B5QkT-0004W3-00; Mon, 22 Mar 2004 14:49:53 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16478.64784.641483.359197@gladsmuir.mips.com>
Date: Mon, 22 Mar 2004 14:49:52 +0000
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <Pine.LNX.4.55.0403221153280.6539@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
	<1078478086.4308.14.camel@dzur.sfbay.redhat.com>
	<16456.21112.570245.1011@arsenal.mips.com>
	<Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
	<16473.44507.935886.271157@arsenal.mips.com>
	<Pine.LNX.4.55.0403181528130.5750@jurand.ds.pg.gda.pl>
	<16478.46344.410904.489262@doms-laptop.algor.co.uk>
	<Pine.LNX.4.55.0403221153280.6539@jurand.ds.pg.gda.pl>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.848, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej,

> > The 'di' is there to be atomic...
> 
>  Hmm, is the remaining minority of the OSes, that can't manage the
> sequence, important enough to add such an instruction?

Perhaps not.  The case I always suggest is that of a serial port
transmit interrupt handler, which often wants to disable the TxReady
interrupt when it finds there's no more data to send.  There's almost
always a way to do that without changing the SR interrupt mask, of
course... 

--
Dominic
