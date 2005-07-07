Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 12:22:03 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:14596 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226288AbVGGLVq>; Thu, 7 Jul 2005 12:21:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 71761E1C85; Thu,  7 Jul 2005 13:22:11 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27741-01; Thu,  7 Jul 2005 13:22:11 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 24C58E1C84; Thu,  7 Jul 2005 13:22:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j67BMD7V031310;
	Thu, 7 Jul 2005 13:22:13 +0200
Date:	Thu, 7 Jul 2005 12:22:18 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	rolf liu <rolfliu@gmail.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: compiling error of linux 2.6.12 recent cvs head for db1550 using
 defconfig
In-Reply-To: <1120694886.5724.134.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0507071213480.3205@blysk.ds.pg.gda.pl>
References: <2db32b7205070616124fa47ef3@mail.gmail.com>
 <1120694886.5724.134.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/970/Wed Jul  6 18:00:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 6 Jul 2005, Pete Popov wrote:

> Maciej, I assume you built a kernel for one of the Au1x boards before
> you applied the patch ;)?

 Certainly not -- I don't maintain that part of the tree in any sense -- I 
don't even have any related hardware, so why should I bother?  I sent the 
patch for public review to let interested parties exactly to catch such 
problems -- I even mentioned explicitly I only did a minimal arrangement 
for the Au1000 code.

  Maciej
