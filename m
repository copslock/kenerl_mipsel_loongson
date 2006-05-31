Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 13:27:40 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42255 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133506AbWEaL1c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 13:27:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 24AAFF640C;
	Wed, 31 May 2006 13:27:27 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10498-02; Wed, 31 May 2006 13:27:26 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B838AF5BEB;
	Wed, 31 May 2006 13:27:26 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4VBRYqU032348;
	Wed, 31 May 2006 13:27:34 +0200
Date:	Wed, 31 May 2006 12:27:30 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	art <art@sigrand.ru>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rongkai.zhan@windriver.com
Subject: Re: Problem with TLB mcheck!
In-Reply-To: <8751.060531@sigrand.ru>
Message-ID: <Pine.LNX.4.64N.0605311221470.29356@blysk.ds.pg.gda.pl>
References: <8751.060531@sigrand.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1500/Tue May 30 22:47:36 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 31 May 2006, art wrote:

> @@ -1260,7 +1260,7 @@
>         }
>  #endif
> 
> -       memcpy((void *)CAC_BASE, final_handler, 0x100);
> +       memcpy((void *)ebase, final_handler, 0x100);
> }
> 
> And it seem than no problem now (`cat /bin/busybox > box` work as much
> as need!).
> I think this is wright way, but not all - I'am not guru in memory
> subsystem and can miss something! So wait for your advices!

 That change has been in the tree since Apr 16th -- there is a reason you 
should always try the latest revision before reporting a problem.

  Maciej
