Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2005 17:24:20 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:11534 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225210AbVERQYD>; Wed, 18 May 2005 17:24:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B83B7F5B1F; Wed, 18 May 2005 18:23:52 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20666-01; Wed, 18 May 2005 18:23:52 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6CAF9F597A; Wed, 18 May 2005 18:23:52 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j4IGNuoE023626;
	Wed, 18 May 2005 18:23:56 +0200
Date:	Wed, 18 May 2005 17:24:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Michael Belamina <belamina1@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: 64 bit kernel for BCM1250
In-Reply-To: <428B663C.7050308@avtrex.com>
Message-ID: <Pine.LNX.4.61L.0505181715070.19170@blysk.ds.pg.gda.pl>
References: <20050518080917.45521.qmail@web32501.mail.mud.yahoo.com>
 <428B663C.7050308@avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/886/Wed May 18 12:32:36 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 18 May 2005, David Daney wrote:

> I saw this with a 32 bit kernel (for a 32 bit target).  As far as I know, no
> 2.4.x kernels from linux-mips.org will work with gcc 3.4.x.

 That could actually be true -- I've been using GCC 4.0.0 for quite some 
time now (that includes CVS snapshots from before the release), so I have 
no slightest idea whether it's OK to use older versions. ;-)

> I have previously posted patches to this list that fixed the problem for me.
> Specifically I think the messages in this thread are relevant:
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=41AFDA18.2010906%40avtrex.com

 Hasn't one of the proposed fixes for the bug made its way to Linux in the 
end?  That would be regrettable...

  Maciej
