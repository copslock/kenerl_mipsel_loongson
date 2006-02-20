Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 16:55:24 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:47888 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133617AbWBTQzI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 16:55:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id AC022F598C;
	Mon, 20 Feb 2006 18:01:57 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12772-02; Mon, 20 Feb 2006 18:01:57 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6AA70F5965;
	Mon, 20 Feb 2006 18:01:57 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1KH1uFg029748;
	Mon, 20 Feb 2006 18:01:56 +0100
Date:	Mon, 20 Feb 2006 17:02:01 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: declance
In-Reply-To: <20060220142233.GA3743@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0602201701350.13723@blysk.ds.pg.gda.pl>
References: <20060219234318.GA16311@deprecation.cyrius.com>
 <20060220000141.GX10266@deprecation.cyrius.com> <20060220001724.GB17967@deprecation.cyrius.com>
 <20060220142233.GA3743@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88/1293/Sun Feb 19 17:40:25 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 20 Feb 2006, Martin Michlmayr wrote:

> Updated patch, please apply.
> 
> 
> [PATCH] Remove delta between Linus' and linux-mips git trees in declance
> 
> There are three changes between the Linus' and linux-mips git trees
> regarding the declaner driver.  The first change is certainly correct
> (as it is consistent with the rest of the file) and should be applied
> to mainline; the other change seems correct too.  And the third is
> cosmetic.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
