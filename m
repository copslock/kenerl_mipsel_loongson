Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 16:55:37 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:59009
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTDNPzh>; Mon, 14 Apr 2003 16:55:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3EFtSp18708;
	Mon, 14 Apr 2003 17:55:28 +0200
Date: Mon, 14 Apr 2003 17:55:28 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030414175528.C9808@linux-mips.org>
References: <20030413152226.GB1968@excalibur.cologne.de> <Pine.GSO.3.96.1030414134631.24742A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030414134631.24742A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 14, 2003 at 01:57:01PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2003 at 01:57:01PM +0200, Maciej W. Rozycki wrote:

>  I find it bogus to include <linux/smp.h> in code that has no slightest
> possibility to ever meet an SMP configuration.  I think <asm/processor.h>
> should be fixed instead.
> 
>  Following is a fix -- Ralf, I hope that's OK.

I completly agree.  Without your patch it's just a question of time until
we hit more build problems.

  Ralf
