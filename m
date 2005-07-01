Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 09:53:00 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:43022 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226129AbVGAIwn>; Fri, 1 Jul 2005 09:52:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EC3D1E1C8A; Fri,  1 Jul 2005 10:52:31 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05937-07; Fri,  1 Jul 2005 10:52:31 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BD33FE1C78; Fri,  1 Jul 2005 10:52:31 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j618qXCg008950;
	Fri, 1 Jul 2005 10:52:33 +0200
Date:	Fri, 1 Jul 2005 09:52:37 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: top and SMP
In-Reply-To: <20050630174556Z8226101-3678+737@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507010950310.30138@blysk.ds.pg.gda.pl>
References: <20050630174556Z8226101-3678+737@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/962/Fri Jul  1 07:19:05 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Jun 2005, Bryan Althouse wrote:

> I have tried to get top to display processor utilization on a per CPU basis,
> but to no avail.  Does anyone know how to get top to properly display
> statistics for a SMP system?  Better yet, does anyone know of a better
> utility than top?  

 Do you have a recent version of procps?

  Maciej
