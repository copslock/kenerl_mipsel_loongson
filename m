Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 11:54:37 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:45581 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbULBLyc>; Thu, 2 Dec 2004 11:54:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EB08EF59CE; Thu,  2 Dec 2004 12:54:23 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30369-03; Thu,  2 Dec 2004 12:54:23 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7CACFF59CD; Thu,  2 Dec 2004 12:54:23 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB2BsU02015745;
	Thu, 2 Dec 2004 12:54:30 +0100
Date: Thu, 2 Dec 2004 11:54:24 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Stephen P. Becker" <geoman@gentoo.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
In-Reply-To: <41AEFCF8.2020804@gentoo.org>
Message-ID: <Pine.LNX.4.58L.0412021151100.11480@blysk.ds.pg.gda.pl>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
 <16813.39660.948092.328493@doms-laptop.algor.co.uk>
 <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl>
 <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de>
 <16814.52180.502747.597080@doms-laptop.algor.co.uk>
 <20041202083859.GU3225@rembrandt.csv.ica.uni-stuttgart.de> <41AEFCF8.2020804@gentoo.org>
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
X-archive-position: 6546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Dec 2004, Stephen P. Becker wrote:

> For what it's worth, I'm running 64-bit kernels on my O2 and Indy that 
> were compiled with gcc 3.4.3, and I have had no problems.

 Have you used CONFIG_BUILD_ELF64 or not?  The former obviously works for
me; it's the latter that may cause troubles.

  Maciej
