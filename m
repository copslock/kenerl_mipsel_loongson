Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Feb 2008 10:56:06 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:27525 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28575514AbYBUK4E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Feb 2008 10:56:04 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 741EA40091;
	Thu, 21 Feb 2008 11:56:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id ioopGQ0lgqR8; Thu, 21 Feb 2008 11:55:58 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E6F6440089;
	Thu, 21 Feb 2008 11:55:57 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m1LAu0Q0022611;
	Thu, 21 Feb 2008 11:56:00 +0100
Date:	Thu, 21 Feb 2008 10:55:56 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Does HIGHMEM work on 32-bit MIPS ports?
In-Reply-To: <47BC7D81.8030309@cisco.com>
Message-ID: <Pine.LNX.4.64N.0802211054590.28626@blysk.ds.pg.gda.pl>
References: <47BC7D81.8030309@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.92.1, clamav-milter version 0.92.1 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Feb 2008, David VomLehn wrote:

> Hmm, this is not good. I've got a MIPS 24Kc processor with a very awkward
> memory layout. Any hints?

 What does it mean "very awkward"?  What sort of problems do you have that 
you are trying to solve?

  Maciej
