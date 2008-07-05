Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2008 08:04:38 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:43536 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20221205AbYGEHEd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Jul 2008 08:04:33 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B51AAD8E7; Sat,  5 Jul 2008 07:04:29 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0762A150F52; Sat,  5 Jul 2008 10:04:10 +0300 (IDT)
Date:	Sat, 5 Jul 2008 10:04:10 +0300
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: SGI O2 sound driver v6
Message-ID: <20080705070410.GA7384@deprecation.cyrius.com>
References: <20080628000916.GA22049@alpha.franken.de> <20080628141336.GA17727@alpha.franken.de> <20080628224553.GA2064@alpha.franken.de> <20080629223537.GA697@alpha.franken.de> <20080702232118.GB18226@alpha.franken.de> <20080704225106.GA7408@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080704225106.GA7408@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-07-05 00:51]:
> --- /dev/null
> +++ b/drivers/input/misc/sgio2_btns.c
> @@ -0,0 +1,154 @@
> +/*
> + *  Cobalt button interface driver.

You should update that text.
-- 
Martin Michlmayr
http://www.cyrius.com/
