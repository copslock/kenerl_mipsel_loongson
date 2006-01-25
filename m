Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 11:12:57 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:51208 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133456AbWAYLMi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 11:12:38 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 16159F5B7F;
	Wed, 25 Jan 2006 12:16:56 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09547-10; Wed, 25 Jan 2006 12:16:55 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CF3A7F5B7E;
	Wed, 25 Jan 2006 12:16:55 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0PBGogO031909;
	Wed, 25 Jan 2006 12:16:50 +0100
Date:	Wed, 25 Jan 2006 11:16:58 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kaj-Michael Lang <milang@tal.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <Pine.LNX.4.61.0601251233020.4271@tori.tal.org>
Message-ID: <Pine.LNX.4.64N.0601251110480.7675@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.61.0601241147170.19397@tori.tal.org>
 <Pine.LNX.4.64N.0601241058390.11021@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.61.0601251233020.4271@tori.tal.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1248/Tue Jan 24 11:54:38 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Jan 2006, Kaj-Michael Lang wrote:

> And yes, the 3MIN does not have a free-running counter in the ASIC.
> (http://mail-index.netbsd.org/port-pmax/1995/01/28/0006.html)

 Well, that mail doesn't actually say anything about the 3MIN, but you can 
take my word anyway.

> Do still you take patches for 2.4 ? I'll try to find it.

 Possibly -- it depends on what the problem is.  If it stops a system from 
working, then certainly.

  Maciej
