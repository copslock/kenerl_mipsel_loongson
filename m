Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:24:40 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:47367 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226154AbULBAYc>; Thu, 2 Dec 2004 00:24:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C51D9E1C94; Thu,  2 Dec 2004 01:24:25 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01510-01; Thu,  2 Dec 2004 01:24:25 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5F4DDE1C61; Thu,  2 Dec 2004 01:24:25 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB20OhlV014221;
	Thu, 2 Dec 2004 01:24:44 +0100
Date: Thu, 2 Dec 2004 00:24:30 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] tlbwr hazard for NEC VR4100
In-Reply-To: <20041202000713.GO3225@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.58L.0412020019050.20966@blysk.ds.pg.gda.pl>
References: <20041201234943.584d88e8.yuasa@hh.iij4u.or.jp>
 <20041202000713.GO3225@rembrandt.csv.ica.uni-stuttgart.de>
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
X-archive-position: 6535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Dec 2004, Thiemo Seufer wrote:

> If 64bit kernels are ever relevant for VR41xx, you might want to use
> the same branch trick as it is used for R4[04]00. IIRC it reduced the
> handler size from 34 to 30 instructions, saving another branch.

 Isn't that based on specific properties of the R4[04]00 pipeline?  It may
still work for the VR41xx, but you can't take it for granted, so it should
be double-checked.  Given the conditions it's probably worth the hassle,
though.

  Maciej
