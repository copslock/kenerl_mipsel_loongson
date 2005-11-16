Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 12:05:38 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:30474 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133818AbVKPMFU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 12:05:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 48868E1C89;
	Wed, 16 Nov 2005 13:07:22 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02890-04; Wed, 16 Nov 2005 13:07:22 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id ED8A6E1C6E;
	Wed, 16 Nov 2005 13:07:21 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id jAGC7F0W028299;
	Wed, 16 Nov 2005 13:07:15 +0100
Date:	Wed, 16 Nov 2005 12:07:24 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems with Linux kernel on Broadcom SB1
In-Reply-To: <20051115204828.31990.qmail@web31501.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64N.0511161134020.7614@blysk.ds.pg.gda.pl>
References: <20051115204828.31990.qmail@web31501.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87/1176/Tue Nov 15 21:47:39 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 15 Nov 2005, Jonathan Day wrote:

> I've not been able to get any of the page sizes other
> than the 4K pages to work at all - it stops at boot,
> no error messages, just a straight lock-up. If this is
> a problem with the SB1, it might be wise to disable
> the changing of the page size for that processor.

 It's known broken for any processor.  The option is there for us to 
remember to fix it one day. ;-)

  Maciej
