Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 20:32:08 +0000 (GMT)
Received: from p508B7960.dip.t-dialin.net ([IPv6:::ffff:80.139.121.96]:20115
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225388AbULBUcE>; Thu, 2 Dec 2004 20:32:04 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB2KU0rI003973;
	Thu, 2 Dec 2004 21:30:00 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB2KU0h9003972;
	Thu, 2 Dec 2004 21:30:00 +0100
Date: Thu, 2 Dec 2004 21:30:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] Label misplacement on an XTLB refill handler split
Message-ID: <20041202203000.GB3459@linux-mips.org>
References: <Pine.LNX.4.61.0412021746590.15065@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412021746590.15065@perivale.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 02, 2004 at 06:03:35PM +0000, Maciej W. Rozycki wrote:

>   f4:	42000018 	eret

Not directly related but seeing the eret here reminded me that we're still
not handling the R4000PC/SC v2.2/v3.0 erratum 6 where returning from a
cache error exception handler to the eret instruction of another exception
handler that was just about to return to user mode was not being
treated properly.

In case you care ;-)

  Ralf
