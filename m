Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 21:53:41 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:59658 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225984AbULAVxg>; Wed, 1 Dec 2004 21:53:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 47C22F59C6; Wed,  1 Dec 2004 22:53:30 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31859-02; Wed,  1 Dec 2004 22:53:30 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id ACD0BF59BB; Wed,  1 Dec 2004 22:53:28 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB1LrixQ003396;
	Wed, 1 Dec 2004 22:53:44 +0100
Date: Wed, 1 Dec 2004 21:53:32 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
In-Reply-To: <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
 <16813.39660.948092.328493@doms-laptop.algor.co.uk>
 <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/605/Wed Nov 24 15:09:47 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Dec 2004, Thiemo Seufer wrote:

> The compiler was improved with PIC code in mind. The kernel is
> non-PIC, and can't allow explicit relocs by the compiler because
> of the weird code model used for 64bit kernels. This led to some
> degradation and even subtle failures for inline assembly code which
> relies on assumptions about earlier compiler's behaviour.

 What do you mean by "the weird code model" and what failures have you 
observed?  I think the bits are worth being done correctly, so I'd like 
to know what problems to address.

  Maciej
