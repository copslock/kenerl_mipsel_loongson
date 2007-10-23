Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 17:57:53 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:58307 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20031454AbXJWQ5o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 17:57:44 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6C592400A5;
	Tue, 23 Oct 2007 18:57:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id ar8Wo8nwY4eL; Tue, 23 Oct 2007 18:57:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 431B140085;
	Tue, 23 Oct 2007 18:57:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9NGvhWA023323;
	Tue, 23 Oct 2007 18:57:44 +0200
Date:	Tue, 23 Oct 2007 17:57:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Discardable strings for init and exit sections
In-Reply-To: <20071012181544.GC6476@stusta.de>
Message-ID: <Pine.LNX.4.64N.0710231753250.8693@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl>
 <20071012171938.GB6476@stusta.de> <20071012175209.GA1110@linux-mips.org>
 <20071012181544.GC6476@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4573/Tue Oct 23 14:01:01 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 12 Oct 2007, Adrian Bunk wrote:

> - Most of the string annotations are (naturally) dev{init,exit}
>   annotations, and bugs there are therefore in configurations that have
>   only extremely low testing coverage during -rc.
> - I'm counting 22 annotations in the driver Maciej converted as an
>   example. When estimating the number of possible annotations based
>   on the number of C files in the kernel I'm getting a six digit
>   number.
> 
> No matter how hard it would be to teach gcc about it, when thinking of 
> the amount of __*init*/__*exit* bugs we already have I simply can't 
> imagine the string annotations as a maintainable solution.

 Well, it is up to the maintainer of code in question to get it right if 
interested.  Otherwise having no annotation and leaving the relevant 
strings resident in the memory throughout the lifespan of the system is a 
valid and perfectly working option.

 If you worry about the reverse case, where an annotation should be 
removed because the containing function is no longer __*init*/__*exit*, 
then I think `modpost' does a reasonably good job finding such places.

  Maciej
