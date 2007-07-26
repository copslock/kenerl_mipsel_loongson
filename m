Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2007 11:57:31 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:34315 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021730AbXGZK5Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jul 2007 11:57:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A1AC7E1C7C;
	Thu, 26 Jul 2007 12:57:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSHXBG9vWJsh; Thu, 26 Jul 2007 12:57:21 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5448CE1C64;
	Thu, 26 Jul 2007 12:57:21 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6QAvQWg001101;
	Thu, 26 Jul 2007 12:57:26 +0200
Date:	Thu, 26 Jul 2007 11:57:23 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Markus Gothe <markus.gothe@27m.se>
cc:	colin <colin@realtek.com.tw>, linux-mips@linux-mips.org
Subject: Re: [SPAM] Linux 2.6.12 cannot run on 24K. Please give me some clues.
In-Reply-To: <5C55354F-E857-4E83-A347-9C4A4EEA85E2@27m.se>
Message-ID: <Pine.LNX.4.64N.0707261151100.23854@blysk.ds.pg.gda.pl>
References: <014201c7cdc1$984e50c0$106215ac@realtek.com.tw>
 <5C55354F-E857-4E83-A347-9C4A4EEA85E2@27m.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3771/Thu Jul 26 05:55:34 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 26 Jul 2007, Markus Gothe wrote:

> Seems to me that running in EXkLusive/supervisor mode is the culprit. Try
> changing that before you get to userspace...

 Oopses always have either ERL or EXL set with an R4k-style cp0 status 
register as this is how these bits are handled by hardware when an 
exception happens.

 Now ffffff88 is obviously a wrong address, which looks like a negative 
offset from a null pointer, but it is up to the reporter to narrow it down 
well enough someone else can say anything about it.  Though as I say, I 
doubt anybody on this list cares of a piece of software that is two years 
old.

  Maciej
