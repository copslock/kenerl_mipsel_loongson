Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 12:18:50 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:54735 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022792AbXFNLSs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2007 12:18:48 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HynLj-00064s-00; Thu, 14 Jun 2007 13:18:47 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2EE14DE3F5; Thu, 14 Jun 2007 13:17:48 +0200 (CEST)
Date:	Thu, 14 Jun 2007 13:17:48 +0200
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Message-ID: <20070614111748.GA8223@alpha.franken.de>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164023940-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11818164023940-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Jun 14, 2007 at 12:19:59PM +0200, Franck Bui-Huu wrote:
>  arch/mips/sni/a20r.c                      |    1 -
>  arch/mips/sni/ds1216.c                    |    4 +-
>  arch/mips/sni/pcimt.c                     |    3 -
>  arch/mips/sni/pcit.c                      |    3 -
>  arch/mips/sni/rm200.c                     |    2 -
>  arch/mips/sni/time.c                      |    2 +-

the SNI part is broken and can't work that way.

1. SNI used two different RTC chips (ds126 and mc146818) and it's no big
   deal support them in just one kernel with the current framework 
2. One line of SNI machines (a20r) can't use the cp0 counter, so it's not
   a really good idea to calibrate it

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
