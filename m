Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2005 16:23:42 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:21768 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225752AbVCRQXY>; Fri, 18 Mar 2005 16:23:24 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id CBF46E1CB6; Fri, 18 Mar 2005 17:23:17 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12482-08; Fri, 18 Mar 2005 17:23:17 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 64A3BE1C98; Fri, 18 Mar 2005 17:23:17 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j2IGNKSV009889;
	Fri, 18 Mar 2005 17:23:20 +0100
Date:	Fri, 18 Mar 2005 16:23:29 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] Cobalt 2/2: add support for Qube2700
In-Reply-To: <20050304151305.GA12169@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0503181622240.26991@blysk.ds.pg.gda.pl>
References: <20050301084138.GB2017@skeleton-jack> <20050304151305.GA12169@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 4 Mar 2005, Ralf Baechle wrote:

> > On Qube2700 Galileo hangs if we access slot #6.
> 
> Patch is ok.  Out of curiosity, is the reason known?

 See my comment about the commit and respective datasheets.

  Maciej
